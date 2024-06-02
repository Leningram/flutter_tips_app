import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings {
  int advanceStep;
  int hoursDefault;
  Settings({required this.advanceStep, required this.hoursDefault});
}

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier() : super(Settings(hoursDefault: 45, advanceStep: 100));

  void setAdvanceStep(int step) {
    final newState = state;
    newState.advanceStep = step;
    state = newState;
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  return SettingsNotifier();
});
