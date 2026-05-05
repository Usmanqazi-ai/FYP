import 'package:flutter/material.dart';
import 'package:stock_taking_application/resources/constants/app_Colors.dart';

class Buttons extends StatelessWidget {
  const Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        OutlinedButton.icon(
          icon: const Icon(Icons.refresh, color: AppColors.primaryColor,),
          label: const Text('Again'),
          onPressed: () {

          },
        ),
      ],
    );
  }
}