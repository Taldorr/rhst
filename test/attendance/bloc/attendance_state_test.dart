// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/attendance/bloc/bloc.dart';

void main() {
  group('AttendanceState', () {
    test('supports value equality', () {
      expect(
        AttendanceState(),
        equals(
          const AttendanceState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const AttendanceState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const attendanceState = AttendanceState(
            customProperty: 'My property',
          );
          expect(
            attendanceState.copyWith(),
            equals(attendanceState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const attendanceState = AttendanceState(
            customProperty: 'My property',
          );
          final otherAttendanceState = AttendanceState(
            customProperty: 'My property 2',
          );
          expect(attendanceState, isNot(equals(otherAttendanceState)));

          expect(
            attendanceState.copyWith(
              customProperty: otherAttendanceState.customProperty,
            ),
            equals(otherAttendanceState),
          );
        },
      );
    });
  });
}
