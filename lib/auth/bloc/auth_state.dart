// coverage:ignore-file

part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({this.user, this.settings, this.isLoading = false});

  final bool isLoading;

  // FirebaseAuth's User object of the currently signed in user
  final User? user;

  final UserSettings? settings;

  @override
  List<Object?> get props => [user, settings, isLoading];

  AuthState copyWith({
    User? user,
    UserSettings? settings,
    bool? isLoading,
  }) {
    return AuthState(
      user: user ?? this.user,
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// The initial state of AuthState
class AuthInitial extends AuthState {
  const AuthInitial() : super();
}
