import 'package:app_remision/domain/repository/auth_repository.dart';
import 'package:app_remision/presentation/auth/login/cubit/login_state.dart';
import 'package:app_remision/presentation/auth/signUp/fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginCubit(this._authRepository) : super(LoginState());

  //! Form functions
  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      isValidate: Formz.validate([email, state.password]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValidate: Formz.validate([state.email, password]),
    ));
  }

  Future<void> submit() async {
    if (state.isValidate) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authRepository.signIn(
          state.email.value,
          state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on FirebaseException catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Error desconocido.'));
      }
    }
  }
}
