import 'package:flutter/material.dart';

class ZoomableWidget extends StatefulWidget {
  final Widget child;

  const ZoomableWidget({super.key, required this.child});

  @override
  _ZoomableWidgetState createState() => _ZoomableWidgetState();
}

class _ZoomableWidgetState extends State<ZoomableWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InteractiveViewer(
        // panEnabled: false, // Set it to false
        boundaryMargin: EdgeInsets.all(100),
        minScale: 1,
        maxScale: 5,
        child: widget.child,
      ),
    );
  }
}

// Usage example with explicit constraints on the child widget.

