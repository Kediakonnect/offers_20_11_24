import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/get-final-string.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/generate_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/otp_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/presentation/blocs/auth_bloc/auth_cubit.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/otp_screen.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _phoneTC;
  late TextEditingController _refCodeTC;
  late AuthBloc _bloc;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _phoneTC = TextEditingController();
    _refCodeTC = TextEditingController();
    _bloc = sl<AuthBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _phoneTC.dispose();
    _refCodeTC.dispose();
    super.dispose();
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    } else if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
      return 'Enter a valid mobile number';
    }
    return null;
  }

  String? _validateReferralCode(String? value) {
    if (value != null && value.isNotEmpty) {
      if (value == _phoneTC.text) {
        return 'Referral code cannot be the same as the mobile number';
      }
    }
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _bloc.generateOTP(
        entity: GenerateOtpEntity(
          mobile: _phoneTC.text,
          refCode: _refCodeTC.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        appBarTitle: "REGISTER 1/3",
        height: MediaQuery.of(context).size.height,
        enableMenu: false,
        body: BlocConsumer<AuthBloc, AuthState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is GenerateOtpSuccessState) {
              ScaffoldHelper.showSuccessSnackBar(
                  context: context, message: state.response.message);
              CustomNavigator.pushReplace(
                context,
                AppRouter.otpScreen,
                arguments: OtpScreenEntity(
                  mobileNumber: _phoneTC.text,
                  otpMode: OTPMode.register,
                  otp: state.response.data!.otp,
                  referralCode: _refCodeTC.text,
                ),
              );
            }
            if (state is AuthFailureState) {
              ScaffoldHelper.showFailureSnackBar(
                  context: context, message: state.errorMessage);
            }
          },
          builder: (context, state) {
            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 34.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "SELECT LANGUAGE",
                                    textAlign: TextAlign.center,
                                    style: AppTextThemes.theme(context)
                                        .titleLarge!
                                        .copyWith(
                                      color: ColorPalette.primaryColor,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(
                                            1.sp,
                                            1.sp,
                                          ), // position of the shadow
                                          blurRadius: 1.0, // blur effect
                                          color: Colors.black.withOpacity(
                                            0.15,
                                          ), // shadow color with 15% opacity
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
                              "Start for free",
                              style: AppTextThemes.theme(context)
                                  .titleLarge!
                                  .copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                            CustomSpacers.height30,
                            Text(
                              getFinalLabel(
                                "Note: This mobile number cannot be changed once verified by OTP",
                              ),
                              style: AppTextThemes.theme(context)
                                  .bodyMedium!
                                  .copyWith(
                                    color: ColorPalette.textDark,
                                  ),
                            ),
                            CustomSpacers.height20,
                            CustomTextField(
                              hintText: 'Mobile (+91)',
                              maxLength: 10,
                              controller: _phoneTC,
                              keyboardType: TextInputType.phone,
                              validator: _validatePhone,
                            ),
                            CustomSpacers.height20,
                            CustomTextField(
                              hintText: 'Referral code / Referrer mobile',
                              controller: _refCodeTC,
                              keyboardType: TextInputType.text,
                              validator: _validateReferralCode,
                            ),
                            CustomSpacers.height30,
                            CustomButton(
                              isLoading: state is AuthLoadingState,
                              onPressed: _onSubmit,
                              btnText: getFinalLabel("Get OTP"),
                              height: 50,
                              width: double.infinity,
                            ),
                            CustomSpacers.height30,
                            Container(
                              height: 1,
                              width: MediaQuery.of(context).size.width * 0.7,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 4,
                                    offset: const Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.45),
                                    offset: const Offset(0, -4),
                                    blurRadius: 4,
                                  )
                                ],
                              ),
                            ),
                            CustomSpacers.height30,
                            GestureDetector(
                              onTap: () => CustomNavigator.pushTo(
                                context,
                                AppRouter.loginScreen,
                              ),
                              child: Text(
                                getFinalLabel("SIGN IN"),
                                textAlign: TextAlign.center,
                                style: AppTextThemes.theme(context)
                                    .titleLarge!
                                    .copyWith(
                                  color: ColorPalette.primaryColor,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(
                                        1.sp,
                                        1.sp,
                                      ), // position of the shadow
                                      blurRadius: 1.0, // blur effect
                                      color: Colors.black.withOpacity(
                                        0.15,
                                      ), // shadow color with 15% opacity
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
            );
          },
        ),
      ),
    );
  }
}
