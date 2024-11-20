import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/ui/moleclues/custom_check_box_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomMultiSelectDropDown extends FormField<List<String>> {
  final double? height, width, borderRadius;
  final List<String> options;
  final bool? disabled;
  final VoidCallback? onTap;
  final Function(List<int>)? onChanged;
  final List<String>? groupValue;
  final TextEditingController controller;
  final String? hintText;

  CustomMultiSelectDropDown({
    super.key,
    required this.options,
    required this.controller,
    this.groupValue,
    this.height = FigmaValueConstants.dropDownHeight,
    this.width,
    this.onChanged,
    this.disabled = false,
    this.onTap,
    this.borderRadius = FigmaValueConstants.btnBorderRadius,
    this.hintText = 'Select options',
    super.validator,
  }) : super(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: groupValue,
          builder: (FormFieldState<List<String>> state) {
            return _CustomMultiSelectDropDownState(
              formFieldState: state,
              options: options,
              controller: controller,
              groupValue: groupValue ?? [],
              height: height,
              width: width,
              onChanged: onChanged,
              disabled: disabled,
              onTap: onTap,
              borderRadius: borderRadius,
              hintText: hintText,
            );
          },
        );
}

class _CustomMultiSelectDropDownState extends StatefulWidget {
  final FormFieldState<List<String>> formFieldState;
  final double? height, width, borderRadius;
  final List<String> options;
  final bool? disabled;
  final VoidCallback? onTap;
  final Function(List<int>)? onChanged;
  final List<String> groupValue;
  final TextEditingController controller;
  final String? hintText;

  const _CustomMultiSelectDropDownState({
    required this.formFieldState,
    required this.options,
    required this.controller,
    required this.groupValue,
    this.height,
    this.width,
    this.onChanged,
    this.disabled,
    this.onTap,
    this.borderRadius,
    this.hintText,
  });

  @override
  State<_CustomMultiSelectDropDownState> createState() =>
      _CustomMultiSelectDropDownStateState();
}

class _CustomMultiSelectDropDownStateState
    extends State<_CustomMultiSelectDropDownState>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late List<String> selectedValues;

  @override
  void didUpdateWidget(covariant _CustomMultiSelectDropDownState oldWidget) {
    if (widget.groupValue != oldWidget.groupValue) {
      setState(() {
        selectedValues = List.from(widget.groupValue);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _heightAnimation = Tween<double>(begin: 52.h, end: 400.h).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    selectedValues = List.from(widget.groupValue);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.text = selectedValues.join(', ');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.disabled! ? _buildDisabledDropDown() : _buildDropDown(),
        if (widget.formFieldState.hasError)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              widget.formFieldState.errorText!,
              style: AppTextThemes.theme(context).bodySmall?.copyWith(
                    color: Colors.red,
                  ),
            ),
          ),
      ],
    );
  }

  Widget _buildDisabledDropDown() {
    return InkWell(
      onTap: widget.onTap,
      child: IgnorePointer(
        child: _buildDropDown(),
      ),
    );
  }

  Widget _buildDropDown() {
    return AnimatedBuilder(
      animation: _heightAnimation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          decoration: BoxDecoration(
            color: ColorPalette.scaffoldBackgroundColor,
            boxShadow: FigmaValueConstants.boxShadow,
            borderRadius: BorderRadius.circular(10),
          ),
          width: double.infinity,
          height: _heightAnimation.value, // Apply the animated height
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_controller.status == AnimationStatus.completed) ...[
                      CustomSpacers.height48,
                      Container(
                        decoration: BoxDecoration(
                          color: ColorPalette.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.options.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  final value = widget.options[index];
                                  if (selectedValues.contains(value)) {
                                    selectedValues.remove(value);
                                  } else {
                                    selectedValues.add(value);
                                  }
                                  widget.controller.text =
                                      selectedValues.join(', ');
                                  widget.onChanged?.call(
                                    selectedValues
                                        .map((e) => widget.options.indexOf(e))
                                        .toList(),
                                  );
                                  widget.formFieldState
                                      .didChange(selectedValues);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 0),
                                child: Row(
                                  children: [
                                    CustomCheckBoxTile(
                                      value: selectedValues
                                          .contains(widget.options[index]),
                                      onChanged: (isChecked) {
                                        setState(() {
                                          if (isChecked == true) {
                                            selectedValues
                                                .add(widget.options[index]);
                                          } else {
                                            selectedValues
                                                .remove(widget.options[index]);
                                          }
                                          widget.controller.text =
                                              selectedValues.join(', ');
                                          widget.onChanged?.call(
                                            selectedValues
                                                .map((e) =>
                                                    widget.options.indexOf(e))
                                                .toList(),
                                          );
                                          widget.formFieldState
                                              .didChange(selectedValues);
                                        });
                                      },
                                    ),
                                    Text(
                                      widget.options[index],
                                      style: AppTextThemes.theme(context)
                                          .titleLarge,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (_controller.status == AnimationStatus.completed) {
                    _controller.reverse(); // Collapse the container
                  } else {
                    _controller.forward(); // Expand the container
                  }
                },
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                    ),
                    color: ColorPalette.scaffoldBackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            selectedValues.isEmpty
                                ? widget.hintText!
                                : selectedValues.join(', '),
                            overflow: TextOverflow
                                .ellipsis, // Apply ellipsis for overflow
                            maxLines: 1,
                            style: AppTextThemes.theme(context)
                                .titleLarge
                                ?.copyWith(
                                  color: selectedValues.isEmpty
                                      ? Colors.grey
                                      : ColorPalette.textDark,
                                  overflow: TextOverflow.ellipsis,
                                ),
                          ),
                        ),
                        Icon(
                          _controller.status == AnimationStatus.completed
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: ColorPalette.textDark,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
