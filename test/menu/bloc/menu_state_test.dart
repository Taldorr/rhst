// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/menu/bloc/bloc.dart';

void main() {
  group('MenuState', () {
    test('supports value equality', () {
      expect(
        MenuState(),
        equals(
          const MenuState(),
        ),
      );
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(
          const MenuState(),
          isNotNull,
        );
      });
    });

    group('copyWith', () {
      test(
        'copies correctly '
        'when no argument specified',
        () {
          const menuState = MenuState(
            customProperty: 'My property',
          );
          expect(
            menuState.copyWith(),
            equals(menuState),
          );
        },
      );

      test(
        'copies correctly '
        'when all arguments specified',
        () {
          const menuState = MenuState(
            customProperty: 'My property',
          );
          final otherMenuState = MenuState(
            customProperty: 'My property 2',
          );
          expect(menuState, isNot(equals(otherMenuState)));

          expect(
            menuState.copyWith(
              customProperty: otherMenuState.customProperty,
            ),
            equals(otherMenuState),
          );
        },
      );
    });
  });
}
