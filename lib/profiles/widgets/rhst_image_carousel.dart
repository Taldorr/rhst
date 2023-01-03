import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:rhst/constants.dart';
import 'package:rhst/styles.dart';
import 'package:rhst/widgets/rhst_card.dart';
import 'package:rhst/widgets/rhst_resolved_image.dart';

import '../models/gallery_reference.dart';

class RHSTImageCarousel extends StatefulWidget {
  final List<GalleryReference> galleryRefs;
  final int slots;
  final bool canEdit;
  final void Function(int i) onTap;
  const RHSTImageCarousel({
    Key? key,
    this.galleryRefs = const [],
    required this.onTap,
    this.canEdit = false,
    this.slots = 5,
  }) : super(key: key);

  @override
  State<RHSTImageCarousel> createState() => _RHSTImageCarouselState();
}

class _RHSTImageCarouselState extends State<RHSTImageCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.slots,
          carouselController: _controller,
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            viewportFraction: 0.6,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
          itemBuilder: (context, index, _) {
            if (widget.galleryRefs.length > index) {
              return CarouselItem(
                path: widget.galleryRefs[index].path,
                onTap: widget.canEdit ? () => widget.onTap(index) : null,
              );
            } else {
              return CarouselItem(
                onTap: widget.canEdit ? () => widget.onTap(index) : null,
              );
            }
          },
        ),
        CarouselIndicator(
          slots: widget.slots,
          current: _current,
          onTap: (i) {
            _controller.animateToPage(i);
            setState(() => _current = i);
          },
        ),
      ],
    );
  }
}

class CarouselIndicator extends StatelessWidget {
  final int slots;
  final int current;
  final void Function(int i) onTap;
  const CarouselIndicator({
    Key? key,
    required this.slots,
    required this.onTap,
    required this.current,
  }) : super(key: key);

  _buildDot(int i) => GestureDetector(
      onTap: () => onTap(i),
      child: Container(
        width: 8,
        height: 8,
        margin: const EdgeInsets.all(Constants.defaultSpace),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: i == current ? RHSTColors.neutral[400] : RHSTColors.neutral[300],
        ),
      ));

  @override
  Widget build(BuildContext context) {
    final List<Widget> dots = [];
    for (var i = 0; i < slots; i++) {
      dots.add(_buildDot(i));
    }
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: dots);
  }
}

class CarouselItem extends StatelessWidget {
  final void Function()? onTap;
  final String? path;
  const CarouselItem({Key? key, this.path, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.defaultSpace),
      child: GestureDetector(
        onTap: onTap,
        child: RHSTCard(
          color: RHSTColors.neutral[200],
          child: SizedBox(
            height: 192,
            width: 192,
            child: path == null ? Image.asset("assets/icons/add.png") : ResolvedImage(path: path),
          ),
        ),
      ),
    );
  }
}
