import 'package:formz/formz.dart';

class Name extends FormzInput<String, String> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El nombre no puede estar vacío';
  }
}

class Email extends FormzInput<String, String> {
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty && RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value) ? null : 'Email inválido';
  }
}

class Password extends FormzInput<String, String> {
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.length >= 6 ? null : 'La contraseña debe tener al menos 6 caracteres';
  }
}

class Phone extends FormzInput<String, String> {
  const Phone.pure() : super.pure('');
  const Phone.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty && RegExp(r'^\+?\d{8,15}$').hasMatch(value) ? null : 'Número de teléfono inválido';
  }
}
