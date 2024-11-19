import 'package:formz/formz.dart';

// Input para Razon Social
class RazonSocial extends FormzInput<String, String> {
  const RazonSocial.pure() : super.pure('');
  const RazonSocial.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'No puede estar vacío';
  }
}

// Input para Dirección
class Direccion extends FormzInput<String, String> {
  const Direccion.pure() : super.pure('');
  const Direccion.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'No puede estar vacío';
  }
}

// Input para Teléfono
class Telefono extends FormzInput<String, String> {
  const Telefono.pure() : super.pure('');
  const Telefono.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'No puede estar vacío';
  }
}

// Input para Correo Electrónico
class CorreoElectronico extends FormzInput<String, String> {
  const CorreoElectronico.pure() : super.pure('');
  const CorreoElectronico.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String? value) {
    return value?.contains('@') == true ? null : 'Correo electrónico inválido';
  }
}

// Input para Fecha de Viaje
class FechaViaje extends FormzInput<DateTime?, String> {
  const FechaViaje.pure() : super.pure(null);
  const FechaViaje.dirty([super.value]) : super.dirty();

  @override
  String? validator(DateTime? value) {
    return value != null ? null : 'Debe seleccionar una fecha';
  }
}

// Input para Placa Vehicular
class PlacaVehicular extends FormzInput<String, String> {
  const PlacaVehicular.pure() : super.pure('');
  const PlacaVehicular.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'No puede estar vacío';
  }
}

// Input para Ruta
class Ruta extends FormzInput<String, String> {
  const Ruta.pure() : super.pure('');
  const Ruta.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'No puede estar vacío';
  }
}

// Input para Modalidad de Servicio
class ModalidadServicio extends FormzInput<String, String> {
  const ModalidadServicio.pure() : super.pure('');
  const ModalidadServicio.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String? value) {
    return value?.isNotEmpty == true ? null : 'No puede estar vacío';
  }
}
