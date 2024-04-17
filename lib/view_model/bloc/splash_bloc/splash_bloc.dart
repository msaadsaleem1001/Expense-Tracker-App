import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:personal_expense_tracker_app/res/routes/routes_names.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/splash_bloc/splash_event.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/splash_bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {

  SplashBloc() : super(const SplashState()) {
    on<ChangeScreenEvent>(_changeScreenEvent);
  }

  // this method is shifting screen after 2 seconds on calling it.
  void _changeScreenEvent(ChangeScreenEvent event, Emitter<SplashState> emit) async{
    await Future.delayed(const Duration(milliseconds: 2000)).whenComplete(() {
      Navigator.popAndPushNamed(event.context, RoutesNames.homeScreen);
    });
  }

}
