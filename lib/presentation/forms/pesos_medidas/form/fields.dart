import 'package:formz/formz.dart';

class Fecha extends FormzInput<DateTime?, String> {
  const Fecha.pure() : super.pure(null);
  const Fecha.dirty([super.value]) : super.dirty();
  @override
  String? validator(DateTime? value) {
    if (value == null) {
      return 'La fecha no puede estar vacía';
    }
    return null;
  }
}

class Registro extends FormzInput<String, String> {
  const Registro.pure() : super.pure('');
  const Registro.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return null;
  }
}

class NombreEmpresa extends FormzInput<String, String> {
  const NombreEmpresa.pure() : super.pure('');
  const NombreEmpresa.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El nombre de la empresa no puede estar vacío';
  }
}

class NombreRepresentante extends FormzInput<String, String> {
  const NombreRepresentante.pure() : super.pure('');
  const NombreRepresentante.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El nombre del representante no puede estar vacío';
  }
}

class Ruc extends FormzInput<String, String> {
  const Ruc.pure() : super.pure('');
  const Ruc.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El RUC no puede estar vacío';
  }
}

class Telefono extends FormzInput<String, String> {
  const Telefono.pure() : super.pure('');
  const Telefono.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El teléfono no puede estar vacío';
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

class TipoMercancia extends FormzInput<String, String> {
  const TipoMercancia.pure() : super.pure('');
  const TipoMercancia.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El tipo de mercancía no puede estar vacío';
  }
}

class GuiaRemision extends FormzInput<String, String> {
  const GuiaRemision.pure() : super.pure('');
  const GuiaRemision.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'La guía de remisión no puede estar vacía';
  }
}

class TipoControl extends FormzInput<String, String> {
  const TipoControl.pure() : super.pure('');
  const TipoControl.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'El tipo de control no puede estar vacío';
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

class Largo extends FormzInput<double, String> {
  const Largo.pure() : super.pure(0.0);
  const Largo.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El largo debe ser mayor a 0';
  }
}

class Ancho extends FormzInput<double, String> {
  const Ancho.pure() : super.pure(0.0);
  const Ancho.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El ancho debe ser mayor a 0';
  }
}

class Alto extends FormzInput<double, String> {
  const Alto.pure() : super.pure(0.0);
  const Alto.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El alto debe ser mayor a 0';
  }
}

class CJTO1 extends FormzInput<double, String> {
  const CJTO1.pure() : super.pure(0.0);
  const CJTO1.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El num debe ser mayor a 0';
  }
}

class CJTO2 extends FormzInput<double, String> {
  const CJTO2.pure() : super.pure(0.0);
  const CJTO2.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El num debe ser mayor a 0';
  }
}

class CJTO3 extends FormzInput<double, String> {
  const CJTO3.pure() : super.pure(0.0);
  const CJTO3.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El num debe ser mayor a 0';
  }
}

class CJTO4 extends FormzInput<double, String> {
  const CJTO4.pure() : super.pure(0.0);
  const CJTO4.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El num debe ser mayor a 0';
  }
}

class CJTO5 extends FormzInput<double, String> {
  const CJTO5.pure() : super.pure(0.0);
  const CJTO5.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El num debe ser mayor a 0';
  }
}

class CJTO6 extends FormzInput<double, String> {
  const CJTO6.pure() : super.pure(0.0);
  const CJTO6.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El num debe ser mayor a 0';
  }
}

class ConfiguracionVehicular extends FormzInput<String, String> {
  const ConfiguracionVehicular.pure() : super.pure('');
  const ConfiguracionVehicular.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'La configuración vehicular no puede estar vacía';
  }
}

class PesoBrutoMaximo extends FormzInput<double, String> {
  const PesoBrutoMaximo.pure() : super.pure(0.0);
  const PesoBrutoMaximo.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El peso bruto máximo debe ser mayor a 0';
  }
}

class PesoTransportado extends FormzInput<double, String> {
  const PesoTransportado.pure() : super.pure(0.0);
  const PesoTransportado.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El peso transportado debe ser mayor a 0';
  }
}

class PbMaxNoControl extends FormzInput<double, String> {
  const PbMaxNoControl.pure() : super.pure(0.0);
  const PbMaxNoControl.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El PB Max No Control debe ser mayor a 0';
  }
}

class PbMaxConBonificacion extends FormzInput<double, String> {
  const PbMaxConBonificacion.pure() : super.pure(0.0);
  const PbMaxConBonificacion.dirty([super.value = 0.0]) : super.dirty();

  @override
  String? validator(double value) {
    return value > 0 ? null : 'El PB Max Con Bonificación debe ser mayor a 0';
  }
}

class Observaciones extends FormzInput<String, String> {
  const Observaciones.pure() : super.pure('');
  const Observaciones.dirty([super.value = '']) : super.dirty();

  @override
  String? validator(String value) {
    return value.isNotEmpty ? null : 'Las observaciones no pueden estar vacías';
  }
}
