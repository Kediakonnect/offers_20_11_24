import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/managers/shared_preference_manager.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart'
    as di;
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

class AppManager {
  static Future<void> initialize() async {
    await SharedPreferencesManager.init();
    await Hive.initFlutter();
    Hive.registerAdapter(StateModelResponseAdapter());
    Hive.registerAdapter(StateModelAdapter());
    Hive.registerAdapter(DistrictAdapter());
    Hive.registerAdapter(TalukaAdapter());
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorPalette.primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: ColorPalette.primaryColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    di.init();
  }
}
