// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/appointments/bloc/bloc.dart';

void main() {
  group('AppointmentsBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          AppointmentsBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final appointmentsBloc = AppointmentsBloc();
      expect(appointmentsBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<AppointmentsBloc, AppointmentsState>(
      'CustomAppointmentsEvent emits nothing',
      build: AppointmentsBloc.new,
      act: (bloc) => bloc.add(const CustomAppointmentsEvent()),
      expect: () => <AppointmentsState>[],
    );
  });
}
