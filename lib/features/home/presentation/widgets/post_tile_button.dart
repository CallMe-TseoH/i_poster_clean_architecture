
import 'package:flutter/material.dart';
import 'package:i_poster/config/theme/theme.dart' show AppColors;
import 'package:i_poster/core/helpers/helpers.dart' show AppFontSizesHelper;
import 'package:i_poster/features/widgets/widgets.dart' show TextComponent;

class PostTileButton extends StatelessWidget {
  const PostTileButton({
    super.key, required this.title, required this.icon, required this.onPressed,
  });
final String title;
final IconData icon;
final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextButton.icon(
            onPressed: onPressed,
            icon: Icon(icon, size: AppFontSizesHelper.m, color: AppColors.dark,),
            label: TextComponent(
              textKey: title,
              fontSize: AppFontSizesHelper.m,
            )));
  }
}
