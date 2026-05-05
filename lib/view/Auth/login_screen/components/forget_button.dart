import 'package:flutter/material.dart';
import 'package:stock_taking_application/resources/constants/app_Colors.dart';

import '../../forget_password_screen/forget_screen.dart';

class ForgetButton extends StatelessWidget {
  const ForgetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) =>
                  const ForgotPasswordScreen()));
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}