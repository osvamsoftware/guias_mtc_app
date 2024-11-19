import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String? signatureUrl;
  final String? logoUrl;

  UserModel(
      {required this.userId,
      required this.name,
      required this.email,
      required this.phone,
      this.signatureUrl,
      this.logoUrl});

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
        userId: doc.id,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        phone: data['phone'] ?? '',
        signatureUrl: data['signature_url'] ?? '',
        logoUrl: data['logo_url'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone, 'signature_url': signatureUrl, 'logo_url': logoUrl};
  }
}
