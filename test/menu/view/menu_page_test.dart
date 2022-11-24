// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rhst/menu/menu.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MenuPage', () {
    group('route', () {
      test('is routable', () {
        expect(MenuPage.route(), isA<MaterialPageRoute>());
      });
    });

    testWidgets('renders MenuView', (tester) async {
      await tester.pumpWidget(MaterialApp(home: MenuPage()));
      expect(find.byType(MenuView), findsOneWidget);
    });
  });
}
