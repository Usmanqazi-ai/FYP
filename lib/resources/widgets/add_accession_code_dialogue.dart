import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_taking_application/controller/api_provider.dart';
import '../../controller/home_screen_provider.dart';
import '../constants/app_Colors.dart';
import 'custom_text.dart';

class AddAccessionNoDialogue extends StatelessWidget {
  final bool manuallyAdd;

  AddAccessionNoDialogue({
    super.key,
    required TextEditingController codeController,
    required this.manuallyAdd,
  }) : _codeController = codeController;

  final TextEditingController _codeController;
  final GlobalKey<FormState> codeKeyFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context,controller,child) {
        return Consumer<ApiProvider>(
          builder: (context,apiProvider,child) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: manuallyAdd == true
                  ? CustomText(text: "Manual Book Code Entry")
                  : CustomText(text: 'Check Code'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  manuallyAdd == true
                      ? CustomText(text: "Enter the library book code manually:")
                      : CustomText(text: 'This code will be add'),
                  const SizedBox(height: 10),
                  Form(
                    key: codeKeyFormKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Add Code';
                        }

                        if (!value.startsWith('F')) {
                          return 'Code must start with F';
                        }

                        return null;
                      },
                      controller: _codeController,
                      decoration: InputDecoration(
                        hintText: "F000",
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (codeKeyFormKey.currentState!.validate()) {
                      // await apiProvider.handleBookScan(_codeController.text.trim(), controller.rackNo);
                      // apiProvider.testGet();
                      apiProvider.sendBookRequest(_codeController.text.trim(), controller.rackNo);
                    }
                  },
                  child: const Text("Add"),
                ),
              ],
            );
          }
        );
      }
    );
  }
}
