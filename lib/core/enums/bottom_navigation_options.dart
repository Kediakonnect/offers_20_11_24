import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/router/app_routes.dart';

enum BottomNavigationOptions { offer, directory, highlights, events }

extension BottomNavigationOptionsExtension on BottomNavigationOptions {
  String get assetName {
    switch (this) {
      case BottomNavigationOptions.offer:
        return AppIcons.offer;
      case BottomNavigationOptions.directory:
        return AppIcons.directory;
      case BottomNavigationOptions.highlights:
        return AppIcons.highlights;
      case BottomNavigationOptions.events:
        return AppIcons.events;
    }
  }

  String get routeName {
    switch (this) {
      case BottomNavigationOptions.offer:
        return AppRouter.offersScreen;
      case BottomNavigationOptions.directory:
        return AppRouter.businessDirectoryScreen;
      case BottomNavigationOptions.highlights:
        return AppRouter.highLightScreen;
      case BottomNavigationOptions.events:
        return AppRouter.eventScreen;
    }
  }

  String get textValue {
    switch (this) {
      case BottomNavigationOptions.offer:
        return 'Offers';
      case BottomNavigationOptions.directory:
        return 'Directory';
      case BottomNavigationOptions.highlights:
        return 'Highlights';
      case BottomNavigationOptions.events:
        return 'Events';
    }
  }
}
