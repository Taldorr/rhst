// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rhst/appointments/appointments.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppointmentsBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AppointmentsBloc(),
          child: MaterialApp(home: AppointmentsBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
