// coverage:ignore-file

part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({this.user});

  // FirebaseAuth's User object of the currently signed in user
  final User? user;

  @override
  List<Object?> get props => [user];

  AuthState copyWith({User? user}) {
    return AuthState(user: user ?? this.user);
  }
}

/// The initial state of AuthState
class AuthInitial extends AuthState {
  const AuthInitial() : super();
}
