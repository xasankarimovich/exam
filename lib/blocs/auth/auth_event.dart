import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String userName;

  RegisterRequested({
    required this.email,
    required this.password,
    required this.userName,
  });

  @override
  List<Object?> get props => [email, password];
}

class LogoutRequested extends AuthEvent {}

class InitialEvent extends AuthEvent {}
