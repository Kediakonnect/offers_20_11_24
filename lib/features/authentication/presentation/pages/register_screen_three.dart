import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/get-final-string.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_screen_three_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/register_user_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/secondary_otp_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/secondary_otp_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/sign_in_entity.dart';
import 'package:divyam_flutter/features/authentication/presentation/blocs/auth_bloc/auth_cubit.dart';
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

class RegisterScreenThree extends StatefulWidget {
  final RegisterScreenThreeEntity registerScreenThreeEntity;

  const RegisterScreenThree({
    super.key,
    required this.registerScreenThreeEntity,
  });

  @override
  State<RegisterScreenThree> createState() => _RegisterScreenThreeState();
}

class _RegisterScreenThreeState extends State<RegisterScreenThree> {
  final _formKey = GlobalKey<FormState>();
  late AuthBloc _authBloc;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _secondaryMobileController =
      TextEditingController();
  final TextEditingController _secondaryEmailController =
      TextEditingController();

  bool _otpSent = false; // Prevent multiple OTP triggers

  @override
  void initState() {
    _authBloc = sl<AuthBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _secondaryMobileController.dispose();
    _secondaryEmailController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value != null &&
        value.isNotEmpty &&
        !RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value != null &&
        value.isNotEmpty &&
        !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_otpSent &&
          (_secondaryMobileController.text.isNotEmpty ||
              _secondaryEmailController.text.isNotEmpty)) {
        _authBloc.sendSecondaryOtp(
          entity: SecondaryOtpEntity(
            secondaryEmail: _secondaryEmailController.text,
            secondaryNumber: _secondaryMobileController.text,
          ),
        );
        _otpSent = true; // OTP is sent, prevent multiple triggers
      }

      _authBloc.register(
        entity: RegisterUserEntity(
          dateOfBirth: widget.registerScreenThreeEntity.dob,
          firstName: widget.registerScreenThreeEntity.firstName,
          lastName: widget.registerScreenThreeEntity.lastName,
          isMetro: widget.registerScreenThreeEntity.isMetroCity,
          passwordConfirmation: _confirmPasswordController.text,
          sex: widget.registerScreenThreeEntity.sex,
          state: widget.registerScreenThreeEntity.state,
          district: widget.registerScreenThreeEntity.district,
          email: _secondaryEmailController.text,
          referralCode: widget.registerScreenThreeEntity.referralCode,
          secondaryMobile: _secondaryMobileController.text,
          taluka: widget.registerScreenThreeEntity.area,
          mobile: widget.registerScreenThreeEntity.phoneNumber,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        appBarTitle: "REGISTER 3/3",
        height: MediaQuery.of(context).size.height,
        enableMenu: false,
        body: BlocConsumer<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is GenerateSecondaryOtpSuccessState) {
              CustomNavigator.pushTo(
                context,
                AppRouter.secondaryOtpScreen,
                arguments: SecondaryOtpEntityScreen(
                  mobileOtp: state.response.data?.mobileOtp,
                  emailOtp: state.response.data?.emailOtp,
                ),
              );
            } else if (state is RegisterUserSuccessState) {
              _authBloc.login(
                entity: SignInEntity(
                  mobile: widget.registerScreenThreeEntity.phoneNumber,
                  password: _passwordController.text,
                ),
              );
            } else if (state is LoginSuccessState) {
              CustomNavigator.pushTo(
                context,
                AppRouter.businessDirectoryScreen,
              );
            } else if (state is AuthFailureState) {
              _otpSent = false;
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
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              getFinalLabel(
                                "Secondary mobile and Email are useful for password recovery in case you lose access to primary mobile number",
                              ),
                              style: AppTextThemes.theme(context)
                                  .displaySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            CustomSpacers.height20,
                            CustomTextField(
                              hintText: 'Password',
                              controller: _passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              validator: _validatePassword,
                            ),
                            CustomSpacers.height20,
                            CustomTextField(
                              hintText: 'Confirm Password',
                              controller: _confirmPasswordController,
                              keyboardType: TextInputType.text,
                              obscureText: true,
                              validator: _validateConfirmPassword,
                            ),
                            CustomSpacers.height20,
                            CustomTextField(
                              hintText: 'Secondary mobile (optional)',
                              controller: _secondaryMobileController,
                              keyboardType: TextInputType.number,
                              maxLength: 10,
                              validator: _validateMobile,
                            ),
                            CustomSpacers.height20,
                            CustomTextField(
                              hintText: 'Email (optional)',
                              controller: _secondaryEmailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: _validateEmail,
                            ),
                            CustomSpacers.height30,
                            CustomButton(
                              isLoading: state is AuthLoadingState,
                              onPressed: _onSubmit,
                              btnText: getFinalLabel("Register"),
                              height: 50,
                              width: double.infinity,
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
