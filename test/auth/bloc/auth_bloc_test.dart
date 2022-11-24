// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rhst/auth/bloc/bloc.dart';
import 'package:rhst/auth/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  final streamController = StreamController<User?>();

  @override
  Stream<User?> get $currentUser => streamController.stream;
}

class UserFake extends Fake implements User {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('AuthBloc', () {
    late AuthRepository authRepository;
    late AuthBloc authBloc;
    late User fakeUser;

    setUpAll(() {
      registerFallbackValue(UserFake());
      fakeUser = UserFake();
    });

    setUp(() async {
      authRepository = MockAuthRepository();
      authBloc = AuthBloc(authRepository);
    });

    group('constructor', () {
      test('can be instantiated', () {
        expect(authBloc, isNotNull);
      });
    });

    test('initial state has default value for user', () {
      expect(authBloc.state.user, equals(null));
    });

    blocTest<AuthBloc, AuthState>(
      'Login calls repository function',
      build: () => authBloc,
      act: (bloc) {
        bloc.add(InitAuthEvent());
        bloc.add(const LoginAuthEvent(email: "mock@test.de", password: "password"));
      },
      verify: (_) => verify(() => authRepository.signInWithEmail(any(), any())).called(1),
      expect: () => <AuthState>[],
    );

    blocTest<AuthBloc, AuthState>(
      'Login fails - wrong-password',
      build: () {
        when(() => authRepository.signInWithEmail(any(), any())).thenAnswer(
            (invocation) => Future.error(FirebaseAuthException(code: 'wrong-password')));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(InitAuthEvent());
        bloc.add(const LoginAuthEvent(email: "mock@test.de", password: "WrongPassword"));
      },
      expect: () => <AuthState>[],
    );
    blocTest<AuthBloc, AuthState>(
      'Login fails - user-not-found',
      build: () {
        when(() => authRepository.signInWithEmail(any(), any())).thenAnswer(
            (invocation) => Future.error(FirebaseAuthException(code: 'user-not-found')));
        return authBloc;
      },
      act: (bloc) {
        bloc.add(InitAuthEvent());
        bloc.add(const LoginAuthEvent(email: "mock@test.de", password: "WrongPassword"));
      },
      expect: () => <AuthState>[],
    );

    blocTest<AuthBloc, AuthState>(
      'UserUpdatedAuthEvent sets new state on stream change',
      build: () => authBloc,
      act: (bloc) {
        bloc.add(InitAuthEvent());
        (authRepository as MockAuthRepository).streamController.sink.add(fakeUser);
      },
      expect: () => <AuthState>[AuthState(user: fakeUser)],
    );

    blocTest<AuthBloc, AuthState>(
      'LogoutAuthEvent',
      build: () {
        when(() => authRepository.signOut()).thenAnswer((_) => Future.value());
        return authBloc..add(InitAuthEvent());
      },
      seed: () => AuthState(user: fakeUser),
      act: (bloc) {
        bloc.add(LogoutAuthEvent());
        (authRepository as MockAuthRepository).streamController.sink.add(null);
      },
      verify: (_) => verify(() => authRepository.signOut()).called(1),
      expect: () => <AuthState>[AuthState(user: null)],
    );
    blocTest<AuthBloc, AuthState>(
      'ResetPasswordAuthEvent',
      build: () {
        when(() => authRepository.resetPassword(any())).thenAnswer((_) => Future.value());
        return authBloc..add(InitAuthEvent());
      },
      act: (bloc) {
        bloc.add(ResetPasswordAuthEvent(email: "test@mock.de"));
      },
      verify: (_) => verify(() => authRepository.resetPassword(any())).called(1),
      expect: () => <AuthState>[],
    );
  });
}
