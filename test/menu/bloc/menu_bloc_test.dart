// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/menu/bloc/bloc.dart';

void main() {
  group('MenuBloc', () {
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          MenuBloc(),
          isNotNull,
        );
      });
    });

    test('initial state has default value for customProperty', () {
      final menuBloc = MenuBloc();
      expect(menuBloc.state.customProperty, equals('Default Value'));
    });

    blocTest<MenuBloc, MenuState>(
      'CustomMenuEvent emits nothing',
      build: MenuBloc.new,
      act: (bloc) => bloc.add(const CustomMenuEvent()),
      expect: () => <MenuState>[],
    );
  });
}
