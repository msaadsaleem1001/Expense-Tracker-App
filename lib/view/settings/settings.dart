import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/settings_bloc/settings_bloc.dart';
import '../../view_model/bloc/settings_bloc/settings_state.dart';
import '../../view_model/bloc/theme_bloc/theme_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Theme Settings'),
            centerTitle: false,
          ),
          body: Center(
            child: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, selectedTheme) {
                return Column(
                  children: List.generate(
                    state.themes.length,
                        (index) {
                      final String label = state.themes[index].$1;
                      final ThemeMode theme = state.themes[index].$2;
                      return ListTile(
                        title: Text(label),
                        onTap: () =>
                            context.read<ThemeCubit>().updateTheme(theme),
                        trailing: selectedTheme == theme ? const Icon(
                            Icons.check) : null,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}