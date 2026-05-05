import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  String? username;
  String? email;
  String? phoneNumber;

  Future<void> fetchUserData() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      username = doc.data()?['username'] ?? '';
      email = doc.data()?['email'] ?? '';
      phoneNumber = doc.data()?['phoneNumber'] ?? '';
      notifyListeners();
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }
}
