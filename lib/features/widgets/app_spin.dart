import 'package:flutter/material.dart';
import 'package:i_poster/config/theme/theme.dart' show AppColors;

class AppSpin extends StatelessWidget {
  const AppSpin({
    super.key, this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation(color??AppColors.primary),
      ),
    );
  }
}
