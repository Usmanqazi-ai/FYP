import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import '../../controller/home_screen_provider.dart';
import '../../controller/profile_screen_provider.dart';
import '../ocr_screen/ocr_screen.dart';
import 'components/hisory.dart';
import 'components/image_picker.dart';
import 'components/manually_add_button.dart';
import 'components/rank_selection_box.dart';
import 'components/welcome_date.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch user data when screen loads
    Provider.of<ProfileProvider>(context, listen: false).fetchUserData();
  }
  final Color primaryColor = const Color(0xFF3f5c4a);
  final List<String> recentScans = ["B001-A54", "B002-XZ3", "B003-19Q"];







  final ImagePicker _picker = ImagePicker();

// Pick image from gallery
  File? _selectedImage;

  Future<void> pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OcrScreen(imageFile: _selectedImage),
            ));// store File
      });
    }
  }

// Pick image from camera


  Future<void> pickImageFromCamera() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);  // store File
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OcrScreen(imageFile: _selectedImage),
            ));// store File
      });

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          "Stock Taking",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context,controller,child) {
          final username = controller.username;
          return Consumer<HomeScreenProvider>(
            builder: (context,homeProvider,child) {
              return SafeArea(
                child: Container(
                  color: Colors.grey[100],
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Welcome + Date
                        WelcomeDate(userName: username?? " ", primaryColor: primaryColor),

                        const SizedBox(height: 20),

                        // Logo or Image
                        
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/img.png',
                            height: 100,
                          ),
                        )
                        ,

                        const SizedBox(height: 30),

                        // Buttons
                        ImagesPicker(icon: Icons.photo_camera, text: "Scan via Camera",
                          onPressed: () async{
                            if(homeProvider.rackNo!=0){
                              await pickImageFromCamera();}
                            else{
                              Fluttertoast.showToast(
                                msg: 'Select Rack First',
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP,
                                backgroundColor: const Color(0xFF3f5c4a),
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          },),

                        const SizedBox(height: 16),
                        ImagesPicker(icon: Icons.photo_library, text: "Select from Gallery",
                          onPressed: () async{
                          if(homeProvider.rackNo!=0){
                          await pickImageFromGallery();}
                          else{
                            Fluttertoast.showToast(
                              msg: 'Select Rack First',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.TOP,
                              backgroundColor: const Color(0xFF3f5c4a),
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
              },),
                        const SizedBox(height: 16),

                        ManuallyAddButton(primaryColor: primaryColor),

                        const SizedBox(height: 30),
                        const Divider(),

                        // Rank selection box
                        RankSelectionBox(primaryColor: primaryColor, selectedRank: homeProvider.selectedRack, onTap: () {  homeProvider.selectRank(context); },),

                        const SizedBox(height: 30),

                        // Recent Scans
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "📚 Recent Scans",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 10),

                        ...recentScans.map((code) => History(code: code,)),

                        const SizedBox(height: 30),

                        // Quote
                        // Text(
                        //   '"A room without books is like a body without a soul."',
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     fontStyle: FontStyle.italic,
                        //     fontSize: 14,
                        //     color: Colors.grey[700],
                        //   ),
                        // ),
                        //
                        // const SizedBox(height: 20),
                        //
                        // // Tip Section
                        // Container(
                        //   padding: const EdgeInsets.all(12),
                        //   margin: const EdgeInsets.only(bottom: 10),
                        //   decoration: BoxDecoration(
                        //     color: const Color(0xFFe8f5e9),
                        //     borderRadius: BorderRadius.circular(10),
                        //   ),
                        //   child: Row(
                        //     children: const [
                        //       Icon(Icons.lightbulb_outline, color: Color(0xFF3f5c4a)),
                        //       SizedBox(width: 10),
                        //       Expanded(
                        //         child: Text(
                        //           "Tip: Use natural light for best scan accuracy.",
                        //           style: TextStyle(fontSize: 14),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }
          );
        }
      ),
    );
  }


}