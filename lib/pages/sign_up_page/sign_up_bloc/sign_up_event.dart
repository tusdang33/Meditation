part of 'sign_up_bloc.dart';

sealed class SignUpEvent {}

class SignUpByFacebook extends SignUpEvent {}

class SignUpByGoogle extends SignUpEvent {}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isPrivacyPolicyAccepted;

  SignUpSubmitted(
    this.email,
    this.password,
    this.confirmPassword,
    this.isPrivacyPolicyAccepted,
  );
} 