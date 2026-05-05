import 'package:flutter/material.dart';

class WelcomeDate extends StatelessWidget {
  const WelcomeDate({
    super.key,
    required this.userName,
    required this.primaryColor,
  });

  final String userName;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome, $userName!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Date: ${DateTime.now().toLocal().toString().split(' ')[0]}",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}