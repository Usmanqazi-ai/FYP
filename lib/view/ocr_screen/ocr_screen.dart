import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:stock_taking_application/resources/widgets/add_accession_code_dialogue.dart';

import '../../resources/constants/app_Colors.dart';
import '../../resources/widgets/custom_text.dart';

class OcrScreen extends StatefulWidget {
  final File? imageFile;

  const OcrScreen({super.key, this.imageFile});

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  File? _image;
  String _extractedText = '';

  @override
  void initState() {
    super.initState();

    // If imageFile was passed, set it and start OCR immediately
    if (widget.imageFile != null) {
      _image = widget.imageFile;
      _startOcr();
    }
  }

  Future<void> _startOcr() async {
    if (_image == null) return;
    final inputImage = InputImage.fromFilePath(_image!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    setState(() {
      _extractedText = recognizedText.text;
    });
    print(_extractedText);
  }

  @override
  Widget build(BuildContext context) {
    List<String> lines = _extractedText.split('\n');
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryColor,
        title: const CustomText( color: Colors.white, text: 'OCR Scanner',fontSize: 24,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _image != null
                ? Image.file(
                    _image!,
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 0.9,
                    fit: BoxFit.contain,
                  )
                : Container(
                    height: 200,
                    color: Colors.grey[300],
                    child: const Center(child: Text('No image selected')),
                  ),
            const SizedBox(height: 16),

            // Action buttons
            Align(
              alignment: Alignment.topLeft,
                child: CustomText(text: 'Codes', fontSize: 24,fontWeight: FontWeight.bold,)),
            const SizedBox(height: 16),

            // Show results or loading

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: lines.map((line) {
                    return GestureDetector(
                      onTap: () {
                        final TextEditingController codeController = TextEditingController();
                        codeController.text=line;
                        if (!line.trim().toUpperCase().startsWith('F')) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Only codes starting with "F" are allowed.')),
                          );
                          return;

                        }
                        print('Tapped');
                        showDialog(
                          context: context,
                          builder: (context) => AddAccessionNoDialogue(
                            codeController: codeController,
                            manuallyAdd: false,
                          ),
                        );

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: AppColors.primaryColor)),
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Text(
                            line,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
