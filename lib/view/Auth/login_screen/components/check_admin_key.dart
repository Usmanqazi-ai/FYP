import 'package:flutter/material.dart';
import 'package:stock_taking_application/view/Auth/sign_up_screen/sign_up_screen.dart';

import '../../../../resources/constants/app_Colors.dart';
import '../../../../resources/widgets/custom_text.dart';
class CheckAdminKey extends StatelessWidget {
  const CheckAdminKey({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController adminKeyController = TextEditingController();
    final GlobalKey<FormState> adminKeyFormKey = GlobalKey<FormState>();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: CustomText(text: 'Enter Admin Key'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(text:"Confirm that you are admin"),
          const SizedBox(height: 10),
          Form(
            key: adminKeyFormKey,
            child: TextFormField(
              validator: (value){
                if(value==null || value.isEmpty){
                  return 'Enter Key';
                }
                if(value != 'Admin123'){
                  return 'Enter Correct Key';
                }
                return null;
              },
              controller: adminKeyController,
              decoration: InputDecoration(
                hintText: "Enter Admin Key",
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
            if(adminKeyFormKey.currentState!.validate()){
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
            }
          },
          child: const Text("Add"),
        ),
      ],
    );;
  }
}
