import 'package:flutter/material.dart';
import 'package:i_poster/features/editing/editing.dart';
import 'package:i_poster/features/home/domain/entities/entities.dart';
import 'package:i_poster/features/home/home.dart' show Home, PostDetailPage;
class AppRoutes {
  AppRoutes._();

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Home.routeName:
        return _materialPageRoute(const Home());
        case Editing.routeName:
        return _materialPageRoute(Editing(postEntity: settings.arguments as PostEntity?,));
      default:
        return null;
    }
  }

  static MaterialPageRoute<dynamic> _materialPageRoute(Widget child)
  => MaterialPageRoute<dynamic>(builder: (_)=> child);
}
