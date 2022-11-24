import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

extension DateString on Timestamp {
  String toLocalString() {
    return "${DateFormat('dd.MM.yyyy HH:mm').format(toDate())} Uhr";
  }
}
