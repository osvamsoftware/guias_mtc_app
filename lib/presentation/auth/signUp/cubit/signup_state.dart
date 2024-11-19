import 'package:app_remision/presentation/auth/signUp/fields.dart';
import 'package:formz/formz.dart';

class SignUpFormState {
  final Name name;
  final Email email;
  final Password password;
  final Phone phone;
  final FormzSubmissionStatus status;
  final bool isValidate;
  final String? message;

  SignUpFormState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.phone = const Phone.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValidate = false,
    this.message,
  });

  SignUpFormState copyWith({
    Name? name,
    Email? email,
    Password? password,
    Phone? phone,
    FormzSubmissionStatus? status,
    bool? isValidate,
    String? message,
  }) {
    return SignUpFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      isValidate: isValidate ?? this.isValidate,
      message: message ?? this.message,
    );
  }
}
