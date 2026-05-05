import 'package:flutter/material.dart';
import 'package:stock_taking_application/resources/constants/app_Colors.dart';

class ImagesPicker extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const ImagesPicker({
    super.key, required this.icon, required this.text, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon:Icon(icon),
      label: Text(text, style: const TextStyle(fontSize: 16)),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        minimumSize: const Size.fromHeight(55),
      ),
    );
  }
}