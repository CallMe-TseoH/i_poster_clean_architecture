import 'package:flutter/material.dart';
import 'package:i_poster/config/theme/theme.dart' show AppColors;
import 'package:i_poster/core/helpers/helpers.dart' show AppFontSizesHelper, SizesHelper;
import 'package:i_poster/features/widgets/widgets.dart' show ExtendedContainer, TextComponent;

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key, required this.title, this.onPressed, bool onLoading = false,
  }) : _onLoading = onLoading;
  final bool _onLoading;
  final String title;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ExtendedContainer(
      height: SizesHelper.height(55),
      constraints: BoxConstraints(
        minWidth: SizesHelper.width(MediaQuery.of(context).size.width / 1.85),
      ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(SizesHelper.radius(8)),
            ),
            elevation: .75,),
          onPressed: onPressed,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: SizesHelper.width(15)),
            child: TextComponent(
              textKey: title,
              color: Colors.white,
              fontSize: AppFontSizesHelper.m,
            ),
          )),
    );
  }
}
