import 'package:app_remision/core/constants/validators.dart';
import 'package:app_remision/core/settings/theme_settings.dart';
import 'package:app_remision/domain/repository/guia_transportista_repository.dart';
import 'package:app_remision/presentation/forms/guia_remision_transportista/cubit/guia_transportista_cubit.dart';
import 'package:app_remision/presentation/forms/guia_remision_transportista/widgets/switch_row_widget.dart';
import 'package:app_remision/presentation/home/home_screen.dart';
import 'package:app_remision/presentation/shared/dialogs/custom_dialogs.dart';
import 'package:app_remision/presentation/shared/widgets/custom_divider.dart';
import 'package:app_remision/presentation/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuiaTransportistaFormScreen extends StatelessWidget {
  static const String path = '/guia-transportista';

  const GuiaTransportistaFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GuiaTransportistaCubit(context.read<GuiaTransportistaRepository>()),
      child: GuiaTransportistaView(),
    );
  }
}

// creat view guia transportista
class GuiaTransportistaView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  GuiaTransportistaView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guia Transportista'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const RemitenteInput(),
                    const DestinatarioInput(),
                    const FechaTrasladoInput(),
                    const FechaEmisionInput(),
                    const SizedBox(height: 25),
                    const CustomNamedDivider(label: 'Datos Transportista'),
                    const RegistroMTCInput(),
                    const CustomNamedDivider(label: 'Conductor/es', fontSize: 15),
                    const Text(
                        'Llene los campos del conductor, una vez que haya terminado, presione en "Agregar Conductor", puede agregar uno o más conductores.'),
                    const SizedBox(height: 20),
                    ..._buildConductorItems(state, context),
                    const SizedBox(height: 20),
                    const ConductorFormInput(),
                    const SizedBox(height: 20),
                    const CustomNamedDivider(label: 'Vehículo/s', fontSize: 15),
                    const Text(
                        'Llene los campos de vehículos, una vez que haya terminado, presione en "Agregar Vehículo", puede agregar uno o más vehículos.'),
                    const SizedBox(height: 20),
                    ..._buildVehiculosItems(state, context),
                    const SizedBox(height: 20),
                    const VehiculosFormInput(),
                    const CustomNamedDivider(label: 'Punto de Partida', fontSize: 15),
                    const SizedBox(height: 20),
                    const CustomNamedDivider(label: 'Punto de Llegada', fontSize: 15),
                    const CustomNamedDivider(label: 'Registro Items'),
                    const SizedBox(height: 20),
                    const PesoBrutoInput(),
                    const SizedBox(height: 20),
                    ..._buildItemsItems(state, context),
                    const SizedBox(height: 20),
                    ItemsFormInput(),
                    const CustomNamedDivider(label: 'Documentos Relacionados'),
                    const SizedBox(height: 20),
                    ..._buildDocumentItems(state, context),
                    DocumentoRelacionadoFormInput(),
                    const SizedBox(height: 20),
                    const SwitchInputs(),
                    const FleteInput(),
                    const SizedBox(height: 20),
                    CustomElevatedButton(
                        text: 'Emitir Guía Remitente',
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<GuiaTransportistaCubit>().onSubmmitEmitirGuiaTransportista();
                          } else {
                            CustomDialogs.errorDialog(context,
                                'Hay Campos que son obligatorios sin llenar o incorrectos, por favor verifique el formulario e intente de nuevo.');
                          }
                        })
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildDocumentItems(GuiaTransportistaState state, BuildContext context) {
    return List.generate(
      state.guiaTransportistaModel.documentoAfectado == null
          ? 0
          : state.guiaTransportistaModel.documentoAfectado!.length,
      (index) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: ThemeColors.darkGrey.withOpacity(.2),
        ),
        child: Row(
          children: [
            SizedBox(
                width: 300,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Documento ${index + 1}"),
                  const SizedBox(height: 10),
                  Text("Documento: ${state.guiaTransportistaModel.documentoAfectado?[index].codigoTipoDocumento}"),
                  Text("Núm y Serie: ${state.guiaTransportistaModel.documentoAfectado?[index].serieDocumento}"),
                  Text("Descripción: ${state.guiaTransportistaModel.documentoAfectado?[index].numeroDocumento}"),
                ])),
            IconButton(
                onPressed: () => context.read<GuiaTransportistaCubit>().onDeleteItem(index),
                icon: Icon(Icons.delete, color: Colors.red.shade400))
          ],
        ),
      ),
    );
  }

  List<Widget> _buildItemsItems(GuiaTransportistaState state, BuildContext context) {
    return List.generate(
      state.guiaTransportistaModel.items == null ? 0 : state.guiaTransportistaModel.items!.length,
      (index) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: ThemeColors.darkGrey.withOpacity(.2),
        ),
        child: Row(
          children: [
            SizedBox(
                width: 300,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Item ${index + 1}"),
                  const SizedBox(height: 10),
                  Text("Cantidad: ${state.guiaTransportistaModel.items?[index].cantidad}"),
                  Text("Codigo interno: ${state.guiaTransportistaModel.items?[index].codigoInterno}"),
                  // Text("Marca: ${state.guiaTransportistaModel.vehiculo![index].marca}")
                ])),
            IconButton(
                onPressed: () => context.read<GuiaTransportistaCubit>().onDeleteItem(index),
                icon: Icon(Icons.delete, color: Colors.red.shade400))
          ],
        ),
      ),
    );
  }

  List<Widget> _buildVehiculosItems(GuiaTransportistaState state, BuildContext context) {
    return List.generate(
      state.guiaTransportistaModel.vehiculo == null ? 0 : state.guiaTransportistaModel.vehiculo!.length,
      (index) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: ThemeColors.darkGrey.withOpacity(.2),
        ),
        child: Row(
          children: [
            SizedBox(
                width: 300,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Vehículo ${index + 1}"),
                  const SizedBox(height: 10),
                  Text("Placa: ${state.guiaTransportistaModel.vehiculo![index].numeroDePlaca}"),
                  Text("Modelo: ${state.guiaTransportistaModel.vehiculo![index].modelo}"),
                  Text("Marca: ${state.guiaTransportistaModel.vehiculo![index].marca}")
                ])),
            IconButton(
                onPressed: () => context.read<GuiaTransportistaCubit>().onDeleteVehiculo(index),
                icon: Icon(Icons.delete, color: Colors.red.shade400))
          ],
        ),
      ),
    );
  }

  List<Widget> _buildConductorItems(GuiaTransportistaState state, BuildContext context) {
    return List.generate(
      state.guiaTransportistaModel.chofer == null ? 0 : state.guiaTransportistaModel.chofer!.length,
      (index) => Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: ThemeColors.darkGrey.withOpacity(.2),
        ),
        child: Row(
          children: [
            SizedBox(
                width: 300,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Conductor ${index + 1}"),
                  const SizedBox(height: 10),
                  Text("Nombre: ${state.guiaTransportistaModel.chofer![index].nombres}"),
                  Text("Documento: ${state.guiaTransportistaModel.chofer![index].numeroDocumento}"),
                  Text("Licencia: ${state.guiaTransportistaModel.chofer![index].numeroLicencia}")
                ])),
            IconButton(
                onPressed: () => context.read<GuiaTransportistaCubit>().deleteConductor(index),
                icon: Icon(Icons.delete, color: Colors.red.shade400))
          ],
        ),
      ),
    );
  }
}

