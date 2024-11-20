import 'package:divyam_flutter/core/constants/image_constants.dart';

enum SocialOptions { share, rate, call, location, favourite }

extension SocialOptionsExtension on SocialOptions {
  String get name {
    switch (this) {
      case SocialOptions.share:
        return 'Share';
      case SocialOptions.call:
        return 'Call';
      case SocialOptions.location:
        return 'Location';
      case SocialOptions.rate:
        return 'Rating';
      case SocialOptions.favourite:
        return 'Favorite';
    }
  }

  String get assetName {
    switch (this) {
      case SocialOptions.share:
        return AppIcons.share;
      case SocialOptions.rate:
        return AppIcons.rate;
      case SocialOptions.call:
        return AppIcons.call;
      case SocialOptions.location:
        return AppIcons.location;
      case SocialOptions.favourite:
        return AppIcons.favourite;
    }
  }
}
