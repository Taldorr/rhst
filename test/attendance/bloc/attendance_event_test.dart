// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/attendance/bloc/bloc.dart';

void main() {
  group('AttendanceEvent', () {  
    group('CustomAttendanceEvent', () {
      test('supports value equality', () {
        expect(
          const CustomAttendanceEvent(),
          isNotNull
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CustomAttendanceEvent(),
          equals(const CustomAttendanceEvent()),
        );
      });
    });
  });
}