class RemitenteInput extends StatelessWidget {
  const RemitenteInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
      builder: (context, state) {
        final transportistaCubit = context.read<GuiaTransportistaCubit>();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextfield(
                labelText: 'Remitente',
                controller: transportistaCubit.apellidosYNombresORazonSocialRemitenteController,
                validator: (p0) => validators.validateText(text: p0 ?? '')),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: DropdownButton(
                      items: const [
                        DropdownMenuItem(value: '1', child: Text('DNI')),
                        DropdownMenuItem(value: '2', child: Text('RUC')),
                        DropdownMenuItem(value: '3', child: Text('CE'))
                      ],
                      onChanged: (value) => transportistaCubit.onRemitentDocumentTypeChange(value ?? '1'),
                      value: state.guiaTransportistaModel.remitente?.codigoTipoDocumentoIdentidad ?? '1'),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: CustomTextfield(
                        controller: transportistaCubit.numeroDocumentoRemitenteController,
                        labelText: 'Número documento',
                        validator: (p0) => validators.validateText(text: p0 ?? '')))
              ],
            ),
          ],
        );
      },
    );
  }
}

class DestinatarioInput extends StatelessWidget {
  const DestinatarioInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
      builder: (context, state) {
        final transportistaCubit = context.read<GuiaTransportistaCubit>();
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextfield(
                labelText: 'Destinatario',
                controller: transportistaCubit.apellidosYNombresORazonSocialDestinatarioController,
                validator: (p0) => validators.validateText(text: p0 ?? '')),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: DropdownButton(
                      items: const [
                        DropdownMenuItem(value: '1', child: Text('DNI')),
                        DropdownMenuItem(value: '2', child: Text('RUC')),
                        DropdownMenuItem(value: '3', child: Text('CE'))
                      ],
                      onChanged: (value) => transportistaCubit.onDestinatarioDocumentTypeChange(value ?? '1'),
                      value: state.guiaTransportistaModel.destinatario?.codigoTipoDocumentoIdentidad ?? '1'),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: CustomTextfield(
                      controller: transportistaCubit.numeroDocumentoDestinatarioController,
                      labelText: 'Número documento',
                      validator: (p0) => validators.validateText(text: p0 ?? '')),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class FechaTrasladoInput extends StatelessWidget {
  const FechaTrasladoInput({super.key});

  @override
  Widget build(BuildContext context) {
    final transportistaCubit = context.read<GuiaTransportistaCubit>();
    return CustomTextfield(
      labelText: 'Fecha de Emisión',
      readOnly: true,
      controller: transportistaCubit.fechaDeTransladoController,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          transportistaCubit.onFechaDeTrasladoChange(pickedDate);
        }
      },
      validator: (value) {
        final fechaViaje = context.read<GuiaTransportistaCubit>().state.guiaTransportistaModel.fechaDeTraslado;
        fechaViaje != null ? null : 'La fecha no puede estar vacia';
        return null;
      },
    );
  }
}

