import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tips_app/data/models/settings.dart';

class SettingsNotifier extends StateNotifier<SettingsModel?> {
  SettingsNotifier() : super(null);

  void setSettings(SettingsModel data) {
    state = data;
  }

  void fetchSettings(String teamId) async {
    if (state != null) {
      return;
    }
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('settings')
          .where('teamId', isEqualTo: teamId)
          .limit(1)
          .get();
      List<QueryDocumentSnapshot> docs = querySnapshot.docs;
      if (docs.isNotEmpty) {
        DocumentSnapshot settingsDoc = docs[0];
        Map<String, dynamic> settingsData =
            settingsDoc.data() as Map<String, dynamic>;
        final SettingsModel settings = SettingsModel(
            advanceStep: settingsData['advanceStep'],
            hoursDefault: settingsData['hoursDefault'],
            id: settingsDoc.id);
        state = settings;
      }
    } catch (error) {
      state = SettingsModel(advanceStep: 100, hoursDefault: 45, id: '');
    }
  }

  Future<void> saveSettings(Map<String, int> data) async {
    try {
      await FirebaseFirestore.instance
          .collection('settings')
          .doc(state!.id)
          .update({
        'advanceStep': data['advanceStep'],
        'hoursDefault': data['hoursDefault']
      });
      var newState = SettingsModel(
        id: state!.id,
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
    newState!.advanceStep = step;
    state = newState;
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsModel?>((ref) {
  return SettingsNotifier();
});
