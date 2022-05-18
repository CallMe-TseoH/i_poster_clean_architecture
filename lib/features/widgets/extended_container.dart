import 'package:flutter/material.dart';
import 'package:i_poster/core/helpers/helpers.dart' show SizesHelper;

class ExtendedContainer extends StatelessWidget {
  const ExtendedContainer({
    super.key,
    this.shape,
    this.color,
    this.height,
    this.width,
    this.size,
    this.boxShadow,
    this.elevation,
    this.elevationColor,
    this.gradient,
    this.image,
    this.padding,
    this.margin,
    this.useAutoBorderRadius,
    this.borderRadius,
    this.child,
    this.border,
    this.alignment,
    this.minHeight,
    this.useAnimated = false,
    this.animatedTimeInMilliseconds = 1000,
    this.constraints,
    this.curve,
  });
  final Widget? child;
  final BoxShape? shape;
  final Color? color;
  final bool useAnimated;
  final int animatedTimeInMilliseconds;

  final double? height;
  final double? width;
  final double? size;
  final double? elevation;
  final Color? elevationColor;
  final double? minHeight;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final DecorationImage? image;
  final AlignmentGeometry? alignment;
  final BoxConstraints? constraints;
  final bool? useAutoBorderRadius;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Border? border;
  final Curve? curve;

  @override
  Widget build(BuildContext context) {
    var __defaultRadius = 0.0;
    if (height != null) {
      __defaultRadius = SizesHelper.radiusCalculate(height!);
    }
    return useAnimated
        ? _useElevation
            ? _buildCard(
                child: _buildAnimatedContainer(__defaultRadius),
                defaultRadius: __defaultRadius,
              )
            : _buildAnimatedContainer(__defaultRadius)
        : _useElevation
            ? _buildCard(
                child: _buildContainer(__defaultRadius),
                defaultRadius: __defaultRadius,
              )
            : _buildContainer(__defaultRadius);
  }

  bool get _useElevation => elevation != null && boxShadow == null;

  Container _buildContainer(double __defaultRadius) {
    return Container(
      alignment: alignment,
      height: size ?? height,
      width: size ?? width,
      margin: _margin(),
      padding: padding,
      constraints: constraints ?? const BoxConstraints(),
      decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          color: color,
          gradient: gradient,
          borderRadius: _getBorderRadius(__defaultRadius),
          boxShadow: boxShadow,
          image: image,
          border: border),
      child: child,
    );
  }

  BorderRadius? _getBorderRadius(double __defaultRadius) {
    return borderRadius ??
        (useAutoBorderRadius == true
            ? BorderRadius.circular(
                __defaultRadius,
              )
            : null);
  }

  AnimatedContainer _buildAnimatedContainer(double __defaultRadius) {
    return AnimatedContainer(
      duration: Duration(milliseconds: animatedTimeInMilliseconds),
      alignment: alignment,
      height: size ?? height,
      width: size ?? width,
      margin: _margin(),
      padding: padding,
      curve: curve ?? Curves.linear,
      constraints: constraints ?? const BoxConstraints(),
      decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
          color: color,
          gradient: gradient,
          borderRadius: _getBorderRadius(__defaultRadius),
          boxShadow: boxShadow,
          image: image,
          border: border),
      child: child,
    );
  }

  EdgeInsetsGeometry? _margin() => elevation != null ? null : margin;

  Widget _buildCard({required Widget child, required double defaultRadius}) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Card(
        elevation: elevation,
        shadowColor: elevationColor,
        shape: shape == null
            ? _getRoundedRectangleBorderForCard(
                defaultRadius,
              )
            : _getCardShapeFromExtendedContainer(
                defaultRadius,
              ),
        child: child,
      ),
    );
  }

  RoundedRectangleBorder _getRoundedRectangleBorderForCard(
    double __defaultRadius,
  ) =>
      RoundedRectangleBorder(
        borderRadius: _getBorderRadius(
              __defaultRadius,
            ) ??
            BorderRadius.zero,
      );

  ShapeBorder _getCardShapeFromExtendedContainer(double __defaultRadius) {
    switch (shape!) {
      case BoxShape.rectangle:
        return _getRoundedRectangleBorderForCard(__defaultRadius);
      case BoxShape.circle:
        return const CircleBorder();
    }
  }
}
