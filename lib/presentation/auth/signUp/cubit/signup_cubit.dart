import 'package:app_remision/domain/repository/auth_repository.dart';
import 'package:app_remision/presentation/auth/signUp/cubit/signup_state.dart';
import 'package:app_remision/presentation/auth/signUp/fields.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class SignUpCubit extends Cubit<SignUpFormState> {
  final AuthRepository _authRepository;
  SignUpCubit(this._authRepository) : super(SignUpFormState());
//! Repository functions

//! Form fucntions
  void nameChanged(String value) {
    final name = Name.dirty(value);
    emit(state.copyWith(
      name: name,
      isValidate: Formz.validate([name, state.email, state.password, state.phone]),
    ));
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      isValidate: Formz.validate([state.name, email, state.password, state.phone]),
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      isValidate: Formz.validate([state.name, state.email, password, state.phone]),
    ));
  }

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      isValidate: Formz.validate([state.name, state.email, state.password, phone]),
    ));
  }

  Future<void> submit() async {
    if (state.isValidate) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authRepository.signUp(
          state.email.value,
          state.password.value,
          state.name.value,
          state.phone.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on FirebaseException catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: e.message));
      } catch (e) {
        //TODO: CONSTANT TEXT
        emit(state.copyWith(status: FormzSubmissionStatus.failure, message: 'Error desconocido.'));
      }
    }
  }
}
