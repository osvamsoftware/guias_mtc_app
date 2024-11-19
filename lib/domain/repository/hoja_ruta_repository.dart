import 'package:app_remision/data/models/hoja_de_ruta_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class HojaDeRutaRepository {
  Future<void> createHojaDeRuta(HojaDeRutaModel hojaDeRuta);
  Future<HojaDeRutaModel?> getHojaDeRutaById(String id);
  Future<void> updateHojaDeRuta(String id, HojaDeRutaModel hojaDeRuta);
  Future<void> deleteHojaDeRuta(String id);
  Future<List<HojaDeRutaModel>> getAllHojasDeRuta();
  Future<QuerySnapshot> getHojasDeRutaWithPagination(
      {int limit = 10, DocumentSnapshot? lastDocument, String usuarioId});
}

class FirebaseHojaDeRutaRepository implements HojaDeRutaRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath = 'hojas_de_ruta';

  @override
  Future<void> createHojaDeRuta(HojaDeRutaModel hojaDeRuta) async {
    try {
      final docRef = await _firestore.collection(collectionPath).add(hojaDeRuta.toJson());
      final generatedId = docRef.id;
      await docRef.update({'id': generatedId});
      await docRef.update({'created_at': DateTime.now()});
    } catch (e) {
      throw Exception('No se pudo crear la hoja de ruta.');
    }
  }

  @override
  Future<HojaDeRutaModel?> getHojaDeRutaById(String id) async {
    try {
      DocumentSnapshot docSnapshot = await _firestore.collection(collectionPath).doc(id).get();
      if (docSnapshot.exists) {
        return HojaDeRutaModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('No se pudo obtener la hoja de ruta.');
    }
  }

  @override
  Future<void> updateHojaDeRuta(String id, HojaDeRutaModel hojaDeRuta) async {
    try {
      await _firestore.collection(collectionPath).doc(id).update(hojaDeRuta.toJson());
    } catch (e) {
      throw Exception('No se pudo actualizar la hoja de ruta.');
    }
  }

  @override
  Future<void> deleteHojaDeRuta(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
    } catch (e) {
      throw Exception('No se pudo eliminar la hoja de ruta.');
    }
  }

  @override
  Future<List<HojaDeRutaModel>> getAllHojasDeRuta() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection(collectionPath).get();
      return querySnapshot.docs.map((doc) {
        return HojaDeRutaModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('No se pudieron obtener las hojas de ruta.');
    }
  }

  @override
  Future<QuerySnapshot> getHojasDeRutaWithPagination(
      {int limit = 10, DocumentSnapshot? lastDocument, String? usuarioId}) async {
    Query query = _firestore
        .collection(collectionPath)
        // .where('user_id', isEqualTo: usuarioId)
        .orderBy('created_at', descending: true)
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }
    final doc = await query.get();
    return await query.get();
  }
}
