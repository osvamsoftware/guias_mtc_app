import 'package:formz/formz.dart';

// Campos para HojaDeRutaModel

class RucField extends FormzInput<String, String> {
  const RucField.pure() : super.pure('');
  const RucField.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El RUC no puede estar vacía';
  }
}

class NumPasajeros extends FormzInput<int, String> {
  const NumPasajeros.pure() : super.pure(0);
  const NumPasajeros.dirty([super.value = 0]) : super.dirty();

  @override
  String? validator(int value) {
    return value != 0 ? null : 'El RUC no puede estar vacía';
  }
}

class Distrito extends FormzInput<String, String> {
  const Distrito.pure() : super.pure('');
  const Distrito.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El distrito no puede estar vacío';
  }
}

class Provincia extends FormzInput<String, String> {
  const Provincia.pure() : super.pure('');
  const Provincia.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'La provincia no puede estar vacía';
  }
}

class Departamento extends FormzInput<String, String> {
  const Departamento.pure() : super.pure('');
  const Departamento.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El departamento no puede estar vacío';
  }
}

class Placas extends FormzInput<String, String> {
  const Placas.pure() : super.pure('');
  const Placas.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Las placas no pueden estar vacías';
  }
}

class Estado extends FormzInput<String, String> {
  const Estado.pure() : super.pure('');
  const Estado.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Las placas no pueden estar vacías';
  }
}

class RevisionTecnica extends FormzInput<String, String> {
  const RevisionTecnica.pure() : super.pure('');
  const RevisionTecnica.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Las placas no pueden estar vacías';
  }
}

class SOAT extends FormzInput<String, String> {
  const SOAT.pure() : super.pure('');
  const SOAT.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Las placas no pueden estar vacías';
  }
}

class RazonSocial extends FormzInput<String, String> {
  const RazonSocial.pure() : super.pure('');
  const RazonSocial.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'La razón social no puede estar vacía';
  }
}

class Folio extends FormzInput<String, String> {
  const Folio.pure() : super.pure('');
  const Folio.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El folio no puede estar vacía';
  }
}

class Telefono extends FormzInput<String, String> {
  const Telefono.pure() : super.pure('');
  const Telefono.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El telefono no puede estar vacía';
  }
}

class Direccion extends FormzInput<String, String> {
  const Direccion.pure() : super.pure('');
  const Direccion.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'La dirección no puede estar vacía';
  }
}

class CorreoElectronico extends FormzInput<String, String> {
  const CorreoElectronico.pure() : super.pure('');
  const CorreoElectronico.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El correo electrónico no puede estar vacío';
  }
}

class NumeroPlaca extends FormzInput<String, String> {
  const NumeroPlaca.pure() : super.pure('');
  const NumeroPlaca.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El número de placa no puede estar vacío';
  }
}

class FechaInicioViaje extends FormzInput<DateTime?, String> {
  const FechaInicioViaje.pure() : super.pure(null);
  const FechaInicioViaje.dirty([super.value]) : super.dirty();

  @override
  String? validator(DateTime? value) {
    if (value == null) {
      return 'La fecha de inicio de viaje no puede estar vacía';
    }
    return null;
  }
}

class FechaLlegadaViaje extends FormzInput<DateTime?, String> {
  const FechaLlegadaViaje.pure() : super.pure(null);
  const FechaLlegadaViaje.dirty([super.value]) : super.dirty();

  @override
  String? validator(DateTime? value) {
    if (value == null) {
      return 'La fecha de llegada no puede estar vacía';
    }
    return null;
  }
}

class Ruta extends FormzInput<String, String> {
  const Ruta.pure() : super.pure('');
  const Ruta.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'La ruta no puede estar vacía';
  }
}

class ModalidadServicio extends FormzInput<String, String> {
  const ModalidadServicio.pure() : super.pure('');
  const ModalidadServicio.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'La modalidad de servicio no puede estar vacía';
  }
}

class TerminalSalida extends FormzInput<String, String> {
  const TerminalSalida.pure() : super.pure('');
  const TerminalSalida.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El terminal de salida no puede estar vacío';
  }
}

class TerminalLlegada extends FormzInput<String, String> {
  const TerminalLlegada.pure() : super.pure('');
  const TerminalLlegada.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El terminal de llegada no puede estar vacío';
  }
}

class EscalasComerciales extends FormzInput<String, String> {
  const EscalasComerciales.pure() : super.pure('');
  const EscalasComerciales.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Las escalas comerciales no pueden estar vacías';
  }
}

class HoraSalida extends FormzInput<DateTime?, String> {
  const HoraSalida.pure() : super.pure(null);
  const HoraSalida.dirty([super.value]) : super.dirty();

  @override
  String? validator(DateTime? value) {
    if (value == null) {
      return 'La fecha de llegada no puede estar vacía';
    }
    return null;
  }
}

class HoraLlegada extends FormzInput<DateTime?, String> {
  const HoraLlegada.pure() : super.pure(null);
  const HoraLlegada.dirty([super.value]) : super.dirty();

  @override
  String? validator(DateTime? value) {
    if (value == null) {
      return 'La fecha de llegada no puede estar vacía';
    }
    return null;
  }
}

// Campos para Conductor
class NombreConductor extends FormzInput<String, String> {
  const NombreConductor.pure() : super.pure('');
  const NombreConductor.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El nombre del conductor no puede estar vacío';
  }
}

class LicenciaConducir extends FormzInput<String, String> {
  const LicenciaConducir.pure() : super.pure('');
  const LicenciaConducir.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'La licencia de conducir no puede estar vacía';
  }
}

class HoraInicioConduccion extends FormzInput<DateTime?, String> {
  const HoraInicioConduccion.pure() : super.pure(null);
  const HoraInicioConduccion.dirty([super.value]) : super.dirty();

  @override
  String? validator(DateTime? value) {
    if (value == null) {
      return 'La fecha de llegada no puede estar vacía';
    }
    return null;
  }
}

class HoraTerminoConduccion extends FormzInput<DateTime?, String> {
  const HoraTerminoConduccion.pure() : super.pure(null);
  const HoraTerminoConduccion.dirty([super.value]) : super.dirty();

  @override
  String? validator(DateTime? value) {
    if (value == null) {
      return 'La fecha de llegada no puede estar vacía';
    }
    return null;
  }
}

class TurnoConduccion extends FormzInput<String, String> {
  const TurnoConduccion.pure() : super.pure('');
  const TurnoConduccion.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El turno de conducción no puede estar vacío';
  }
}

class DescripcionIncidencia extends FormzInput<String, String> {
  const DescripcionIncidencia.pure() : super.pure('');
  const DescripcionIncidencia.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'La descripción de la incidencia no puede estar vacía';
  }
}

class LugarIncidencia extends FormzInput<String, String> {
  const LugarIncidencia.pure() : super.pure('');
  const LugarIncidencia.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El lugar de la incidencia no puede estar vacío';
  }
}

class FechaHoraIncidencia extends FormzInput<DateTime?, String> {
  const FechaHoraIncidencia.pure() : super.pure(null);
  const FechaHoraIncidencia.dirty([super.value]) : super.dirty();

  @override
  String? validator(DateTime? value) {
    if (value == null) {
      return 'La fecha y hora de la incidencia no pueden estar vacías';
    }
    return null;
  }
}
