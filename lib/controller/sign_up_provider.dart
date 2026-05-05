import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
class SignUpProvider extends ChangeNotifier {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  TextEditingController get userNameController => _userNameController;

  TextEditingController get emailController => _emailController;

  TextEditingController get passwordController => _passwordController;

  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  Future<void> signUpUser(BuildContext context) async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();
      final String userName = userNameController.text.trim();

      // 1. Create user in Firebase Auth
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Save username and email in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'username': userName,
        'createdAt': DateTime.now(),
      });

      // Optional: show success message
      Fluttertoast.showToast(
        msg: "Account created successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: const Color(0xFF3f5c4a),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on FirebaseAuthException catch (e) {
      String error = 'Something went wrong';
      if (e.code == 'email-already-in-use') {
        error = 'Email already in use';
      } else if (e.code == 'weak-password') {
        error = 'Password should be at least 6 characters';
      }

      Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: const Color(0xFF3f5c4a),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Error: $e',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: const Color(0xFF3f5c4a),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

}
