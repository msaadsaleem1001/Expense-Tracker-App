import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class SettingsState extends Equatable {
  final List<(String, ThemeMode)> themes;

  const SettingsState({
    this.themes = const [
      ('Dark', ThemeMode.dark),
      ('Light', ThemeMode.light),
      ('System', ThemeMode.system),
    ],
  });

  SettingsState copyWith() {
    return const SettingsState();
  }

  @override
  List<Object?> get props => [];
}
