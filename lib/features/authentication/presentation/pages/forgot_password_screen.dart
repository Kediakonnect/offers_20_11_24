import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/get-final-string.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/forgot_password_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/password_reset_option_entity.dart';
import 'package:divyam_flutter/features/authentication/presentation/blocs/auth_bloc/auth_cubit.dart';
import 'package:divyam_flutter/injection_container/injection_container.dart';
import 'package:divyam_flutter/router/app_routes.dart';
import 'package:divyam_flutter/router/custom_navigator.dart';
import 'package:divyam_flutter/ui/moleclues/custom_button.dart';
import 'package:divyam_flutter/ui/moleclues/custom_scaffold.dart';
import 'package:divyam_flutter/ui/moleclues/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late AuthBloc _authBloc;
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _authBloc = sl<AuthBloc>();
    super.initState();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _authBloc.forgotPassword(
        entity: ForgotPasswordEntity(
          mobileNumber: _textController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Forgot Password",
      height: MediaQuery.of(context).size.height,
      enableMenu: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is ForgotPasswordSuccessState) {
            ScaffoldHelper.showSuccessSnackBar(
              context: context,
              message: state.response.message,
            );

            CustomNavigator.pushTo(
              context,
              AppRouter.forgotPasswordOptionScreen,
              arguments: PasswordResetOptionEntity(
                mobile: state.response.data?.mobile ?? _textController.text,
                secondaryMobile: state.response.data?.secondaryMobile,
                email: state.response.data?.email,
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
                padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 20.h),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
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
                            "Forgot Password?",
                            style: AppTextThemes.theme(context)
                                .titleLarge!
                                .copyWith(
                                  color: Colors.black,
                                ),
                          ),
                          CustomSpacers.height15,
                          Text(
                            getFinalLabel(
                              "Note: Enter your mobile number and we will send you an OTP to reset your password",
                            ),
                            style: AppTextThemes.theme(context)
                                .bodyMedium!
                                .copyWith(
                                  color: ColorPalette.textDark,
                                ),
                          ),
                          CustomSpacers.height20,
                          CustomTextField(
                            controller: _textController,
                            keyboardType: TextInputType.phone,
                            hintText: "Mobile Number",
                            maxLength: 10,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile number';
                              } else if (!RegExp(r'^[0-9]{10}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid mobile number';
                              }
                              return null;
                            },
                          ),
                          CustomSpacers.height30,
                          CustomButton(
                            isLoading: state is AuthLoadingState,
                            btnText: "Send OTP",
                            height: 50,
                            width: double.infinity,
                            onPressed: _onSubmit,
                          ),
                          CustomSpacers.height30,
                          GestureDetector(
                            onTap: () {
                              CustomNavigator.pushTo(
                                context,
                                AppRouter.loginScreen,
                              );
                            },
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
                                      1,
                                      1,
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
    );
  }
}
