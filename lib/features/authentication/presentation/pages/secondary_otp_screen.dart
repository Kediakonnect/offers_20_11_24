import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/get-final-string.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/new_password_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/otp_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_screen_two_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/secondary_otp_screen_entity.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

enum OTPMode { register, forgotPassword }

class SecondaryOtpScreen extends StatefulWidget {
  final SecondaryOtpEntityScreen secondaryOtpEntityScreen;

  const SecondaryOtpScreen({super.key, required this.secondaryOtpEntityScreen});

  @override
  State<SecondaryOtpScreen> createState() => _SecondaryOtpScreenState();
}

class _SecondaryOtpScreenState extends State<SecondaryOtpScreen> {
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Verify Otp",
      height: MediaQuery.of(context).size.height,
      enableMenu: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "SELECT LANGUAGE",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.primaryColor,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(
                                        1, 1), // position of the shadow
                                    blurRadius: 1.0, // blur effect
                                    color: Colors.black.withOpacity(
                                        0.15), // shadow color with 15% opacity
                                  ),
                                ],
                              ),
                            ),
                            CustomSpacers.width6,
                            SvgPicture.asset(
                              AppIcons.language,
                              width: 24.w,
                              height: 24.h,
                            ),
                          ],
                        ),
                      ),
                      CustomSpacers.height30,
                      Text(
                        "Enter OTP",
                        style:
                            AppTextThemes.theme(context).titleLarge!.copyWith(
                                  color: Colors.black,
                                ),
                      ),
                      CustomSpacers.height20,
                      if (widget.secondaryOtpEntityScreen.mobileOtp != null)
                        CustomTextField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          hintText: "Mobile OTP",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'OTP is required';
                            } else if (value.length != 3) {
                              return 'OTP must be exactly 3 digits';
                            }
                            return null;
                          },
                        ),
                      CustomSpacers.height20,
                      if (widget.secondaryOtpEntityScreen.emailOtp != null)
                        CustomTextField(
                          controller: _emailController,
                          keyboardType: TextInputType.phone,
                          hintText: "Email OTP",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'OTP is required';
                            } else if (value.length != 3) {
                              return 'OTP must be exactly 3 digits';
                            }
                            return null;
                          },
                        ),
                      CustomSpacers.height20,
                      CustomButton(
                        btnText: "Verify OTP",
                        height: 50,
                        width: double.infinity,
                        onPressed: _verifyOTP,
                      ),
                      CustomSpacers.height30,
                      GestureDetector(
                        child: Text(
                          "SIGN IN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorPalette.primaryColor,
                            shadows: [
                              Shadow(
                                offset: const Offset(
                                    1, 1), // position of the shadow
                                blurRadius: 1.0, // blur effect
                                color: Colors.black.withOpacity(
                                    0.15), // shadow color with 15% opacity
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _verifyOTP() {
    if (_formKey.currentState!.validate()) {}
  }
}
