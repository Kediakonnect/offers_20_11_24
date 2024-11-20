import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomRadioListTile extends StatefulWidget {
  final bool? isActive;
  final Function(String) onChanged;
  final String text;

  const CustomRadioListTile(
      {super.key, required this.text, required this.onChanged, this.isActive});

  @override
  State<CustomRadioListTile> createState() => _CustomRadioListTileState();
}

class _CustomRadioListTileState extends State<CustomRadioListTile> {
  final Offset _offset = const Offset(2, 4);
  bool isActive = false;

  @override
  void initState() {
    isActive = widget.isActive ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // isActive = !isActive;
          widget.onChanged(widget.text);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: FigmaValueConstants.radioHeight.h,
            width: FigmaValueConstants.radioHeight.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: _offset,
                  color: ColorPalette.shadowOuterDark,
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
                BoxShadow(
                  offset: -(_offset),
                  color: ColorPalette.shadowOuterLight,
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: ColorPalette.scaffoldBackgroundColor,
              ),
            ),
            child: isActive
                ? Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorPalette.primaryColor,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(33, 120, 120, 120),
                          ColorPalette.shadowOuterLight.withOpacity(.3),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [.1, .55],
                      ),
                      shape: BoxShape.circle,
                      color: ColorPalette.primaryColor,
                    ),
                  ),
          ),
          CustomSpacers.width10,
          Text(
            widget.text,
            style: AppTextThemes.theme(context).titleLarge,
          )
        ],
      ),
    );
  }
}
