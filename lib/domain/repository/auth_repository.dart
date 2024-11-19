import 'package:app_remision/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserModel?> signIn(String email, String password);
  Future<void> signOut();
  Future<UserModel?> signUp(String email, String password, String name, String phone);
  Future<UserModel?> isAuthenticated();
  Future<String?> getCurrentUserId();
}

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel?> signIn(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    DocumentSnapshot doc = await _firestore.collection('users').doc(userCredential.user?.uid).get();
    if (doc.exists) {
      return UserModel.fromDocument(doc);
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserModel?> signUp(String email, String password, String name, String phone) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    UserModel newUser = UserModel(
      userId: userCredential.user!.uid,
      name: name,
      email: email,
      phone: phone,
    );
    await _firestore.collection('users').doc(newUser.userId).set(newUser.toJson());

    return newUser;
  }

  @override
  Future<UserModel?> isAuthenticated() async {
    final user = _firebaseAuth.currentUser;

    if (user != null) {
      final uid = user.uid;
      try {
        final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
        final userModel = UserModel.fromDocument(userDoc);
        if (userDoc.exists) {
          return userModel;
        } else {
          return null;
        }
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<String?> getCurrentUserId() async {
    return _firebaseAuth.currentUser?.uid;
  }
}
