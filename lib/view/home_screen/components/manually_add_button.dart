import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../../controller/home_screen_provider.dart';
import '../../../resources/widgets/add_accession_code_dialogue.dart';

class ManuallyAddButton extends StatelessWidget {
  const ManuallyAddButton({
    super.key,
    required this.primaryColor,
  });

//d
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(builder: (context, controller, child) {
      return OutlinedButton.icon(
        icon: const Icon(Icons.edit_note),
        label: const Text("Manual Entry", style: TextStyle(fontSize: 16)),
        onPressed: () {
          if (controller.rackNo != 0) {
            showDialog(
              context: context,
              builder: (context) {
                final TextEditingController codeController =
                    TextEditingController();

                return AddAccessionNoDialogue(
                  codeController: codeController,
                  manuallyAdd: true,
                );
              },
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Select Rack First',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              backgroundColor: const Color(0xFF3f5c4a),
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: primaryColor, width: 2),
          foregroundColor: primaryColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          minimumSize: const Size.fromHeight(55),
        ),
      );
    });
  }
}
