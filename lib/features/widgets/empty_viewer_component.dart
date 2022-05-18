import 'package:flutter/material.dart';
import 'package:i_poster/core/helpers/helpers.dart' show SizesHelper;
import 'package:i_poster/features/widgets/separator.dart';
import 'package:i_poster/features/widgets/text_component.dart';
import 'package:i_poster/features/widgets/try_again_button.dart';

class EmptyViewerComponent extends StatelessWidget {
  const EmptyViewerComponent({super.key, required this.onTryAgainPressed});
  final void Function() onTryAgainPressed;

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Icon(Icons.do_not_disturb_alt, size: SizesHelper.fontSize(80),),
        const TextComponent(textKey: 'Nothing found here !'),
        const Separator(value: 15),
        TryAgainButton(onTryAgainPressed: onTryAgainPressed),
        const Separator(value: 100),

      ],
    ),);
  }
}
