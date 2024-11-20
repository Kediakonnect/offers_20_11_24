import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class CustomCheckBoxTile extends StatefulWidget {
  final String? option;
  final Function(bool?) onChanged;
  final bool? value; // Optional value for real-time updates

  const CustomCheckBoxTile({
    super.key,
    required this.onChanged,
    this.option,
    this.value, // Make value optional
  });

  @override
  State<CustomCheckBoxTile> createState() => _CustomCheckBoxTileState();
}

class _CustomCheckBoxTileState extends State<CustomCheckBoxTile> {
  late bool isSelected;

  @override
  void initState() {
    super.initState();
    isSelected = widget.value ?? false; // Use passed value or default to false
  }

  @override
  void didUpdateWidget(covariant CustomCheckBoxTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null && widget.value != oldWidget.value) {
      setState(() {
        isSelected = widget.value!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.onChanged(isSelected);
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          NeuroMorphicContainer(
            height: 20,
            width: 20,
            borderRadius: 5,
            padding: const EdgeInsets.all(2),
            color: isSelected
                ? ColorPalette.primaryColor
                : ColorPalette.scaffoldBackgroundColor,
            child: Visibility(
              visible: isSelected,
              child: const FittedBox(
                fit: BoxFit.contain,
                child: Icon(
                  Icons.check,
                  color: ColorPalette.scaffoldBackgroundColor,
                ),
              ),
            ),
          ),
          CustomSpacers.width10,
          Visibility(
            visible: widget.option != null,
            child: Expanded(
              child: Text(
                widget.option ?? '',
                style: AppTextThemes.theme(context).titleLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
