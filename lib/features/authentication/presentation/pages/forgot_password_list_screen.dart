import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/get-final-string.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/forgot_password_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/otp_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/password_reset_option_entity.dart';
import 'package:divyam_flutter/features/authentication/presentation/blocs/auth_bloc/auth_cubit.dart';
import 'package:divyam_flutter/features/authentication/presentation/pages/otp_screen.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_radio_list.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordListScreen extends StatefulWidget {
  final PasswordResetOptionEntity passwordResetOptionEntity;

  const ForgotPasswordListScreen({
    super.key,
    required this.passwordResetOptionEntity,
  });

  @override
  State<ForgotPasswordListScreen> createState() =>
      _ForgotPasswordListScreenState();
}

class _ForgotPasswordListScreenState extends State<ForgotPasswordListScreen> {
  String? selectedOption;
  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = sl<AuthBloc>();
    super.initState();
  }

  String extractContactInfo(String input) {
    // Define regex patterns for phone numbers and email addresses
    final phoneRegex = RegExp(r'\b\d{10}\b');
    final emailRegex =
        RegExp(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}');

    // Search for phone number
    final phoneMatch = phoneRegex.firstMatch(input);
    if (phoneMatch != null) {
      return phoneMatch.group(0)!;
    }

    // Search for email address
    final emailMatch = emailRegex.firstMatch(input);
    if (emailMatch != null) {
      return emailMatch.group(0)!;
    }

    // Return empty string if neither is found
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // Building the list of options based on the available data
    final options = [
      getFinalLabel(
          "Send OTP on mobile ${widget.passwordResetOptionEntity.mobile}"),
      if (widget.passwordResetOptionEntity.secondaryMobile != null)
        getFinalLabel(
            "Send OTP on mobile ${widget.passwordResetOptionEntity.secondaryMobile}"),
      if (widget.passwordResetOptionEntity.email != null)
        getFinalLabel(
            "Send OTP to email ID ${widget.passwordResetOptionEntity.email}"),
    ];

    void onSubmit() {
      if (selectedOption == null) {
        ScaffoldHelper.showFailureSnackBar(
            context: context, message: "Please select an option");
        return;
      }

      _authBloc.forgotPasswordSendOtp(
        entity: ForgotPasswordOtpEntity(
            mobileNumber: extractContactInfo(selectedOption ?? "")),
      );
    }

    return SafeArea(
      child: CustomScaffold(
        appBarTitle: "FORGOT PASSWORD",
        height: MediaQuery.of(context).size.height,
        enableMenu: false,
        body: BlocConsumer<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is GenerateOtpSuccessState) {
              ScaffoldHelper.showSuccessSnackBar(
                context: context,
                message: state.response.message,
              );

              CustomNavigator.pushReplace(
                context,
                AppRouter.otpScreen,
                arguments: OtpScreenEntity(
                  otpMode: OTPMode.forgotPassword,
                  mobileNumber: extractContactInfo(selectedOption ?? ""),
                  otp: state.response.data!.otp,
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomRadioList(
                            options:
                                options.toSet(), // Adding options to the list
                            onChanged: (value) {
                              setState(() {
                                selectedOption = value;
                              });
                            },
                          ),
                          CustomSpacers.height30,
                          CustomButton(
                            isLoading: state is AuthLoadingState,
                            onPressed: onSubmit,
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
                                ),
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
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ColorPalette.primaryColor,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(1, 1),
                                    blurRadius: 1.0,
                                    color: Colors.black.withOpacity(0.15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
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
