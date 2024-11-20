import 'dart:async';

import 'package:divyam_flutter/core/constants/color_palette.dart';
import 'package:divyam_flutter/core/themes/text_themes/text_themes.dart';
import 'package:divyam_flutter/ui/moleclues/nueromorphic_container.dart';
import 'package:flutter/material.dart';

class CloseIcon extends StatefulWidget {
  final VoidCallback onClose;
  const CloseIcon({super.key, required this.onClose});

  @override
  State<CloseIcon> createState() => _CloseIconState();
}

class _CloseIconState extends State<CloseIcon> {
  int _countdown = 5;
  bool _showCloseIcon = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 1) {
        setState(() {
          _countdown--;
        });
      } else {
        setState(() {
          _showCloseIcon = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _showCloseIcon
        ? GestureDetector(
            onTap: widget.onClose,
            child: const NeuroMorphicContainer(
              padding: EdgeInsets.all(2),
              height: 30,
              width: 30,
              shape: BoxShape.circle,
              child: Icon(
                Icons.close_rounded,
                color: ColorPalette.textDark,
              ),
            ),
          )
        : Text(
            '$_countdown',
            style: AppTextThemes.theme(context).bodyLarge,
          );
  }
}
