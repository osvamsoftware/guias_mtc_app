import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class MediaStorageRepository {
  Future<String> uploadLogo(String filePath);
  Future<void> saveLogoUrl(String userId, String logoUrl);
}

class FirebaseMediaStorageRepository extends MediaStorageRepository {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<String> uploadLogo(String filePath) async {
    try {
      File file = File(filePath);
      String fileName = 'logos/${DateTime.now().millisecondsSinceEpoch}.png';
      await firebaseStorage.ref(fileName).putFile(file);
      return await firebaseStorage.ref(fileName).getDownloadURL();
    } catch (e) {
      throw Exception('Error uploading logo: $e');
    }
  }

  @override
  Future<void> saveLogoUrl(String userId, String logoUrl) async {
    try {
      await firestore.collection('users').doc(userId).update({'logo_url': logoUrl});
    } catch (e) {
      throw Exception('Error al guardar la URL del logo');
    }
  }
}
