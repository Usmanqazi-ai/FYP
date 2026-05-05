import 'package:flutter/material.dart';

import 'check_admin_key.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Don’t have an account? ',
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            print('Tapped');
            showDialog(
              context: context, // Make sure you have access to 'context'
              builder: (context) => const CheckAdminKey(),
            );  },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