class FechaEmisionInput extends StatelessWidget {
  const FechaEmisionInput({super.key});

  @override
  Widget build(BuildContext context) {
    final transportistaCubit = context.read<GuiaTransportistaCubit>();
    return CustomTextfield(
      labelText: 'Fecha de Emisión',
      readOnly: true,
      controller: transportistaCubit.fechaDeEmisionController,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          transportistaCubit.onFechaDeEmisionChange(pickedDate);
        }
      },
      validator: (value) {
        final fechaEmision = context.read<GuiaTransportistaCubit>().state.guiaTransportistaModel.fechaDeEmision;
        return fechaEmision != null ? null : 'La fecha no puede estar vacía';
      },
    );
  }
}

class SwitchInputs extends StatelessWidget {
  const SwitchInputs({super.key});

  @override
  Widget build(BuildContext context) {
    final transportistaCubit = context.read<GuiaTransportistaCubit>();

    return BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
      builder: (context, state) {
        return Column(
          children: [
            SwitchRow(
                title: 'Retorno de vehículo Vacío',
                value: transportistaCubit.state.guiaTransportistaModel.vehiculoVacio ?? false,
                onChanged: (value) => transportistaCubit.onRetornoDeVehiculoVacio(value ?? false)),
            SwitchRow(
                title: 'Envases Vacíos',
                value: transportistaCubit.state.guiaTransportistaModel.envasesVacios ?? false,
                onChanged: (value) => transportistaCubit.onEnvasesVaciosChange(value ?? false)),
            SwitchRow(
                title: 'Transbordo Programado',
                value: transportistaCubit.state.guiaTransportistaModel.transbordoProgramado ?? false,
                onChanged: (value) => transportistaCubit.onTransbordoProgramadoChange(value ?? false)),
            SwitchRow(
                title: 'Traslado Total de Bienes',
                value: transportistaCubit.state.guiaTransportistaModel.transladoTotalDeBienes ?? false,
                onChanged: (value) => transportistaCubit.onTrasladoTotalDeBienesChange(value ?? false)),
            SwitchRow(
                title: 'Transporte Subcontratado',
                value: transportistaCubit.state.guiaTransportistaModel.transporteSubcontratado ?? false,
                onChanged: (value) => transportistaCubit.onTransporteSubcontratadoChange(value ?? false)),
          ],
        );
      },
    );
  }
}

