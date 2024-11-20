import 'package:divyam_flutter/ui/moleclues/custom_radio_button.dart';
import 'package:flutter/material.dart';

import '../../core/utils/custom_spacers.dart';

class CustomRadioList extends StatefulWidget {
  final Set<String> options;
  final Function(String) onChanged;
  const CustomRadioList(
      {super.key, required this.options, required this.onChanged});

  @override
  State<CustomRadioList> createState() => _CustomRadioListState();
}

class _CustomRadioListState extends State<CustomRadioList> {
  String selectedValue = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var option in widget.options) ...[
          CustomRadioListTile(
            key: GlobalKey(),
            isActive: selectedValue == option,
            onChanged: (v) {
              setState(() {
                selectedValue = v;
                widget.onChanged(v);
              });
            },
            text: option,
          ),
          CustomSpacers.height20
        ],
      ],
    );
  }
}
