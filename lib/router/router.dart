import 'package:flutter/material.dart';
import 'package:softec_app/screens/home_screen.dart';
import 'package:softec_app/screens/notifications_screen.dart';
import 'package:softec_app/screens/profile_screen.dart';
import 'package:softec_app/screens/search_screen.dart';

Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case 'home':
      return FadeRoute(
        settings: settings,
        child: const HomeScreen(),
      );

    case 'search':
      return FadeRoute(
        settings: settings,
        child: const SearchScreen(),
      );

    case 'profile':
      return FadeRoute(
        settings: settings,
        child: const ProfileScreen(),
      );

    case 'notifications':
      return FadeRoute(
        settings: settings,
        child: const NotificationsScreen(),
      );

    default:
      return null;
  }
}

class FadeRoute extends PageRouteBuilder {
  final Widget child;

  @override
  final RouteSettings settings;

  FadeRoute({required this.child, required this.settings})
      : super(
          settings: settings,
          pageBuilder: (context, ani1, ani2) => child,
          transitionsBuilder: (context, ani1, ani2, child) {
            return FadeTransition(
              opacity: ani1,
              child: child,
            );
          },
        );
}

class AppRouter {
  static Future push(BuildContext context, Widget screen) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
