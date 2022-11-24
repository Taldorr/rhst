// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rhst/attendance/attendance.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AttendancePage', () {
    group('route', () {
      test('is routable', () {
        expect(AttendancePage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders AttendanceView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: AttendancePage()));
      expect(find.byType(AttendanceView), findsOneWidget);
    });
  });
}
