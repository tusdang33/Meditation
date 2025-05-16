part of 'sign_up_bloc.dart';

sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {
  final bool isEmailLoading;
  final bool isFacebookLoading;
  final bool isGoogleLoading;

  SignUpLoading({
    this.isEmailLoading = false,
    this.isFacebookLoading = false,
    this.isGoogleLoading = false,
  });
}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);
}
