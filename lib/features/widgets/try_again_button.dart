import 'package:flutter/material.dart';
import 'package:i_poster/config/theme/theme.dart';
import 'package:i_poster/core/helpers/helpers.dart';
import 'package:i_poster/features/widgets/widgets.dart' show TextComponent;

class TryAgainButton extends StatelessWidget {
  const TryAgainButton({
    super.key,
    required this.onTryAgainPressed,
  });

  final void Function() onTryAgainPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onTryAgainPressed,
        icon: Icon(
          Icons.refresh,
          size: AppFontSizesHelper.m,
          color: AppColors.dark,
        ),
        label: TextComponent(
          textKey: 'Click to try again',
          fontSize: AppFontSizesHelper.l,
        ));
  }
}
