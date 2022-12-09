// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:rhst/settings/bloc/bloc.dart';

void main() {
  group('SettingsEvent', () {  
    group('CustomSettingsEvent', () {
      test('supports value equality', () {
        expect(
          const CustomSettingsEvent(),
          isNotNull
        );
      });
    });
    group('constructor', () {
      test('can be instantiated', () {
        expect(
          CustomSettingsEvent(),
          equals(const CustomSettingsEvent()),
        );
      });
    });
  });
}
