import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/new_password_screen_entity.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/password_reset_entity.dart';
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

class NewPasswordScreen extends StatefulWidget {
  final NewPasswordScreenEntity newPasswordScreenEntity;
  const NewPasswordScreen({super.key, required this.newPasswordScreenEntity});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AuthBloc _authBloc;

  @override
  void initState() {
    _authBloc = sl<AuthBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarTitle: "Reset password",
      height: MediaQuery.of(context).size.height,
      enableMenu: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: _authBloc,
        listener: (context, state) {
          if (state is AuthSuccessState) {
            ScaffoldHelper.showSuccessSnackBar(
              context: context,
              message: "Password Reset Successfully",
            );

            CustomNavigator.pushTo(
              context,
              AppRouter.loginScreen,
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
                            "New Password",
                            style: AppTextThemes.theme(context)
                                .titleLarge!
                                .copyWith(
                                  color: Colors.black,
                                ),
                          ),
                          CustomSpacers.height20,
                          CustomTextField(
                            controller: _newPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: "New password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your new password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          CustomSpacers.height20,
                          CustomTextField(
                            controller: _confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            hintText: "Confirm password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != _newPasswordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          CustomSpacers.height20,
                          CustomButton(
                            btnText: "Submit",
                            height: 50,
                            width: double.infinity,
                            isLoading: state is AuthLoadingState,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _authBloc.resetPassword(
                                  entity: PasswordResetEntity(
                                      confirmPassword:
                                          _confirmPasswordController.text,
                                      password: _newPasswordController.text,
                                      mobile: widget.newPasswordScreenEntity
                                          .mobileNumber),
                                );
                              }
                            },
                          ),
                          CustomSpacers.height30,
                          GestureDetector(
                            onTap: () {
                              CustomNavigator.pushReplace(
                                  context, AppRouter.loginScreen);
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
