import 'package:app_remision/data/models/passenger_manifest_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ManifiestoRepository {
  Future<void> createManifiesto(ManifiestoModel manifiesto);
  Future<ManifiestoModel?> getManifiesto(String id);
  Future<List<ManifiestoModel>> getAllManifiestos();
  Future<void> updateManifiesto(String id, ManifiestoModel manifiesto);
  Future<void> deleteManifiesto(String id);
  Future<Map<String, dynamic>> getManifiestosByUserWithPagination(String usuarioId, int limit,
      {DocumentSnapshot? lastDocument});
}

class FirebaseManifiestoRepository implements ManifiestoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createManifiesto(ManifiestoModel manifiesto) async {
    DocumentReference docRef = await _firestore.collection('manifiestos').add(manifiesto.toJson());
    await docRef.update({'id': docRef.id});
  }

  @override
  Future<ManifiestoModel?> getManifiesto(String id) async {
    DocumentSnapshot doc = await _firestore.collection('manifiestos').doc(id).get();
    if (doc.exists) {
      return ManifiestoModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<List<ManifiestoModel>> getAllManifiestos() async {
    QuerySnapshot querySnapshot = await _firestore.collection('manifiestos').get();
    return querySnapshot.docs.map((doc) => ManifiestoModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> updateManifiesto(String id, ManifiestoModel manifiesto) async {
    await _firestore.collection('manifiestos').doc(id).update(manifiesto.toJson());
  }

  @override
  Future<void> deleteManifiesto(String id) async {
    await _firestore.collection('manifiestos').doc(id).delete();
  }

  @override
  Future<Map<String, dynamic>> getManifiestosByUserWithPagination(String usuarioId, int limit,
      {DocumentSnapshot? lastDocument}) async {
    Query query = _firestore
        .collection('manifiestos')
        .where('user_id', isEqualTo: usuarioId)
        .orderBy('fecha_viaje', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    QuerySnapshot snapshot = await query.get();

    List<ManifiestoModel> manifiestos =
        snapshot.docs.map((doc) => ManifiestoModel.fromJson(doc.data() as Map<String, dynamic>)).toList();

    return {'manifiestos': manifiestos, 'lastDocument': snapshot.docs.isNotEmpty ? snapshot.docs.last : null};
  }
}
