import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopbiz_app/data/models/user_model.dart';

class FirebaseServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up Method
  Future<UserModel?> signUp({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String profilePic,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user model
      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        name: name,
        email: email,
        profilePic: profilePic,
        phoneNumber: phoneNumber,
      );

      // Save user data to Firestore
      await _firestore.collection('users').doc(user.uid).set(user.toMap());

      return user;
    } catch (e) {
      print(e); // Handle error
      return null;
    }
  }

  // Login Method
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch user data from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print(e); // Handle error
      return null;
    }
  }
}
