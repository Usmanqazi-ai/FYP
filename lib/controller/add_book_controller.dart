import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddBook extends ChangeNotifier {
  final String scriptUrl = "";

  Future<void> handleBookScan(String accessionNo, int userRank) async {
    // 1. Check if book exists in Master sheet
    final checkResponse = await http.post(
      Uri.parse(scriptUrl),
      body: jsonEncode({
        'action': 'validate',
        'accessionNo': accessionNo,
      }),
    );

    if (!jsonDecode(checkResponse.body)['exists']) {
      showErrorMessage("Book not found ❌");
      return;
    }

    // 2. Add to UserEntries sheet
    final addResponse = await http.post(
      Uri.parse(scriptUrl),
      body: jsonEncode({
        'action': 'add',
        'accessionNo': accessionNo,
        'userRank': 1,
      }),
    );

    final result = jsonDecode(addResponse.body);
    if (result['error'] != null) {
      showErrorMessage(result['error']);
    } else {
      showSuccessMessage("Book added successfully ✅");
    }
  }

// ... (rest of your code)
}

void showErrorMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

void showSuccessMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
