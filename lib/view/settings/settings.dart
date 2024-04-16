import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../view_model/bloc/theme_bloc/theme_bloc.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  final List<(String, ThemeMode)> _themes = const [
    ('Dark', ThemeMode.dark),
    ('Light', ThemeMode.light),
    ('System', ThemeMode.system),
  ];

  @override
  Widget build(BuildContext context) {
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
                _themes.length,
                    (index) {
                  final String label = _themes[index].$1;
                  final ThemeMode theme = _themes[index].$2;
                  return ListTile(
                    title: Text(label),
                    onTap: () => context.read<ThemeCubit>().updateTheme(theme),
                    trailing: selectedTheme == theme ? const Icon(Icons.check) : null,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}