import 'dart:ui';

import 'package:divyam_flutter/core/constants/color_palette.dart';

enum BusinessStatusType { live, suspended }

extension BusinessStatusTypeExtension on BusinessStatusType {
  String get name {
    switch (this) {
      case BusinessStatusType.live:
        return 'Live';
      case BusinessStatusType.suspended:
        return 'Suspended';
    }
  }

  Color get color {
    switch (this) {
      case BusinessStatusType.live:
        return ColorPalette.green;
      case BusinessStatusType.suspended:
        return ColorPalette.red;
    }
  }
}
