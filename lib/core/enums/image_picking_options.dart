import 'package:flutter/material.dart';

enum ImagePickingOptions {
  gallery,
  camera,
}

extension ImagePickingOptionsExtension on ImagePickingOptions {
  bool get isCamera => this == ImagePickingOptions.camera;
  bool get isGallery => this == ImagePickingOptions.gallery;

  String get name {
    switch (this) {
      case ImagePickingOptions.gallery:
        return 'Gallery';
      case ImagePickingOptions.camera:
        return 'Camera';
    }
  }

  IconData get icon {
    switch (this) {
      case ImagePickingOptions.gallery:
        return Icons.image;
      case ImagePickingOptions.camera:
        return Icons.camera_alt;
    }
  }
}
