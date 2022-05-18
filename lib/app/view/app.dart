// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_poster/config/behaviors/behaviors.dart' show DisableGlowingScrollBehavior;
import 'package:i_poster/config/routes/routes.dart';
import 'package:i_poster/config/theme/theme.dart' show AppThemes;
import 'package:i_poster/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      minTextAdapt: true,
      builder: (BuildContext _, Widget? child) {
        return MaterialApp(
          onGenerateRoute: AppRoutes.onGenerateRoute,
          initialRoute: RMI.home,
          builder: (_, widget){
            return ScrollConfiguration(
              behavior: DisableGlowingScrollBehavior(),
              child: StretchingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  child: widget),
            );
          },
          debugShowCheckedModeBanner: false,
          theme: AppThemes.light,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
