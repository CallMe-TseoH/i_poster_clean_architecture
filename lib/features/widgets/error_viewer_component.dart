import 'package:flutter/material.dart';
import 'package:i_poster/config/theme/theme.dart';
import 'package:i_poster/core/helpers/helpers.dart' show AppFontSizesHelper;
import 'package:i_poster/core/helpers/sizes_helper.dart';
import 'package:i_poster/features/widgets/separator.dart';
import 'package:i_poster/features/widgets/text_component.dart';
import 'package:i_poster/features/widgets/try_again_button.dart';

class ErrorViewerComponent extends StatelessWidget {
  const ErrorViewerComponent({super.key, required this.onTryAgainPressed});
  final void Function() onTryAgainPressed;
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.error_outline, size: SizesHelper.fontSize(80),),
        const TextComponent(textKey: 'Something went wrong'),
        const Separator(value: 15),
        TryAgainButton(onTryAgainPressed: onTryAgainPressed),
        const Separator(value: 100),
      ],
    ),);
  }
}

