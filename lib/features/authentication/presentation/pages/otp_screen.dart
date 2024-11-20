import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/get-final-string.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/new_password_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/otp_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_screen_two_entity.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

enum OTPMode { register, forgotPassword }

class OTPScreen extends StatefulWidget {
  final OtpScreenEntity otpScreenEntity;

  const OTPScreen({super.key, required this.otpScreenEntity});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    String title = widget.otpScreenEntity.otpMode == OTPMode.forgotPassword
        ? "Verify OTP for Forgot Password"
        : "Verify OTP for Registration";

    String noteMessage = widget.otpScreenEntity.otpMode ==
            OTPMode.forgotPassword
        ? "Note: Enter the OTP sent to +91-${widget.otpScreenEntity.mobileNumber} for password reset"
        : "Note: Enter the OTP sent to +91-${widget.otpScreenEntity.mobileNumber} for registration";

    return CustomScaffold(
      appBarTitle: title,
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
                      CustomSpacers.height15,
                      Text(
                        getFinalLabel(noteMessage),
                        style:
                            AppTextThemes.theme(context).bodyMedium!.copyWith(
                                  color: ColorPalette.textDark,
                                ),
                      ),
                      CustomSpacers.height20,
                      CustomTextField(
                        controller: _textController,
                        keyboardType: TextInputType.phone,
                        hintText: "OTP",
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
    if (_formKey.currentState!.validate()) {
      if (widget.otpScreenEntity.otpMode == OTPMode.forgotPassword) {
        _verifyForgotPasswordOTP();
      } else if (widget.otpScreenEntity.otpMode == OTPMode.register) {
        _verifyRegisterOTP();
      }
    }
  }

  void _verifyForgotPasswordOTP() {
    // Handle OTP verification for forgot password
    if (widget.otpScreenEntity.otp == int.tryParse(_textController.text)) {
      CustomNavigator.pushTo(
        context,
        AppRouter.newPasswordScreen,
        arguments: NewPasswordScreenEntity(
          mobileNumber: widget.otpScreenEntity.mobileNumber,
        ),
      );
      ScaffoldHelper.showSuccessSnackBar(
        context: context,
        message: "OTP Verified. Proceed to password reset.",
      );
    } else {
      ScaffoldHelper.showFailureSnackBar(
        context: context,
        message: "Invalid OTP for password reset.",
      );
    }
  }

  void _verifyRegisterOTP() {
    // Handle OTP verification for registration
    if (widget.otpScreenEntity.otp == int.tryParse(_textController.text)) {
      // OTP is correct, proceed to the next step
      CustomNavigator.pushReplace(
        context,
        AppRouter.registerScreenTwo,
        arguments: RegisterScreenTwoEntity(
          mobileNumber: widget.otpScreenEntity.mobileNumber,
          referralCode: widget.otpScreenEntity.referralCode,
        ),
      );
    } else {
      ScaffoldHelper.showFailureSnackBar(
        context: context,
        message: "Invalid OTP for registration.",
      );
    }
  }
}
