import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/helpers/user_helpers.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_type_enum.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void routeToPage(BuildContext context) async {
    var token = UserHelpers.getAuthToken();
    if (token.isNotEmpty) {
      CustomNavigator.pushReplace(
        context,
        AppRouter.addsScreen,
        arguments: OfferType.entry.value,
      );
    } else {
      CustomNavigator.pushReplace(context, AppRouter.loginScreen);
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () => routeToPage(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryColor,
      body: Center(
        child: SizedBox(
          child: Image.asset(
            fit: BoxFit.fitWidth,
            AppIcons.appLogo2,
          ),
        ),
      ),
    );
  }
}