class FleteInput extends StatelessWidget {
  const FleteInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
      builder: (context, state) {
        final transportistaCubit = context.read<GuiaTransportistaCubit>();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Flete pagado por: '),
            DropdownButton(
                items: const [
                  DropdownMenuItem(value: '1', child: Text('Remitente')),
                  DropdownMenuItem(value: '2', child: Text('Subcontratador')),
                  DropdownMenuItem(value: '3', child: Text('Terceros'))
                ],
                onChanged: (value) => transportistaCubit.onFleteChange(value ?? '1'),
                value: state.guiaTransportistaModel.contratoVehicular ?? '1'),
          ],
        );
      },
    );
  }
}

class RegistroMTCInput extends StatelessWidget {
  const RegistroMTCInput({super.key});

  @override
  Widget build(BuildContext context) {
    final transportistaCubit = context.read<GuiaTransportistaCubit>();
    return CustomTextfield(
      labelText: 'Registro MTC',
      controller: transportistaCubit.registroMTCController,
      validator: (p0) => validators.validateText(text: p0 ?? ''),
      keyboardType: const TextInputType.numberWithOptions(),
    );
  }
}

class ConductorFormInput extends StatelessWidget {
  const ConductorFormInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
      builder: (context, state) {
        final transportistaCubit = context.read<GuiaTransportistaCubit>();
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: ThemeColors.secondaryBlue.withOpacity(.2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: DropdownButton(
                        items: const [
                          DropdownMenuItem(value: '1', child: Text('DNI')),
                          DropdownMenuItem(value: '2', child: Text('RUC')),
                          DropdownMenuItem(value: '3', child: Text('CE'))
                        ],
                        onChanged: (value) => transportistaCubit.onConductorDocumentTypeChange(value ?? '1'),
                        value: state.tipoDocumentoConductorTemp),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: CustomTextfield(
                        controller: transportistaCubit.numeroDocumentoChoferController,
                        labelText: 'Número documento',
                        // validator: (p0) => validators.validateText(text: p0 ?? ''),
                      ))
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextfield(
                      controller: transportistaCubit.nombresChoferController,
                      labelText: 'Nombres',
                      // validator: (p0) => validators.validateText(text: p0 ?? ''),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextfield(
                      controller: transportistaCubit.apellidosChoferController,
                      labelText: 'Apellidos',
                      // validator: (p0) => validators.validateText(text: p0 ?? ''),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              CustomTextfield(
                labelText: 'No. Licencia',
                controller: transportistaCubit.numeroLicenciaChoferController,
                // validator: (p0) => validators.validateText(text: p0 ?? ''),
              ),
              TextButton(onPressed: () => transportistaCubit.onAddConductor(), child: const Text('Agregar Conductor'))
            ],
          ),
        );
      },
    );
  }
}

class VehiculosFormInput extends StatelessWidget {
  const VehiculosFormInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
      builder: (context, state) {
        final guiaTranportistaCubit = context.read<GuiaTransportistaCubit>();
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: ThemeColors.secondaryBlue.withOpacity(.2),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextfield(
                      labelText: 'Placa',
                      controller: guiaTranportistaCubit.numeroDePlacaController,
                      // validator: (p0) => validators.validateText(text: p0 ?? ''),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextfield(
                      labelText: 'TUC/CHV',
                      controller: guiaTranportistaCubit.tucChbController,
                      // validator: (p0) => validators.validateText(text: p0 ?? ''),
                    ),
                  )
                ],
              ),
              CustomTextfield(
                labelText: 'Número de Autorización',
                controller: guiaTranportistaCubit.autorizacionController,
                // validator: (p0) => validators.validateText(text: p0 ?? ''),
              ),
              Row(
                children: [
                  const Text('Entidad Emisora'),
                  const SizedBox(width: 10),
                  DropdownButton(
                      items: const [
                        DropdownMenuItem(value: '1', child: Text('CERFOR')),
                        DropdownMenuItem(value: '2', child: Text('MTC')),
                        DropdownMenuItem(value: '3', child: Text('PRODUCE'))
                      ],
                      onChanged: (value) => guiaTranportistaCubit.onConductorDocumentTypeChange(value ?? '1'),
                      value: guiaTranportistaCubit.codigoTipoDocumentoIdentidadChoferController.text),
                ],
              ),
              TextButton(onPressed: () => guiaTranportistaCubit.onAddVehiculo(), child: const Text('Agregar Vehículo'))
            ],
          ),
        );
      },
    );
  }
}

