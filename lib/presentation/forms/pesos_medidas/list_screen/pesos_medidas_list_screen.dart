import 'package:app_remision/domain/repository/verificacion_pesos_medidas_repository.dart';
import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/form/pesos_medidas_screen.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/list_screen/cubit/verificacion_pesos_medidas_cubit.dart';
import 'package:app_remision/presentation/forms/pesos_medidas/list_screen/details_pesos_medidas_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class PesosMedidasListScreen extends StatelessWidget {
  static const path = '/verification-list';

  const PesosMedidasListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificaciones de Pesos y Medidas'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(PesosMedidasFormScreen.path),
        child: const Icon(Icons.add),
      ),
      body: BlocProvider(
        create: (context) => PesosMedidasListCubit(repository: context.read<VerificacionPesosMedidasRepository>())
          ..loadVerificaciones(context.read<AuthCubit>().state.userModel?.userId ?? ''),
        child: const VerificacionListView(),
      ),
    );
  }
}

class VerificacionListView extends StatelessWidget {
  const VerificacionListView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<PesosMedidasListCubit>().loadVerificaciones(context.read<AuthCubit>().state.userModel?.userId ?? '');

    return BlocBuilder<PesosMedidasListCubit, PesosMedidasListState>(
      builder: (context, state) {
        if (state is PesosMedidasLoading && state.verificaciones.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PesosMedidasFailure) {
          return Center(child: Text('Error: ${state.error}'));
        }

        if (state is PesosMedidasListSuccess || state is PesosMedidasLoading && state.verificaciones.isNotEmpty) {
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: context.read<PesosMedidasListCubit>().scrollController,
                  itemCount: state.verificaciones.length,
                  itemBuilder: (context, index) {
                    final verificacion = state.verificaciones[index];
                    return ListTile(
                      title: Text('Registro Ruc: ${verificacion.ruc}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Versión: 1.${verificacion.version}'),
                          Text('Fecha: ${DateFormat('dd/MM/yyyy').format(verificacion.fecha ?? DateTime.now())}'),
                        ],
                      ),
                      onTap: () => context.push(VerificacionPesosMedidasDetail.path, extra: verificacion),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                ),
              ),
              if (state is PesosMedidasLoading) const CircularProgressIndicator.adaptive()
            ],
          );
        }

        return const Center(child: Text('No se encontraron verificaciones.'));
      },
    );
  }
}
