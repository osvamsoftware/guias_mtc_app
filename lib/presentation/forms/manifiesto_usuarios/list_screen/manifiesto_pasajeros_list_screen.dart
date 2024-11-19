import 'package:app_remision/domain/repository/passenger_manifest_repository.dart';
import 'package:app_remision/presentation/auth/cubit/auth_cubit.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/form_screen/manifest_form_screen.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/list_screen/cubit/manifiesto_usuarios_list_cubit.dart';
import 'package:app_remision/presentation/forms/manifiesto_usuarios/list_screen/manifiesto_pasajeros_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ManifiestoListScreen extends StatelessWidget {
  static const path = '/manifiesto-list';

  const ManifiestoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ManifiestoListCubit(
        repository: context.read<ManifiestoRepository>(),
      )..loadManifiestos(userId: context.read<AuthCubit>().state.userModel?.userId ?? ''),
      child: Builder(builder: (context) {
        return const ManifiestoListView();
      }),
    );
  }
}

class ManifiestoListView extends StatelessWidget {
  const ManifiestoListView({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ManifiestoListCubit>().loadManifiestos();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manifiestos de Pasajeros'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(ManifiestoFormScreen.path),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<ManifiestoListCubit, ManifiestoListState>(
        builder: (context, state) {
          if (state is ManifiestoLoading && state.manifiestos.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ManifiestoFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }

          if (state is ManifiestoListSuccess || state is ManifiestoLoading && state.manifiestos.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: context.read<ManifiestoListCubit>().scrollController,
                    itemCount: state.manifiestos.length,
                    itemBuilder: (context, index) {
                      final manifiesto = state.manifiestos[index];
                      return ListTile(
                        title:
                            Text(manifiesto.razonSocial ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Pasajeros: ${manifiesto.pasajeros?.length}'),
                                const SizedBox(width: 5),
                                Text('Versión: 1.${manifiesto.version}')
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                    'Fecha: ${DateFormat('dd/MM/yyyy').format(manifiesto.fechaViaje ?? DateTime.now())}'),
                                const SizedBox(width: 5),
                                Text('Ruta: ${manifiesto.ruta}')
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          context.push(ManifiestoDetailsScreen.path, extra: manifiesto);
                        },
                      );
                    },
                  ),
                ),
                if (state is ManifiestoLoading) const CircularProgressIndicator.adaptive(),
              ],
            );
          }

          return const Center(child: Text('No se encontraron manifiestos de pasajeros.'));
        },
      ),
    );
  }
}