class PesoBrutoInput extends StatelessWidget {
  const PesoBrutoInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
      builder: (context, state) {
        final guiaTranportistaCubit = context.read<GuiaTransportistaCubit>();
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: CustomTextfield(
                labelText: 'Peso Bruto Total',
                controller: guiaTranportistaCubit.pesoTotalController,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: DropdownButton(
                    items: const [
                      DropdownMenuItem(value: '1', child: Text('KG')),
                      DropdownMenuItem(value: '2', child: Text('TON'))
                    ],
                    onChanged: (value) => guiaTranportistaCubit.onUnityChange(value ?? '1'),
                    value: state.guiaTransportistaModel.unidadPesoTotal)),
          ],
        );
      },
    );
  }
}

class ItemsFormInput extends StatelessWidget {
  const ItemsFormInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
      builder: (context, state) {
        final guiaTranportistaCubit = context.read<GuiaTransportistaCubit>();
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: ThemeColors.secondaryBlue.withOpacity(.2),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: CustomTextfield(
                      controller: guiaTranportistaCubit.unidadesItemController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      // validator: (p0) => validators.validateText(text: p0 ?? ''),
                    ),
                  ),
                  DropdownButton(
                      items: const [
                        DropdownMenuItem(value: '1', child: Text('Unidades')),
                        DropdownMenuItem(value: '2', child: Text('Servicios')),
                        DropdownMenuItem(value: '3', child: Text('Baldes')),
                        DropdownMenuItem(value: '4', child: Text('Baldones')),
                        DropdownMenuItem(value: '5', child: Text('Barriles')),
                        DropdownMenuItem(value: '6', child: Text('Galones')),
                      ],
                      onChanged: (value) => guiaTranportistaCubit.onItemUnityChange(value ?? '1'),
                      value: guiaTranportistaCubit.state.unidadPesoItem),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: CustomTextfield(
                      labelText: 'Código (Opcional)',
                      controller: guiaTranportistaCubit.codigoInternoItemController,
                    ),
                  ),
                ],
              ),
              const CustomTextfield(labelText: 'Descripción (Opcional)'),
              const CustomTextfield(labelText: 'Partida Arancelaria (Opcional)'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Indicador de bien Normalizado'),
                  Switch(value: false, onChanged: (value) {}),
                ],
              ),
              TextButton(onPressed: () => guiaTranportistaCubit.onAddItem(), child: Text('Agregar Item'))
            ],
          ),
        );
      },
    );
  }
}

class DocumentoRelacionadoFormInput extends StatelessWidget {
  const DocumentoRelacionadoFormInput({super.key});

  @override
  Widget build(BuildContext context) {
    final guiaTransportistaCubit = context.read<GuiaTransportistaCubit>();

    return BlocBuilder<GuiaTransportistaCubit, GuiaTransportistaState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
            color: ThemeColors.secondaryBlue.withOpacity(.2),
          ),
          child: Column(
            children: [
              DropdownButton(
                  items: const [
                    DropdownMenuItem(value: '1', child: Text('Factura')),
                    DropdownMenuItem(value: '2', child: Text('Boleta de Venta')),
                    DropdownMenuItem(value: '3', child: Text('Liquidación de Compra')),
                    DropdownMenuItem(value: '4', child: Text('Guía de Remisión')),
                    DropdownMenuItem(value: '5', child: Text('Guía de Remisión Transportista')),
                    DropdownMenuItem(value: '6', child: Text('Galones')),
                  ],
                  onChanged: (value) => guiaTransportistaCubit.onTipoDocumentoChange(value ?? '1'),
                  value: guiaTransportistaCubit.state.tipoDocumento),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextfield(
                      labelText: 'Num y Serie',
                      controller: guiaTransportistaCubit.documentoSerieController,
                    ),
                  ),
                  SizedBox(width: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: CustomTextfield(labelText: 'RUC', controller: guiaTransportistaCubit.documentoRucController),
                  ),
                ],
              ),
              CustomTextfield(
                  labelText: 'Descripcion', controller: guiaTransportistaCubit.ddocumentoDescriptionController),
              TextButton(onPressed: () => guiaTransportistaCubit.onAddDocument(), child: Text('Agregar Documento'))
            ],
          ),
        );
      },
    );
  }
}
