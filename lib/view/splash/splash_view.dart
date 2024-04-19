import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/splash_bloc/splash_bloc.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/splash_bloc/splash_event.dart';
import '../../res/app_assets/app_assets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(ChangeScreenEvent(context: context));
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
            child: SizedBox(
          width: width * .9,
          height: 200,
          child: SvgPicture.asset(AppAssets.splash),
        )),
      )),
    );
  }
}
