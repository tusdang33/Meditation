part of 'login_bloc.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  final bool isFacebookLoading;
  final bool isGoogleLoading;
  final bool isEmailLoading;

  LoginLoading({
    this.isFacebookLoading = false,
    this.isGoogleLoading = false,
    this.isEmailLoading = false,
  });
}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}
