import 'package:flutter/material.dart';
import 'package:stock_taking_application/resources/constants/app_Colors.dart';


class CustomTextFields extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const CustomTextFields({
    super.key, required this.label, required this.icon, this.suffixIcon, this.obscureText=false, required this.controller, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primaryColor),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey[100],
        labelStyle: TextStyle(
          color: AppColors.primaryColor.withOpacity(0.8),
          fontWeight: FontWeight.w600,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}