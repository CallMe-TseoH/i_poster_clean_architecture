import 'package:flutter/material.dart';
import 'package:i_poster/core/helpers/helpers.dart' show SizesHelper;

class EmptyViewerComponent extends StatelessWidget {
  const EmptyViewerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Icon(Icons.do_not_disturb_alt, size: SizesHelper.fontSize(35),),);
  }
}
