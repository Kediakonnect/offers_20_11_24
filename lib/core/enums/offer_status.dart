import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:flutter/material.dart';

enum OfferStatusType { pending, rejected, suspended }

extension OfferStatusTypeExtension on OfferStatusType {
  String get name {
    switch (this) {
      case OfferStatusType.pending:
        return 'Pending';
      case OfferStatusType.rejected:
        return 'Rejected';
      case OfferStatusType.suspended:
        return 'Suspended';
    }
  }

  Color get color {
    switch (this) {
      case OfferStatusType.pending:
        return ColorPalette.yellow;
      case OfferStatusType.rejected:
        return ColorPalette.red;
      case OfferStatusType.suspended:
        return ColorPalette.red;
    }
  }
}
