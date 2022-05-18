import 'package:flutter/material.dart';
import 'package:i_poster/core/helpers/helpers.dart' show SizesHelper;

class MaterialInkWell extends StatelessWidget {
  const MaterialInkWell({
    super.key,
    required this.onPressed,
    this.radius,
    this.customBorder,
    required this.child,
    this.personalizeBorderRadius,
    this.splashColor,
    this.onLongPressed,
    this.disableTouchEffect = false,
  });
  final void Function()? onPressed;
  final void Function()? onLongPressed;
  final double? radius;
  final BorderRadius? personalizeBorderRadius;
  final ShapeBorder? customBorder;
  final Widget child;
  final Color? splashColor;
  final bool disableTouchEffect;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: customBorder,
      borderRadius: customBorder == null
          ? personalizeBorderRadius ??
              BorderRadius.circular(
                SizesHelper.radius(radius ?? 0),
              )
          : null,
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        onLongPress: onLongPressed,
        splashColor: splashColor,
        borderRadius: customBorder == null
            ? personalizeBorderRadius ??
                BorderRadius.circular(
                  SizesHelper.radius(radius ?? 0),
                )
            : null,
        customBorder: customBorder,
        child: child,
      ),
    );
  }
}
