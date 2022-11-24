// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rhst/attendance/attendance.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AttendanceBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => AttendanceBloc(),
          child: MaterialApp(home: AttendanceBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
