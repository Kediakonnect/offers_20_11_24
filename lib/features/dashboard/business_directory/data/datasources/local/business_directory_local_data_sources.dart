import 'package:divyam_flutter/core/storage/hive_local_storage.dart';
import 'package:divyam_flutter/features/dashboard/business_directory/data/model/state_model.dart';

class BusinessDirectoryLocalDataSources {
  String _key = 'states';

  Future<void> saveStatesToLocalDb(StateModelResponse states) async {
    try {
      final box = await HiveLocalStorage.openBox(_key);
      box.put("data", states);
    } catch (e) {
      throw Exception('Failed to Add States in local  DB: $e');
    }
  }

  Future<bool> checkIfStatesExists() async {
    try {
      final box = await HiveLocalStorage.openBox(_key);
      return box.containsKey("data");
    } catch (e) {
      throw Exception('Failed to Add States in local  DB: $e');
    }
  }

  Future<StateModelResponse> getStatesFromLocalDb() async {
    final box = await HiveLocalStorage.openBox(_key);
    if (box.containsKey("data")) {
      final states = await box.get("data") as StateModelResponse;
      return states;
    } else {
      throw Exception('States does not exist in the database.');
    }
  }

  Future<void> delete() async {
    final box = await HiveLocalStorage.openBox(_key);
    box.clear();
  }
}
