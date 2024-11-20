import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VisibilityWrapper extends StatefulWidget {
  final String id;
  final Widget child;
  final Function onVisible;

  const VisibilityWrapper({
    super.key,
    required this.id,
    required this.child,
    required this.onVisible,
  });

  @override
  _VisibilityWrapperState createState() => _VisibilityWrapperState();
}

class _VisibilityWrapperState extends State<VisibilityWrapper> {
  bool _hasBeenVisible = false;

  @override
  Widget build(BuildContext context) {
    // Check visibility during first build cycle in case the widget is already on the screen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_hasBeenVisible) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        if (renderBox.hasSize) {
          final position = renderBox.localToGlobal(Offset.zero);
          final screenSize = MediaQuery.of(context).size;

          if (position.dy < screenSize.height &&
              position.dy + renderBox.size.height > 0) {
            _triggerOnVisible();
          }
        }
      }
    });

    return VisibilityDetector(
      key: Key(widget.id),
      onVisibilityChanged: (visibilityInfo) {
        if (!_hasBeenVisible && visibilityInfo.visibleFraction > 0) {
          _triggerOnVisible();
        }
      },
      child: widget.child,
    );
  }

  void _triggerOnVisible() {
    if (!_hasBeenVisible) {
      setState(() {
        _hasBeenVisible = true;
      });
      widget.onVisible();
    }
  }
}
