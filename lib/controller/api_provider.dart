import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class ApiProvider extends ChangeNotifier {
  // Future<void> handleBookScan(String accessionNo, int userRank) async {
  //   try {
  //     print('❤❤❤❤');
  //     // Verify script URL ends with /exec (not /dev)
  //     const scriptUrl =
  //         'https://script.google.com/macros/s/AKfycbxih5wETfe7QeAs-LpZwvQUlrQCB4PMLrjLcW1HqkSG5hxSXWemJBDN740yLI0ikfXi0Q/exec';
  //
  //     // 1. Validate book exists
  //     final checkResponse = await http.post(
  //       Uri.parse(scriptUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'accessionNo': accessionNo,
  //         'userRank': userRank, // Include rank in initial request
  //       }),
  //     );
  //     print('Status: ${checkResponse.statusCode}');
  //     print('Headers: ${checkResponse.headers}');
  //     print('😋😋 ${checkResponse.body}');
  //     // Improved error handling
  //
  //     final checkResult = jsonDecode(checkResponse.body);
  //     print("responce ......$checkResult");
  //     // _validateResponse(checkResponse, checkResult);
  //     if (checkResult['error'] != null) {
  //       print('😂😂😂${checkResult['error']}');
  //       throw '😋😋😋😋😋😋😋😋😋😋😋😋😋😋😋';
  //     }
  //
  //     showSuccessMessage("Book processed successfully!");
  //   } catch (e) {
  //     print('😶😶😶😶😶');
  //     showErrorMessage('Not Added Yetdfhsgfsjdfshj');
  //     debugPrint('Error: $e');
  //   }
  // }

//   void _validateResponse(http.Response response, final checkResponse) {
//     if (response.statusCode != 200) {
//       throw checkResponse['error'];
//
//       // throw 'Server returned status code ${response.statusCode}';
//     }
//
//     final body = response.body.trim();
//
//     if (body.isEmpty) {
//       throw 'Empty response from server';
//     }
//
//     if (body.startsWith('<')) {
//       throw '''Configuration error. Please verify:
// 1. Correct deployment URL (ends with /exec)
// 2. Script is deployed as Web App
// 3. Execute as: "Me"
// 4. Access: "Anyone"
//
// HTML Response Received:
// ${body.length > 200 ? body.substring(0, 200) + '...' : body}''';
//     }
//
//     try {
//       jsonDecode(body); // Test if valid JSON
//     } catch (e) {
//       throw 'Invalid JSON response: ${body.length > 200 ? body.substring(0, 200) + '...' : body}';
//     }
//   }

  // Future<void> handleBookScan(String accessionNo, int userRank) async {
  //   final scriptUrl = 'https://script.google.com/macros/s/AKfycbxih5wETfe7QeAs-LpZwvQUlrQCB4PMLrjLcW1HqkSG5hxSXWemJBDN740yLI0ikfXi0Q/exec';
  //
  //   try {
  //     final client = http.Client();
  //     final response = await client.post(
  //       Uri.parse(scriptUrl),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'accessionNo': accessionNo,
  //         'userRank': userRank,
  //       }),
  //     );
  //     final json = jsonDecode(response.body);
  //      print(json);
  //     if (response.statusCode == 302) {
  //       throw '❌ Redirect received. Check deployment permissions.';
  //     }
  //
  //
  //     if (json['error'] != null) {
  //       throw 'Error: ${json['error']}';
  //     }
  //
  //     print("✅ Book Added: ${json['book']}");
  //     showSuccessMessage("Book processed successfully!");
  //   } catch (e) {
  //     print("❌ Error: $e");
  //     showErrorMessage("Failed to add book.");
  //   }
  // }
  Future<void> testGet() async {
    final response = await http.get(Uri.parse('https://script.google.com/macros/s/AKfycbxih5wETfe7QeAs-LpZwvQUlrQCB4PMLrjLcW1HqkSG5hxSXWemJBDN740yLI0ikfXi0Q/exec'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('Status: ${data['status']}');
      print('Message: ${data['message']}');
      print('Timestamp: ${data['timestamp']}');
      print('Instructions: ${data['instructions']}');
    } else {
      print('Failed: ${response.statusCode}');
    }
  }
  Future<void> sendBookRequest(String accessionNo, int userRank) async {
    final client = http.Client();
    final request = http.Request('POST', Uri.parse('https://script.google.com/macros/s/AKfycbxih5wETfe7QeAs-LpZwvQUlrQCB4PMLrjLcW1HqkSG5hxSXWemJBDN740yLI0ikfXi0Q/exec'))
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        'accessionNo': accessionNo,
        'userRank': userRank,
      });

    final streamedResponse = await client.send(request);

    if (streamedResponse.isRedirect) {
      print("Redirected to: ${streamedResponse.headers['location']}");
    } else {
      final response = await http.Response.fromStream(streamedResponse);
      final data = jsonDecode(response.body);
      print(data);
    }


    // final response = await http.post(
    //   Uri.parse('https://script.google.com/macros/s/AKfycbxih5wETfe7QeAs-LpZwvQUlrQCB4PMLrjLcW1HqkSG5hxSXWemJBDN740yLI0ikfXi0Q/exec'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({
    //     'accessionNo': accessionNo,
    //     'userRank': userRank,
    //   }),
    // );
    // // final data = jsonDecode(response.body);
    // // print('😋😋😋😋😋 $data');
    // if (response.statusCode == 302) {
    //   final data = jsonDecode(response.body);
    //
    //   if (data.containsKey('success') && data['success'] == true) {
    //     print('✅ Book added:');
    //     print('Accession No: ${data['book']['accessionNo']}');
    //     print('Title: ${data['book']['title']}');
    //     print('Author: ${data['book']['author']}');
    //   } else if (data.containsKey('error')) {
    //     print('❌ Error: ${data['error']}');
    //   }
    // } else {
    //   print('❌ Server error: ${response.statusCode}');
    // }
  }

  void showErrorMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showSuccessMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Future<void> downloadExcelSheetAvailableBooks() async {
    print('💟💟💟💟💟💟💟💟');
    String url =
        'https://docs.google.com/spreadsheets/d/1VuthCueVK-tRlxlgqXAYmYCHk6Wccdlc6Gkn6cLDyLA/export?format=xlsx';
    var status = await Permission.storage.request();
    if (!status.isGranted) {
      print("❌ Storage permission denied");
      return;
    }

    try {
      print('💟💟💟💟💟💟💟💟💨💨💨💨💨💨');
      final downloadsDir = Directory('/storage/emulated/0/Download');
      final now = DateTime.now();
      final fileName = 'Available_Books_${now.millisecondsSinceEpoch}.xlsx';
      final filePath = '${downloadsDir.path}/$fileName';

      final dio = Dio();
      await dio.download(url, filePath);

      print('✅ Excel file downloaded to: $filePath');
    } catch (e) {
      print('❌ Download failed: $e');
    }
  }

  Future<void> openBookDataSpreadSheet() async {
    final Uri url = Uri.parse(
        'https://docs.google.com/spreadsheets/d/1VuthCueVK-tRlxlgqXAYmYCHk6Wccdlc6Gkn6cLDyLA/edit');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw '❌ Could not launch $url';
    }
  }
}
