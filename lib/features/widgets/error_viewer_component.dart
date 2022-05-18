import 'package:flutter/material.dart';
import 'package:i_poster/core/helpers/helpers.dart' show AppFontSizesHelper;
import 'package:i_poster/features/widgets/widgets.dart' show TextComponent;

class ErrorViewerComponent extends StatelessWidget {
  const ErrorViewerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      children: [
        Icon(Icons.error_outline, size: AppFontSizesHelper.xxl,),
        TextComponent(textKey: 'Something went wrong'),
      ],
    ),);
  }
}
