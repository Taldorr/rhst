import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension DateString on Timestamp {
  String toLocalString() {
    return "${DateFormat('dd.MM.yyyy HH:mm').format(toDate())} Uhr";
  }

  String toLocalDayString() {
    return "${DateFormat('dd. MMM HH:mm').format(toDate())} Uhr";
  }
}

extension DateTimeExtensions on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
    bool? isUtc,
  }) {
    return ((isUtc ?? this.isUtc) ? DateTime.utc : DateTime.new)(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}
