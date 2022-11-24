// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rhst/menu/menu.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MenuBody', () {
    testWidgets('renders Text', (tester) async { 
      await tester.pumpWidget(
        BlocProvider(
          create: (context) => MenuBloc(),
          child: MaterialApp(home: MenuBody()),
        ),
      );

      expect(find.byType(Text), findsOneWidget);
    });
  });
}
