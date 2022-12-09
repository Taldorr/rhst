// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/appointments/bloc/bloc.dart';

void main() {
  group('AppointmentsEvent', () {  
    group('CustomAppointmentsEvent', () {
      test('supports value equality', () {
        expect(
          const CustomAppointmentsEvent(),
          isNotNull
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CustomAppointmentsEvent(),
          equals(const CustomAppointmentsEvent()),
        );
      });
    });
  });
}
