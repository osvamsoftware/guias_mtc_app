import 'package:app_remision/core/settings/exception_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

abstract class SignatureRepository {
  Future<String> uploadSignature(String filePath);
  Future<String> getSignature(String fileName);
  Future<void> saveSignatureUrl(String userId, String signatureUrl);
}

class FirebaseSignatureRepository implements SignatureRepository {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<String> uploadSignature(String filePath) async {
    try {
      File file = File(filePath);
      String fileName = 'signatures/${DateTime.now().millisecondsSinceEpoch}.png';
      await firebaseStorage.ref(fileName).putFile(file);
      String downloadUrl = await firebaseStorage.ref(fileName).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      if (e is FirebaseException) {
        throw FirebaseExceptionR(e.code, e.message, e.plugin, e.stackTrace);
      } else {
        throw Exception('Error uploading signature: $e');
      }
    }
  }

  @override
  Future<String> getSignature(String fileName) async {
    try {
      String downloadUrl = await firebaseStorage.ref(fileName).getDownloadURL();
      return downloadUrl;
    } catch (e) {
      if (e is FirebaseException) {
        throw FirebaseExceptionR(e.code, e.message, e.plugin, e.stackTrace);
      } else {
        throw Exception('Error retrieving signature: $e');
      }
    }
  }

  @override
  Future<void> saveSignatureUrl(String userId, String signatureUrl) async {
    try {
      await firestore.collection('users').doc(userId).update({
        'signature_url': signatureUrl,
      });
    } catch (e) {
      throw Exception('Error al guardar la URL de la firma');
    }
  }
}
