import 'dart:io';

import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/neuromorphic_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PdfPickerWidget extends StatefulWidget {
  const PdfPickerWidget({super.key});

  @override
  State<PdfPickerWidget> createState() => _PdfPickerWidgetState();
}

class _PdfPickerWidgetState extends State<PdfPickerWidget> {
  File? _selectedFile;
  String text =
      'Enter appropriate information in the agreement, then sign, print and upload it.Download sample agreement';
  String fileName = '';
  @override
  Widget build(BuildContext context) {
    return _buildPrimaryImage();
  }

  void _extractName(String path) {
    // Extract the last name of the file
    fileName = path.split('/').last;

    print(fileName); // Output: name.pdf
  }

  Widget _buildPrimaryImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fileName.isNotEmpty
                        ? fileName
                        : 'Enter appropriate information in the agreement, then sign, print and upload it.Download sample agreement',
                    textAlign: TextAlign.start,
                    style: AppTextThemes.theme(context).headlineLarge,
                  ),
                  CustomSpacers.height20,
                  Text(
                    'Download sample agreement',
                    style: AppTextThemes.theme(context).headlineLarge?.copyWith(
                          color: ColorPalette.primaryColor,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
        NeuromorphicButton(
          btnText: 'Select PDF',
          onPressed: () => _pickFile(),
        ),
      ],
    );
  }

  Future<void> _pickFile() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _selectedFile = File(result.files.single.path!);
      _extractName(_selectedFile!.path);
      setState(() {});
    }
  }
}
