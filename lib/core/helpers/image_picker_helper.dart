import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();
  static File? _imageFile;

  static Future<XFile?> pickImageFromCamera({int? resolution}) async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.camera, Permission.storage].request();
    print("Asked for permission");

    if (statuses[Permission.camera] != PermissionStatus.granted) {
      await [Permission.camera, Permission.storage].request();
    }

    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _imageFile = File(image.path);
      return _compressFile(_imageFile!);
    }
    return null;
  }

  static Future<XFile?> pickImageFromGallery() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.photos, Permission.storage].request();
    print("Asked for permission");

    if (statuses[Permission.photos] != PermissionStatus.granted) {
      await [Permission.photos, Permission.storage].request();
    }

    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      return _compressFile(_imageFile!);
    }
    return null;
  }

  static Future<XFile?> _compressFile(File imageFile, {int? quality}) async {
    try {
      final filePath = imageFile.absolute.path;
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final splitted = filePath.substring(0, lastIndex);
      final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
      var result = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        outPath,
        quality: 25,
      );
      return result;
    } catch (e) {
      rethrow;
    }
  }

  static Future<File?> editImage(
      {required File imageFile, required BuildContext context}) async {
    try {
      final editedImage = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditor(
            image: imageFile.readAsBytesSync(),
          ),
        ),
      );
      if (editedImage == null) return null;

      // Convert Uint8List to a File
      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/edited_image.png';
      final file = File(filePath);
      await file.writeAsBytes(editedImage);

      return file;
    } catch (e) {
      print('Error editing image: $e');
    }
    return null;
  }

  static void disposeImageFile() {
    if (_imageFile != null && _imageFile!.existsSync()) {
      _imageFile!.delete();
      _imageFile = null;
    }
  }
}
