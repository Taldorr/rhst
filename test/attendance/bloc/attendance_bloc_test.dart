// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/attendance/bloc/bloc.dart';

void main() {
  group('AttendanceBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          AttendanceBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final attendanceBloc = AttendanceBloc();
      expect(attendanceBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<AttendanceBloc, AttendanceState>(
      'CustomAttendanceEvent emits nothing',
      build: AttendanceBloc.new,
      act: (bloc) => bloc.add(const CustomAttendanceEvent()),
      expect: () => <AttendanceState>[],
    );
  });
}
