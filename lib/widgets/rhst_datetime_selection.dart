import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/util/formatter.dart';
import 'package:rhst/widgets/rhst_card.dart';

import 'rhst_spacer.dart';

enum ActiveStates {
  date,
  time,
  none,
}

class RHSTDateTimeSelection extends StatefulWidget {
  final String name;
  final AssetImage? iconImage;
  final DateTime? initialValue;
  final bool onlyDays;
  final bool isEndSelection;
  const RHSTDateTimeSelection({
    Key? key,
    required this.name,
    this.initialValue,
    this.iconImage,
    this.onlyDays = false,
    this.isEndSelection = false,
  }) : super(key: key);

  @override
  State<RHSTDateTimeSelection> createState() => _RHSTDateTimeSelectionState();
}

class _RHSTDateTimeSelectionState extends State<RHSTDateTimeSelection> {
  ActiveStates activeField = ActiveStates.none;
  late DateTime initialFieldValue;

  DateTime _updateFieldValue(DateTime current, {DateTime? newDate, TimeOfDay? newTime}) {
    assert(newDate != null || newTime != null);
    DateTime result = current.copyWith();
    if (newDate != null) {
      result = result.copyWith(
        year: newDate.year,
        month: newDate.month,
        day: newDate.day,
      );
    } else {
      result = result.copyWith(
        hour: newTime!.hour,
        minute: newTime.minute,
      );
    }
    return result;
  }

  DateTime? valueTransformer(DateTime? raw) {
    if (raw != null && widget.onlyDays) {
      final purged = raw.copyWith(hour: 0, minute: 0);
      if (widget.isEndSelection) {
        // if only days are selected, the "until"-dateTime will be at 00:00h of that day but we want
        // to include it, so we return 00:00h of the next day instead
        return purged.add(const Duration(days: 1));
      }
      return purged;
    }
    return raw;
  }

  @override
  void initState() {
    final init = widget.initialValue ?? DateTime.now();

    initialFieldValue = init.copyWith(
      hour: init.minute > 30 ? init.hour + 1 : init.hour,
      minute: init.minute > 30 ? 0 : 30,
      second: 0,
      millisecond: 0,
      microsecond: 0,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<DateTime>(
        name: widget.name,
        initialValue: initialFieldValue,
        valueTransformer: valueTransformer,
        builder: (field) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () => setState(() => activeField = ActiveStates.date),
                child: VerticalDateCarousel(
                  isActive: activeField == ActiveStates.date,
                  iconImage: widget.iconImage,
                  value: field.value!.difference(DateTime.now()).inDays,
                  onChanged: (newVal) => field.didChange(
                    _updateFieldValue(field.value!, newDate: newVal),
                  ),
                ),
              ),
              if (!widget.onlyDays) const RHSTSpacer(2),
              if (!widget.onlyDays)
                GestureDetector(
                  onTap: () => setState(() => activeField = ActiveStates.time),
                  child: VerticalTimeCarousel(
                    isActive: activeField == ActiveStates.time,
                    value: (field.value!.hour * 2) + (field.value!.minute > 30 ? 2 : 1),
                    onChanged: (newVal) => field.didChange(
                      _updateFieldValue(field.value!, newTime: newVal),
                    ),
                  ),
                )
            ],
          );
        });
  }
}

class VerticalTimeCarousel extends StatelessWidget {
  final void Function(TimeOfDay newVal) onChanged;
  final int value;
  final bool isActive;
  VerticalTimeCarousel(
      {Key? key, required this.onChanged, this.isActive = false, required this.value})
      : super(key: key);

  final CarouselController _controller = CarouselController();

  List<TimeOfDay> _buildSelectableTimes() {
    List<TimeOfDay> selectableTimes = [];
    for (var i = 0; i < 24; i++) {
      selectableTimes.add(TimeOfDay(hour: i, minute: 0));
      selectableTimes.add(TimeOfDay(hour: i, minute: 30));
    }
    return selectableTimes;
  }

  Widget _buildItem(BuildContext context, TimeOfDay time) {
    return Text(
      "${time.format(context)} Uhr",
      style: Styles.paragraph.copyWith(fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectableTimes = _buildSelectableTimes();
    final items = selectableTimes.map((t) => _buildItem(context, t)).toList();
    return SizedBox(
      height: isActive ? 80 : 64,
      child: RHSTCard(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.defaultSpace * 2,
          vertical: Constants.defaultSpace * 1.5,
        ),
        child: isActive
            ? CarouselSlider(
                carouselController: _controller,
                items: items,
                options: CarouselOptions(
                  initialPage: value,
                  scrollDirection: Axis.vertical,
                  viewportFraction: 0.4,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.5,
                  onPageChanged: (index, _) => onChanged(selectableTimes[index]),
                ),
              )
            : Center(child: _buildItem(context, selectableTimes[value])),
      ),
    );
  }
}

class VerticalDateCarousel extends StatelessWidget {
  final void Function(DateTime newVal) onChanged;
  final AssetImage? iconImage;
  final int value;
  final bool isActive;
  const VerticalDateCarousel({
    Key? key,
    required this.onChanged,
    this.isActive = true,
    required this.value,
    this.iconImage,
  }) : super(key: key);

  static const int daysInAdvance = 7;

  List<DateTime> _buildSelectableTimes() {
    List<DateTime> selectableDays = [];
    final now = DateTime.now();
    for (var i = 0; i < daysInAdvance; i++) {
      selectableDays.add(now.add(Duration(days: i)));
    }
    return selectableDays;
  }

  Widget _buildItem(BuildContext context, DateTime date) {
    if (isActive) {
      return Text(
        DateFormat("EE,dd.MM.yyyy").format(date),
        style: Styles.footer.copyWith(fontWeight: FontWeight.w400),
        textAlign: TextAlign.center,
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat("EEEE").format(date),
            style: Styles.footer,
            textAlign: TextAlign.center,
          ),
          Text(
            DateFormat("dd.MM.yy").format(date),
            style: Styles.paragraph.copyWith(fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectableTimes = _buildSelectableTimes();
    final items = selectableTimes.map((t) => _buildItem(context, t)).toList();
    return SizedBox(
      height: isActive ? 80 : 64,
      child: RHSTCard(
        padding: const EdgeInsets.all(Constants.defaultSpace * 1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            iconImage != null
                ? ImageIcon(
                    iconImage,
                    color: RHSTColors.neutral[500],
                    size: isActive ? 16 : 20,
                  )
                : Container(),
            isActive
                ? Expanded(
                    child: CarouselSlider(
                      items: items,
                      options: CarouselOptions(
                        initialPage: value,
                        enableInfiniteScroll: false,
                        scrollDirection: Axis.vertical,
                        viewportFraction: 0.4,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.5,
                        onPageChanged: (index, _) => onChanged(selectableTimes[index]),
                      ),
                    ),
                  )
                : _buildItem(context, selectableTimes[value]),
          ],
        ),
      ),
    );
  }
}
