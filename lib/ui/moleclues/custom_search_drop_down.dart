import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/constants/figma_constants.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchableDropdown extends FormField<String> {
  final double? height, width, borderRadius;
  final List<String> options;
  final bool? disabled;
  final VoidCallback? onTap;
  final Function(int?)? onSelect;
  final Function(String?)? onTextChange;
  final String? groupValue;
  final TextEditingController controller;
  final String? hintText;

  SearchableDropdown({
    super.key,
    required this.options,
    required this.controller,
    this.groupValue,
    this.height = FigmaValueConstants.dropDownHeight,
    this.width,
    this.onSelect,
    this.onTextChange,
    this.disabled = false,
    this.onTap,
    this.borderRadius = FigmaValueConstants.btnBorderRadius,
    this.hintText = 'Select an option',
    super.validator,
  }) : super(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: groupValue,
          builder: (FormFieldState<String> state) {
            return _SearchableDropdownState(
              formFieldState: state,
              options: options,
              controller: controller,
              groupValue: groupValue,
              height: height,
              width: width,
              onSelect: onSelect,
              onTextChange: onTextChange,
              disabled: disabled,
              onTap: onTap,
              borderRadius: borderRadius,
              hintText: hintText,
            );
          },
        );
}

class _SearchableDropdownState extends StatefulWidget {
  final FormFieldState<String> formFieldState;
  final double? height, width, borderRadius;
  final List<String> options;
  final bool? disabled;
  final VoidCallback? onTap;
  final Function(int?)? onSelect;
  final Function(String?)? onTextChange;
  final String? groupValue;
  final TextEditingController controller;
  final String? hintText;

  const _SearchableDropdownState({
    required this.formFieldState,
    required this.options,
    required this.controller,
    this.groupValue,
    this.height,
    this.width,
    this.onSelect,
    this.onTextChange,
    this.disabled,
    this.onTap,
    this.borderRadius,
    this.hintText,
  });

  @override
  State<_SearchableDropdownState> createState() =>
      _SearchableDropdownStateState();
}

class _SearchableDropdownStateState extends State<_SearchableDropdownState>
    with SingleTickerProviderStateMixin {
  String dropdownValue = '';
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late FocusNode _focusNode;
  late ScrollController _scrollController;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _heightAnimation = Tween<double>(begin: 52.h, end: 350.h).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _focusNode = FocusNode();
    _scrollController = ScrollController();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _controller.forward();

        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
          );
        });
      } else {
        _controller.reverse();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        dropdownValue = widget.groupValue ?? '';
      });
    });

    super.initState();
  }

  @override
  void didUpdateWidget(covariant _SearchableDropdownState oldWidget) {
    debugPrint(widget.options.toString());
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
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
      ),
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
                                  dropdownValue = widget.options[index];
                                  _controller.reverse();
                                  widget.controller.text =
                                      widget.options[index];
                                  widget.onSelect?.call(index);
                                  widget.formFieldState
                                      .didChange(widget.options[index]);

                                  // Hide the keyboard when an option is selected
                                  FocusScope.of(context).unfocus();
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 0),
                                child: Text(
                                  widget.options[index],
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
                    height: 52.h,
                    color: ColorPalette.scaffoldBackgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: widget.controller,
                            onChanged: widget.onTextChange,
                            enabled: !widget.disabled!,
                            focusNode: _focusNode,
                            scrollPadding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        100.h * 3.25),
                            style: AppTextThemes.theme(context)
                                .titleLarge
                                ?.copyWith(
                                  color: ColorPalette.textDark,
                                ),
                            decoration: InputDecoration(
                              hintText: widget.hintText, // Hint text added

                              hintStyle: AppTextThemes.theme(context)
                                  .titleLarge
                                  ?.copyWith(
                                    color: Colors.grey, // Hint text color
                                  ),
                              border: InputBorder.none,
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
