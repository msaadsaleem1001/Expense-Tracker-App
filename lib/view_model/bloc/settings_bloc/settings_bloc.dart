import 'package:bloc/bloc.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/settings_bloc/settings_event.dart';
import 'package:personal_expense_tracker_app/view_model/bloc/settings_bloc/settings_state.dart';


class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  SettingsBloc() : super(const SettingsState());

}
