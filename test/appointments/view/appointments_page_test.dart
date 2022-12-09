// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rhst/appointments/appointments.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppointmentsPage', () {
    group('route', () {
      test('is routable', () {
        expect(AppointmentsPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders AppointmentsView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AppointmentsPage()));
      expect(find.byType(AppointmentsView), findsOneWidget);
    });
  });
}
