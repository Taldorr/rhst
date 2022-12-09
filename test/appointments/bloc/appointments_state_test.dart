// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/appointments/bloc/bloc.dart';

void main() {
  group('AppointmentsState', () {
    test('supports value equality', () {
      expect(
        AppointmentsState(),
        equals(
          const AppointmentsState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const AppointmentsState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const appointmentsState = AppointmentsState(
            customProperty: 'My property',
          );
          expect(
            appointmentsState.copyWith(),
            equals(appointmentsState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const appointmentsState = AppointmentsState(
            customProperty: 'My property',
          );
          final otherAppointmentsState = AppointmentsState(
            customProperty: 'My property 2',
          );
          expect(appointmentsState, isNot(equals(otherAppointmentsState)));

          expect(
            appointmentsState.copyWith(
              customProperty: otherAppointmentsState.customProperty,
            ),
            equals(otherAppointmentsState),
          );
        },
      );
    });
  });
}
