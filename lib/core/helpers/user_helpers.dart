import 'package:divyam_flutter/core/managers/shared_preference_manager.dart';
import 'package:divyam_flutter/features/authentication/data/model/account_model.dart';

const STRING_KEY_USER = "tokens";
const STRING_KEY_APPTOKEN = "appToken";

class UserHelpers {
  static User? user;

  static setAuthToken(String token) async {
    print('==============================> $token');
    try {
      SharedPreferencesManager.setString(STRING_KEY_APPTOKEN, token);
    } catch (e) {
      print('======================================> $e');
    }
  }

  static String getAuthToken() {
    return SharedPreferencesManager.getString(STRING_KEY_APPTOKEN);
  }

  static deleteAuthToken() async {
    try {
      SharedPreferencesManager.removeKey(STRING_KEY_APPTOKEN);
      SharedPreferencesManager.removeKey(STRING_KEY_USER);

      print('Token deleted successfully');
    } catch (e) {
      print('Failed to delete token: $e');
    }
  }

  static setUserDetails(User profileDetails) async {
    try {
      SharedPreferencesManager.setObject(
          STRING_KEY_USER, profileDetails.toJson());
    } catch (e) {
      print("Failed to save user details");
    }
  }

  static Future<dynamic> getUserDetails() async {
    Object obj = SharedPreferencesManager.getObject(STRING_KEY_USER);
    print(obj);
    if (obj == false) {
      return obj;
    } else {
      print(obj);
      user = User.fromJson(obj as Map<String, dynamic>);
      return user;
    }
  }
}
