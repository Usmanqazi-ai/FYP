import 'package:flutter/material.dart';

import '../../login_screen/login_screen.dart';

class BackToLogin extends StatelessWidget {
  const BackToLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const LoginScreen())); // Go back to login;
      },
      child: const Text(
        'Back to Login',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}