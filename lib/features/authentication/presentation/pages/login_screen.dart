import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/image_constants.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/features/authentication/domain/entity/sign_in_entity.dart';
import 'package:divyam_flutter/features/authentication/presentation/blocs/auth_bloc/auth_cubit.dart';
import 'package:divyam_flutter/features/dashboard/offers/presentation/utils/offer_type_enum.dart';
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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isExpanded = false;
  late AuthBloc _authBloc;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _authBloc = sl<AuthBloc>();
    super.initState();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      _authBloc.login(
        entity: SignInEntity(
          mobile: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScaffold(
        appBarTitle: "SIGN IN",
        height: MediaQuery.of(context).size.height,
        enableMenu: false,
        body: BlocConsumer<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is LoginSuccessState) {
              ScaffoldHelper.showSuccessSnackBar(
                  context: context, message: state.response.message);

              CustomNavigator.pushReplace(
                context,
                AppRouter.addsScreen,
                arguments: OfferType.entry.value,
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
                            CustomSpacers.height34,
                            CustomTextField(
                              controller: _emailController,
                              maxLength: 10,
                              keyboardType: TextInputType.phone,
                              hintText: "Mobile Number",
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
                            CustomSpacers.height20,
                            CustomTextField(
                              controller: _passwordController,
                              obscureText: true,
                              hintText: "Password",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            CustomSpacers.height30,
                            CustomButton(
                              onPressed: _login,
                              isLoading: state is AuthLoadingState,
                              btnText: "Login",
                              height: 50,
                              width: double.infinity,
                            ),
                            CustomSpacers.height30,
                            GestureDetector(
                              onTap: () => CustomNavigator.pushTo(
                                context,
                                AppRouter.forgotPasswordScreen,
                              ),
                              child: Text(
                                "FORGOT PASSWORD?",
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
                            Text(
                              "Start for free",
                              style: AppTextThemes.theme(context).titleLarge,
                            ),
                            CustomSpacers.height10,
                            GestureDetector(
                              onTap: () => CustomNavigator.pushTo(
                                context,
                                AppRouter.registerScreenOne,
                              ),
                              child: Text(
                                "CREATE NEW ACCOUNT",
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
