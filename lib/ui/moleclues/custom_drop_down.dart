import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends FormField<String> {
  final double? height, width, borderRadius;
  final List<String> options;
  final bool? disabled;
  final VoidCallback? onTap;
  final Function(int?)? onChanged;
  final String? groupValue;
  final TextEditingController controller;
  final String? hintText;

  CustomDropDown({
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
    this.hintText = 'Select an option',
    super.validator,
  }) : super(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: groupValue,
          builder: (FormFieldState<String> state) {
            return _CustomDropDownState(
              formFieldState: state,
              options: options,
              controller: controller,
              groupValue: groupValue,
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

class _CustomDropDownState extends StatefulWidget {
  final FormFieldState<String> formFieldState;
  final double? height, width, borderRadius;
  final List<String> options;
  final bool? disabled;
  final VoidCallback? onTap;
  final Function(int?)? onChanged;
  final String? groupValue;
  final TextEditingController controller;
  final String? hintText;

  const _CustomDropDownState({
    required this.formFieldState,
    required this.options,
    required this.controller,
    this.groupValue,
    this.height,
    this.width,
    this.onChanged,
    this.disabled,
    this.onTap,
    this.borderRadius,
    this.hintText,
  });

  @override
  State<_CustomDropDownState> createState() => _CustomDropDownStateState();
}

class _CustomDropDownStateState extends State<_CustomDropDownState>
    with SingleTickerProviderStateMixin {
  String dropdownValue = '';
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void didUpdateWidget(covariant _CustomDropDownState oldWidget) {
    if (widget.groupValue != oldWidget.groupValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          dropdownValue = widget.groupValue ?? '';
        });
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        dropdownValue = widget.groupValue ?? '';
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              widget.formFieldState.errorText ?? '',
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
      child: IgnorePointer(child: _buildDropDown()),
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
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          ),
          width: double.infinity,
          height: _heightAnimation.value,
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
                                  dropdownValue = widget.options[index];
                                  _controller.reverse();
                                  widget.controller.text =
                                      widget.options[index];
                                  widget.onChanged?.call(index);
                                  widget.formFieldState
                                      .didChange(widget.options[index]);
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 0),
                                child: Text(
                                  widget.options[index],
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      AppTextThemes.theme(context).titleLarge,
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
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                },
                child: Align(
                  alignment: _heightAnimation.value < 80.h
                      ? Alignment.centerRight
                      : Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    color: ColorPalette.scaffoldBackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            dropdownValue.isEmpty
                                ? widget.hintText!
                                : dropdownValue,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextThemes.theme(context)
                                .titleLarge
                                ?.copyWith(
                                  color: dropdownValue.isEmpty
                                      ? Colors.grey
                                      : ColorPalette.textDark,
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
