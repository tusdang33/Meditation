part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginByFacebook extends LoginEvent {}

class LoginByGoogle extends LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted(this.email, this.password);
}


