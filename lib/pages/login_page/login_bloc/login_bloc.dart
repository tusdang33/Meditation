import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mediation_app/di/di_instance.dart';
import 'package:mediation_app/domain/repository/auth_repo.dart';
import 'package:mediation_app/domain/result_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository = getIt<AuthRepository>();

  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LoginByFacebook>(_onLoginByFacebook);
    on<LoginByGoogle>(_onLoginByGoogle);
  }

  Future<void> _onLoginByFacebook(
    LoginByFacebook event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading(isFacebookLoading: true));
    (await _authRepository.signIn('', ''))
        .success((user) {
          emit(LoginSuccess());
        })
        .fail((error) {
          emit(LoginFailure(error ?? 'Failed to login. Please try again.'));
        });
    emit(LoginSuccess());
  }

  Future<void> _onLoginByGoogle(
    LoginByGoogle event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading(isGoogleLoading: true));
    (await _authRepository.signIn('', ''))
        .success((user) {
          emit(LoginSuccess());
        })
        .fail((error) {
          emit(LoginFailure(error ?? 'Failed to login. Please try again.'));
        });
    emit(LoginSuccess());
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading(isEmailLoading: true));

    // Validate email
    if (!_isValidEmail(event.email)) {
      emit(LoginFailure('Please enter a valid email address'));
      return;
    }

    // Validate password
    if (event.password.isEmpty) {
      emit(LoginFailure('Please enter your password'));
      return;
    }

    try {
      (await _authRepository.signIn(event.email, event.password))
          .success((user) {
            emit(LoginSuccess());
          })
          .fail((error) {
            emit(LoginFailure(error ?? 'Failed to login. Please try again.'));
          });
    } catch (e) {
      emit(LoginFailure('Failed to login. Please try again.'));
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
