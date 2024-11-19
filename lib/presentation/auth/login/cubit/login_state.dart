import 'package:app_remision/presentation/auth/signUp/fields.dart';
import 'package:formz/formz.dart';

class LoginState {
  final Email email;
  final Password password;
  final FormzSubmissionStatus status;
  final bool isValidate;
  final String? message;

  LoginState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValidate = false,
    this.message,
  });

  LoginState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
    bool? isValidate,
    String? message,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValidate: isValidate ?? this.isValidate,
      message: message ?? this.message,
    );
  }
}
