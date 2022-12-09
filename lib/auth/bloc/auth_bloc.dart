import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:rhst/auth/repositories/auth_repository.dart';
import 'package:rhst/util/snackbar_service.dart';
import 'package:rhst/util/storage_service.dart';

import '../models/user_settings.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  StreamSubscription<User?>? _currentUserSub;

  AuthBloc(this._authRepository) : super(const AuthInitial()) {
    on<InitAuthEvent>(_onInitAuthEvent);
    on<UserUpdatedAuthEvent>(_onUserUpdatedAuthEvent);
    on<LoginAuthEvent>(_onLoginAuthEvent);
    on<ResetPasswordAuthEvent>(_onResetPasswordAuthEvent);
    on<LogoutAuthEvent>(_onLogoutAuthEvent);
    on<UpdateSettingsAuthEventEvent>(_onUpdateSettingsAuthEvent);
  }

  void _onInitAuthEvent(InitAuthEvent event, Emitter<AuthState> emit) {
    _currentUserSub = _authRepository.$currentUser.listen((currentUser) {
      add(UserUpdatedAuthEvent(currentUser));
    });
  }

  void _onUserUpdatedAuthEvent(UserUpdatedAuthEvent event, Emitter<AuthState> emit) async {
    if (event.user != null) {
      SnackbarService().display("Login erfolgreich");
      final settings = await _authRepository.loadSettings(event.user!.uid);
      emit(AuthState(user: event.user, settings: settings));
    } else {
      emit(AuthState(user: event.user));
    }
  }

  Future<void> _onLoginAuthEvent(LoginAuthEvent event, Emitter<AuthState> emit) async {
    try {
      await _authRepository.signInWithEmail(event.email, event.password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackbarService().display("Account existiert nicht", isError: true);
      } else if (e.code == 'wrong-password') {
        SnackbarService().display("Passwort falsch", isError: true);
      } else {
        SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
      }
    } catch (e) {
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
    }
  }

  Future<void> _onLogoutAuthEvent(LogoutAuthEvent event, Emitter<AuthState> emit) async {
    await _authRepository.signOut();
    SnackbarService().display("Logout erfolgreich");
  }

  Future<void> _onResetPasswordAuthEvent(
      ResetPasswordAuthEvent event, Emitter<AuthState> emit) async {
    await _authRepository.resetPassword(event.email);
    SnackbarService().display("Email versendet");
  }

  Future<void> _onUpdateSettingsAuthEvent(
      UpdateSettingsAuthEventEvent event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      _authRepository.updateSettings(state.user!.uid, event.settings);
      emit(state.copyWith(settings: event.settings, isLoading: false));
    } catch (e) {
      SnackbarService().display("Ein Fehler ist aufgetreten: $e", isError: true);
    }
  }

  void updateProfilePicture(String filePath) async {
    final userId = state.user!.uid;
    StorageService.uploadProfilePicture(userId, File(filePath))?.then((_) {
      add(UpdateSettingsAuthEventEvent(state.settings!));
    });
  }

  @override
  Future<void> close() {
    _currentUserSub?.cancel();
    return super.close();
  }
}
