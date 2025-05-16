import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpSubmitted>(_onSignUpSubmitted);
    on<SignUpByFacebook>(_onSignUpByFacebook);
    on<SignUpByGoogle>(_onSignUpByGoogle);
  }

  Future<void> _onSignUpByFacebook(
    SignUpByFacebook event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading(isFacebookLoading: true));
    await Future.delayed(const Duration(seconds: 2)); 
    emit(SignUpSuccess());
  }

  Future<void> _onSignUpByGoogle(
    SignUpByGoogle event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading(isGoogleLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    emit(SignUpSuccess());
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmitted event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpLoading(isEmailLoading: true));

    // Validate email
    if (!_isValidEmail(event.email)) {
      emit(SignUpFailure('Please enter a valid email address'));
      return;
    }

    // Validate password
    if (event.password.length < 6) {
      emit(SignUpFailure('Password must be at least 6 characters'));
      return;
    }

    // Validate confirm password
    if (event.password != event.confirmPassword) {
      emit(SignUpFailure('Passwords do not match'));
      return;
    }

    // Validate privacy policy
    if (!event.isPrivacyPolicyAccepted) {
      emit(SignUpFailure('Please accept the Privacy Policy'));
      return;
    }

    try {
      // TODO: Implement actual sign up logic here
      // For now, we'll simulate a network delay
      await Future.delayed(const Duration(seconds: 2));

      // Simulate successful sign up
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure('Failed to sign up. Please try again.'));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
