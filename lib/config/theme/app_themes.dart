import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i_poster/config/theme/app_colors.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get light {
    return ThemeData(
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.white,
        iconTheme: IconThemeData(color: AppColors.dark),
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: AppColors.white,
          statusBarColor: AppColors.white,
        ),
      ),
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      splashColor: AppColors.dark.withOpacity(.5),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(AppColors.dark)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: AppColors.primary,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.primary.withOpacity(.35),
        selectionHandleColor: AppColors.primary,
        cursorColor: AppColors.primary,
      ),
      fontFamily: GoogleFonts.jost().fontFamily,
      colorScheme: ColorScheme.fromSwatch(
        accentColor: AppColors.primary,
      ),
    );
  }
}
