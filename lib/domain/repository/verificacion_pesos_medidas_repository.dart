import 'package:app_remision/data/models/verificacion_pesos_medidas_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class VerificacionPesosMedidasRepository {
  Future<void> createVerificacion(VerificacionPesosMedidasModel verificacion);
  Future<VerificacionPesosMedidasModel?> getVerificacion(String id);
  Future<List<VerificacionPesosMedidasModel>> getAllVerificaciones();
  Future<void> updateVerificacion(String id, VerificacionPesosMedidasModel verificacion);
  Future<void> deleteVerificacion(String id);
  Future<Map<String, dynamic>> getVerificacionesByUserWithPagination(String usuarioId, int limit,
      {DocumentSnapshot? lastDocument});
}

class FirebaseVerificacionPesosMedidasRepository implements VerificacionPesosMedidasRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createVerificacion(VerificacionPesosMedidasModel verificacion) async {
    final docRef = await _firestore.collection('verificaciones').add(verificacion.toJson());
    final generatedId = docRef.id;
    await docRef.update({'id': generatedId});
  }

  @override
  Future<VerificacionPesosMedidasModel?> getVerificacion(String id) async {
    DocumentSnapshot doc = await _firestore.collection('verificaciones').doc(id).get();
    if (doc.exists) {
      return VerificacionPesosMedidasModel.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  @override
  Future<List<VerificacionPesosMedidasModel>> getAllVerificaciones() async {
    QuerySnapshot querySnapshot = await _firestore.collection('verificaciones').get();
    return querySnapshot.docs
        .map((doc) => VerificacionPesosMedidasModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  @override
  Future<void> updateVerificacion(String id, VerificacionPesosMedidasModel verificacion) async {
    await _firestore.collection('verificaciones').doc(id).update(verificacion.toJson());
  }

  @override
  Future<void> deleteVerificacion(String id) async {
    await _firestore.collection('verificaciones').doc(id).delete();
  }

  @override
  Future<Map<String, dynamic>> getVerificacionesByUserWithPagination(String usuarioId, int limit,
      {DocumentSnapshot? lastDocument}) async {
    Query query = _firestore
        .collection('verificaciones')
        // .where('user_id', isEqualTo: usuarioId)
        .orderBy('fecha', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    QuerySnapshot snapshot = await query.get();

    List<VerificacionPesosMedidasModel> verificaciones = snapshot.docs
        .map((doc) => VerificacionPesosMedidasModel.fromJson(doc.data() as Map<String, dynamic>, doc.id))
        .toList();

    return {'verificaciones': verificaciones, 'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null};
  }
}
