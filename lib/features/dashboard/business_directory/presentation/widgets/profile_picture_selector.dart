import 'dart:io';

import 'package:divyam_flutter/core/helpers/image_picker_helper.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/download_image.dart';
import 'package:divyam_flutter/ui/moleclues/neuromorphic_button.dart';
import 'package:divyam_flutter/ui/moleclues/profile_picture.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class ProfilePicViewerOrSelectorWidget extends StatefulWidget {
  final String? networkUrl;
  final File? defaultImage;
  final bool? isEditable;
  final Function(File?)? onChanged;
  final String label, changeImageText;
  const ProfilePicViewerOrSelectorWidget(
      {super.key,
      this.networkUrl,
      this.isEditable = false,
      this.defaultImage,
      this.onChanged,
      required this.label,
      required this.changeImageText});

  @override
  State<ProfilePicViewerOrSelectorWidget> createState() =>
      _ProfilePicViewerOrSelectorWidgetState();
}

class _ProfilePicViewerOrSelectorWidgetState
    extends State<ProfilePicViewerOrSelectorWidget> {
  XFile? image;
  late String text;

  @override
  void initState() {
    text = widget.label;
    if (widget.defaultImage != null) {
      image = XFile(widget.defaultImage!.path);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (image != null)
          ProfilePicture.file(
            path: image!.path,
            size: 120,
          ),
        if (image == null &&
            widget.networkUrl != null &&
            widget.networkUrl!.isNotEmpty) ...[
          ProfilePicture.network(
            path: widget.networkUrl!,
            size: 120,
          ),
        ],
        if (image == null && widget.networkUrl == null)
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Text(
              text,
              style: AppTextThemes.theme(context).titleLarge,
            ),
          ),
        // Layout the text and the button in a row
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (widget.networkUrl == "" && image == null)
                Expanded(
                  child: Text(
                    text,
                    style: AppTextThemes.theme(context).titleLarge,
                  ),
                ),
              CustomSpacers.width10,
              NeuromorphicButton(
                btnText: 'Select image',
                onPressed: () {
                  print('btn pressed');
                  _pickImage();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage() async {
    XFile? file = await ScaffoldHelper.pickImage(context);

    if ((image == null && file != null) || file != null) {
      if (widget.isEditable!) {
        File? editedFile = await ImagePickerHelper.editImage(
            imageFile: File(file.path), context: context);

        if (editedFile != null) {
          file = XFile(editedFile.path);
        }
      }
      // Generate a new target path for the compressed image
      final String targetPath = '${file.path}_compressed.jpg';

      // Compress the image to 50x50 pixels
      XFile? compressedFile = await FlutterImageCompress.compressAndGetFile(
        file.path,
        targetPath, // Provide a different path for the compressed image
        minWidth: 150,
        minHeight: 150,
        quality: 85, // Adjust the quality as needed
      );

      if (compressedFile != null) {
        text = widget.changeImageText;
        image = XFile(compressedFile.path); // Use the compressed image

        File? imageFile;
        if (image == null && widget.networkUrl != null) {
          imageFile = await NetworkImageHelper.downloadAndSaveImageTemp(
              widget.networkUrl!);
        }

        widget.onChanged
            ?.call(image?.path != null ? File(image!.path) : imageFile);

        setState(() {});
      }
    }
  }
}
