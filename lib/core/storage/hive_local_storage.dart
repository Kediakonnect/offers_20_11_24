import 'package:hive/hive.dart';

class HiveLocalStorage {
  static Future<Box<T?>> openBox<T>(
    String key,
  ) async {
    try {
      return await Hive.openBox<T?>(key);
    } catch (error) {
      return Future.error(error);
    }
  }

  static Future<void> deleteBox(String key) async {
    await Hive.deleteBoxFromDisk(key);
  }

  static Future<void> deleteAll() async {
    await Hive.deleteFromDisk();
  }

  static Future<void> close() async {
    await Hive.close();
  }
}
