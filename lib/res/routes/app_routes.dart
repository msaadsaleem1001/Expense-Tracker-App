
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker_app/data/app_exceptions/exceptions.dart';
import 'package:personal_expense_tracker_app/res/routes/routes_names.dart';
import 'package:personal_expense_tracker_app/view/home_view/home_view.dart';
import 'package:personal_expense_tracker_app/view/settings/settings.dart';
import 'package:personal_expense_tracker_app/view/splash/splash_view.dart';
// App Routes.
class Routes {
  // Static Method of generating routes.
  static Route<dynamic> generateRoutes (RouteSettings settings){
    // Checking the name of route and return appropriate Screen.
    switch(settings.name){
      // Splash Screen.
      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());
      // Home Screen
      case RoutesNames.homeScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      // Settings Screen
      case RoutesNames.settingsScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SettingsView());
      // The Only Exception we are using in app.
      default:
        throw InvalidScreenRequest('Invalid screen request that is not defined');
    }

  }
}