import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_expense_tracker_app/repository/sqlite_repo/ExpenseRepository.dart';
import 'package:personal_expense_tracker_app/res/routes/app_routes.dart';
import 'package:personal_expense_tracker_app/res/routes/routes_names.dart';
import 'package:personal_expense_tracker_app/res/theme_data/theme_data.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/expense_bloc/expense_bloc.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/settings_bloc/settings_bloc.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/splash_bloc/splash_bloc.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/theme_bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // initialize hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  // This widget is the root of Expense Tracker Application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ExpenseBloc(ExpenseDatabaseRepository.instance)),
        BlocProvider(create: (_) => SplashBloc()),
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, ThemeMode mode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Expense Tracker App',
            theme: ExpenseAppThemeData.light,
            darkTheme: ExpenseAppThemeData.dark,
            themeMode: mode,
            initialRoute: RoutesNames.splashScreen,
            onGenerateRoute: Routes.generateRoutes,
          );
        },
      ),
    );
  }
}
