import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginProvider extends ChangeNotifier{
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  TextEditingController get emailController=> _emailController;
  TextEditingController get passwordController=> _passwordController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;


  Future<User?> login(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();

      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      isLoading = false;
      notifyListeners();

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      notifyListeners();

      String errorMessage = 'Login failed';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found with this email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password.';
      }

      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: const Color(0xFF3f5c4a),
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return null;
    } catch (e) {
      isLoading = false;
      notifyListeners();

      Fluttertoast.showToast(
        msg: 'Something went wrong. Please try again.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: const Color(0xFF3f5c4a),
        textColor: Colors.white,
        fontSize: 16.0,
      );

      return null;
    }
  }

}