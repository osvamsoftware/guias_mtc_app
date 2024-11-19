// import 'package:formz/formz.dart';

// class Email extends FormzInput<String, String> {
//   const Email.pure() : super.pure('');
//   const Email.dirty([super.value = '']) : super.dirty();

//   @override
//   String? validator(String value) {
//     return value.isNotEmpty && RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value) ? null : 'Email inválido';
//   }
// }

// class Password extends FormzInput<String, String> {
//   const Password.pure() : super.pure('');
//   const Password.dirty([super.value = '']) : super.dirty();

//   @override
//   String? validator(String value) {
//     return value.length >= 6 ? null : 'La contraseña debe tener al menos 6 caracteres';
//   }
// }
