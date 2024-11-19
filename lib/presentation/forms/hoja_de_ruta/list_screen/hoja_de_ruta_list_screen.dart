import 'package:app_remision/domain/repository/hoja_ruta_repository.dart';
import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/form_screen/hoja_de_ruta_form_screen.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/list_screen/cubit/hoja_de_ruta_list_cubit.dart';
import 'package:app_remision/presentation/forms/hoja_de_ruta/list_screen/hoja_de_ruta_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class HojaDeRutaListScreen extends StatelessWidget {
  static const path = '/hoja-ruta-list';

  const HojaDeRutaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HojaDeRutaListCubit(
        repository: context.read<HojaDeRutaRepository>(),
      )..loadHojasDeRuta(userId: context.read<AuthCubit>().state.userModel?.userId ?? ''),
      child: Builder(builder: (context) {
        return const HojaDeRutaListView();
      }),
    );
  }
}

class HojaDeRutaListView extends StatelessWidget {
  const HojaDeRutaListView({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<HojaDeRutaListCubit>().loadHojasDeRuta();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hojas de Ruta'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(HojaDeRutaFormScreen.path),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<HojaDeRutaListCubit, HojaDeRutaListState>(
        builder: (context, state) {
          if (state is HojaDeRutaLoading && state.hojasDeRuta.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HojaDeRutaFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state is HojaDeRutaListSuccess || state is HojaDeRutaLoading && state.hojasDeRuta.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: context.read<HojaDeRutaListCubit>().scrollController,
                    itemCount: state.hojasDeRuta.length,
                    itemBuilder: (context, index) {
                      final hojaDeRuta = state.hojasDeRuta[index];
                      return ListTile(
                        title: Text('Hoja RUC: ${hojaDeRuta.ruc}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [Text('Razón Social: ${hojaDeRuta.razonSocial ?? ''}')],
                            ),
                            Text("Version: ${hojaDeRuta.version.toString()}"),
                            Row(
                              children: [
                                Text(
                                    'Inicio: ${DateFormat('dd/MM/yyyy').format(hojaDeRuta.fechaInicioViaje ?? DateTime.now())}'),
                                const SizedBox(width: 5),
                                Text(
                                    'Final: ${DateFormat('dd/MM/yyyy').format(hojaDeRuta.fechaLlegadaViaje ?? DateTime.now())}'),
                              ],
                            ),
                          ],
                        ),
                        onTap: () => context.push(HojaDeRutaDetailScreen.path, extra: hojaDeRuta),
                      );
                    },
                  ),
                ),
                if (state is HojaDeRutaLoading) const CircularProgressIndicator.adaptive(),
              ],
            );
          }

          return const Center(child: Text('No se encontraron hojas de ruta.'));
        },
      ),
    );
  }
}
