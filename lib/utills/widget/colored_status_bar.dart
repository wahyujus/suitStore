import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suitcore_flutter_getx_base_code/resources/resources.dart';

class ColoredStatusBar extends StatelessWidget {
  const ColoredStatusBar({
    Key? key,
    this.color,
    this.child,
    this.brightness = Brightness.dark,
  }) : super(key: key);

  final Color? color;
  final Widget? child;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    final defaultColor = Resources.color.colorPrimary;
    final androidIconBrightness =
        brightness == Brightness.dark ? Brightness.light : Brightness.dark;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: color ?? defaultColor,
        statusBarIconBrightness: androidIconBrightness,
        statusBarBrightness: brightness,
      ),
      child: Container(
        color: color ?? defaultColor,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
