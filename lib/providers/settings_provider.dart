import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/settings.dart';

class SettingsNotifier extends StateNotifier<SettingsModel> {
  SettingsNotifier()
      : super(SettingsModel(hoursDefault: 45, advanceStep: 100, id: ''));

  void setSettings(SettingsModel data) {
    state = data;
  }

  Future<void> saveSettings(Map<String, int> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('settings')
          .doc(state.id)
          .update({
        'advanceStep': data['advanceStep'],
        'hoursDefault': data['hoursDefault']
      });
      var newState = SettingsModel(
        id: state.id,
        advanceStep: data['advanceStep']!,
        hoursDefault: data['hoursDefault']!,
      );
      state = newState;
    } catch (error) {
      print(error);
    }
  }

  void setAdvanceStep(int step) {
    final newState = state;
    newState.advanceStep = step;
    state = newState;
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsModel>((ref) {
  return SettingsNotifier();
});
