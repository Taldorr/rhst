// coverage:ignore-file

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class InitAuthEvent extends AuthEvent {
  const InitAuthEvent();

  @override
  List<Object> get props => [];
}

class LoginAuthEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginAuthEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ResetPasswordAuthEvent extends AuthEvent {
  final String email;
  const ResetPasswordAuthEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class LogoutAuthEvent extends AuthEvent {
  const LogoutAuthEvent();

  @override
  List<Object> get props => [];
}

class UserUpdatedAuthEvent extends AuthEvent {
  final User? user;
  const UserUpdatedAuthEvent(this.user);

  @override
  List<Object> get props => [];
}
