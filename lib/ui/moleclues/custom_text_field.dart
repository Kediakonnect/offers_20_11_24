import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? maxLength;
  final bool? readOnly;
  final VoidCallback? onTap;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    this.maxLength,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.onSubmitted,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: (value) {
        final error = widget.validator?.call(value);

        // If there's an error, request focus after the widget has built
        if (error != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _focusNode.requestFocus();
          });
        }
        return error;
      },
      builder: (FormFieldState<String> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.labelText != null)
              Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  widget.labelText!,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorPalette.textDark,
                  ),
                ),
              ),
            Neumorphic(
              style: NeumorphicStyle(
                depth: -3,
                intensity: 1,
                surfaceIntensity: 0.4,
                lightSource: LightSource.topLeft,
                shadowDarkColor: Colors.black,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(10.sp)),
                color: ColorPalette.scaffoldBackgroundColor,
                shadowLightColorEmboss: Colors.white,
              ),
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  alignment: Alignment.center,
                  child: TextFormField(
                    focusNode: _focusNode,
                    readOnly: widget.readOnly ?? false,
                    maxLength: widget.maxLength,
                    maxLines: widget.maxLines,
                    controller: widget.controller,
                    obscureText: widget.obscureText,
                    keyboardType: widget.keyboardType,
                    textInputAction: widget.textInputAction,
                    onFieldSubmitted: widget.onSubmitted,
                    onChanged: (e) {
                      state.didChange(e);
                      widget.onChanged?.call(e);
                    },
                    style: AppTextThemes.theme(context).titleLarge,
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                        color: ColorPalette.textPlaceholder,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      prefixIcon: widget.prefixIcon,
                      suffixIcon: widget.suffixIcon,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            if (state.hasError)
              Text(
                state.errorText ?? '',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                ),
              ),
          ],
        );
      },
    );
  }
}
