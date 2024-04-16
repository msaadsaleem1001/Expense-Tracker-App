
import 'package:flutter/material.dart';
import 'package:personal_expense_tracker_app/data/app_exceptions/exceptions.dart';
import 'package:personal_expense_tracker_app/res/routes/routes_names.dart';
import 'package:personal_expense_tracker_app/view/home_view/home_view.dart';
import 'package:personal_expense_tracker_app/view/settings/settings.dart';
import 'package:personal_expense_tracker_app/view/splash/splash_view.dart';

class Routes {

  static Route<dynamic> generateRoutes (RouteSettings settings){

    switch(settings.name){

      case RoutesNames.splashScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());
      case RoutesNames.homeScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RoutesNames.settingsScreen:
        return MaterialPageRoute(builder: (BuildContext context) => const SettingsView());
      default:
        throw InvalidScreenRequest('Invalid screen request that is not defined');
    }

  }
}