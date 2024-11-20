import 'package:divyam_flutter/core/constants/image_constants.dart';

enum EventSocialIcons { share, like, unlike, favorite }

extension EventSocialIconsExtension on EventSocialIcons {
  String get assetName {
    switch (this) {
      case EventSocialIcons.share:
        return AppIcons.share;
      case EventSocialIcons.like:
        return AppIcons.like;
      case EventSocialIcons.unlike:
        return AppIcons.unlike;
      case EventSocialIcons.favorite:
        return AppIcons.favourite;
    }
  }

  String get name {
    switch (this) {
      case EventSocialIcons.share:
        return 'Share';
      case EventSocialIcons.like:
        return 'Like';
      case EventSocialIcons.unlike:
        return 'Dislike';
      case EventSocialIcons.favorite:
        return 'Favorite';
    }
  }
}
