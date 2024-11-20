import 'package:divyam_flutter/core/constants/image_constants.dart';

enum SocialOptionsOffers { share, like, dislike, view, favorite }

extension SocialOptionsExtension on SocialOptionsOffers {
  String get name {
    switch (this) {
      case SocialOptionsOffers.share:
        return 'Share';
      case SocialOptionsOffers.like:
        return 'Like';
      case SocialOptionsOffers.dislike:
        return 'Dislike';
      case SocialOptionsOffers.view:
        return 'Views';
      case SocialOptionsOffers.favorite:
        return 'Favorite';
    }
  }
}
