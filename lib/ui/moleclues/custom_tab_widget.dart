import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/ui/atoms/inner_shadow_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabWidget extends StatefulWidget {
  final Function(int) onValueChange;
  final Set<String> options;
  final String? groupValue;
  final bool? isDisabled;
  final double? borderRadius;
  final double optionWidth;
  final double? tabWidth;
  final int? initialIndex; // Optional index for selected tab

  const CustomTabWidget({
    super.key,
    required this.onValueChange,
    this.tabWidth,
    required this.options,
    required this.optionWidth,
    this.groupValue,
    this.borderRadius = 25,
    this.isDisabled = false,
    this.initialIndex, // Initialize it in the constructor
  });

  @override
  State<CustomTabWidget> createState() => _CustomToggleButton2State();
}

class _CustomToggleButton2State extends State<CustomTabWidget> {
  String groupValue = '';
  List<String> options = [];

  @override
  void initState() {
    super.initState();
    options = widget.options.toList();
    // Set the initial group value based on the index if provided, otherwise default to the first option
    groupValue = widget.groupValue ??
        (widget.initialIndex != null && widget.initialIndex! < options.length
            ? options[widget.initialIndex!]
            : options.first);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      width: widget.tabWidth?.w ?? MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: ColorPalette.scaffoldBackgroundColor,
        boxShadow: FigmaValueConstants.boxShadow,
        borderRadius: BorderRadius.circular(widget.borderRadius!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var option in widget.options) ...[
            _buildButton(
              groupValue == option,
              option,
              () {
                if (groupValue != option) {
                  setState(() {
                    groupValue = option;
                  });
                  widget.onValueChange(
                    widget.options.toList().indexOf(option),
                  );
                }
              },
            ),
          ]
        ],
      ),
    );
  }

  _buildButton(bool isActive, String strButtonText, VoidCallback buttonAction) {
    return GestureDetector(
      onTap: buttonAction,
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: isActive ? NeumorphicShape.concave : NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(widget.borderRadius!),
          ),
          depth: isActive ? -5 : 0, // Increase outer shadow and emboss effect
          intensity: isActive
              ? 0.9
              : 0.5, // Keep intensity slightly higher for pressed state
          lightSource: LightSource.topLeft,
          shadowLightColor: Colors.white
              .withOpacity(0.8), // Optional: fine-tune light shadow color
          shadowDarkColor:
              Colors.black, // Increase shadow darkness for more depth
        ),
        child: Container(
          alignment: Alignment.center,
          height: 48.h,
          width: widget.optionWidth.w,
          decoration: BoxDecoration(
            color: isActive ? ColorPalette.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(widget.borderRadius!),
          ),
          child: Text(
            strButtonText,
            textAlign: TextAlign.center,
            style: !isActive
                ? AppTextThemes.theme(context).headlineMedium
                : AppTextThemes.theme(context).headlineMedium?.copyWith(
                      color: ColorPalette.scaffoldBackgroundColor,
                    ),
          ),
        ),
      ),
    );
  }
}
