import 'dart:async';

import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/extentions/date_time_extension.dart';
import 'package:divyam_flutter/core/helpers/scaffold_helpers.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/core/utils/custom_spacers.dart';
import 'package:divyam_flutter/core/utils/date_timer_picker_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class SelectTimeWidget extends StatefulWidget {
  final String? openingTime, closingTime;

  final Function(String?) onOpeningTimeChanged, onClosingTimeChanged;
  const SelectTimeWidget(
      {super.key,
      this.openingTime,
      this.closingTime,
      required this.onOpeningTimeChanged,
      required this.onClosingTimeChanged});

  @override
  State<SelectTimeWidget> createState() => _SelectTimeWidgetState();
}

class _SelectTimeWidgetState extends State<SelectTimeWidget> {
  String? _openingTime, _closingTime;
  TimeOfDay? _openingDate, _closingDate;

  @override
  void initState() {
    _closingTime = widget.closingTime;
    _openingTime = widget.openingTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTimeBox(_openingTime, true, "Opening Time"),
        _buildTimeBox(_closingTime, false, "Closing Time"),
      ],
    );
  }

  Widget _buildTimeBox(String? time, bool isOpeningTime, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(
            textAlign: TextAlign.center,
            time ?? getString(isOpenning: isOpeningTime),
            style: AppTextThemes.theme(context).titleMedium,
          ),
        ),
        CustomSpacers.height10,
        TextButton(
          onPressed: () => _pickTime(isOpeningTime),
          child: Text(
            title,
            style: AppTextThemes.theme(context).displayMedium?.copyWith(
                  color: ColorPalette.primaryColor,
                ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickTime(bool isOpeningTime) async {
    final time = await DateTimePickerUtil.pickTime(context: context);

    _openingDate = time;
    _closingDate = time;

    String? msg = _validateTime();
    if (msg != null && mounted) {
      return ScaffoldHelper.showFailureSnackBar(context: context, message: msg);
    }
    if (time != null) {
      final formattedTime = MaterialLocalizations.of(context).formatTimeOfDay(
        time,
        alwaysUse24HourFormat: true,
      );
      setState(() {
        if (isOpeningTime) {
          _openingTime = formattedTime;
        } else {
          _closingTime = formattedTime;
        }
      });

      widget.onOpeningTimeChanged(_openingTime);
      widget.onClosingTimeChanged(_closingTime);
    }
  }

  String getString({required bool isOpenning}) {
    if (isOpenning) {
      return "Opening Time (optional)";
    } else {
      return "Closing Time (optional)";
    }
  }

  String? _validateTime() {
    print('====================================> $_openingDate,$_closingDate');
    if (_openingDate != null && _closingDate != null) {
      if (_openingDate!.hour > _closingDate!.hour ||
          (_openingDate!.hour == _closingDate!.hour &&
              _openingDate!.minute > _closingDate!.minute)) {
        return 'Closing time should be after opening time';
      }
    }
    return null;
  }
}
