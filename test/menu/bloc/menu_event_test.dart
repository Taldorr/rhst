// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/menu/bloc/bloc.dart';

void main() {
  group('MenuEvent', () {  
    group('CustomMenuEvent', () {
      test('supports value equality', () {
        expect(
          const CustomMenuEvent(),
          isNotNull
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CustomMenuEvent(),
          equals(const CustomMenuEvent()),
        );
      });
    });
  });
}
