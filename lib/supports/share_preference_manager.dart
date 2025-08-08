import 'dart:convert';

import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/login_view/model/register_model/RegisterResponse.dart';
import 'package:in_setu/screens/mainpower_screen/model/ManPowerModelResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceManager {

  static const String oauth = "oauth";
  static const String registerAuth = "registerAuth";
  static const String walkthrough = "walkthrough";
  static const String saveDateList = "saveDateList";

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

/*
  static getBoolValue(String key, bool defaultValue) async {
    return (await prefs).getBool(key) ?? defaultValue;
  }


  //FingerPrintDialogAtFirstLogin
  static setFingerPrintDialog(bool oneTime) async {
    (await prefs).setBool(fingerPrintDialog, oneTime);
  }

  static getFingerPrintDialog() async {
    return (await prefs).getBool(fingerPrintDialog) ?? false;
  }
*/

  static Future<List<AllDates>> getDateList() async {
    String dateList = (await prefs).getString(saveDateList) ?? '';
    if (dateList.isNotEmpty) {
      try {
        List<dynamic> jsonList = jsonDecode(dateList);
        return jsonList.map((json) => AllDates.fromJson(json)).toList();
      } catch (e) {
        print('Error parsing date list: $e');
        return [];
      }
    } else {
      return [];
    }
  }

  static Future<void> setDateList(List<AllDates> dates) async {
    String jsonString = jsonEncode(dates.map((date) => date.toJson()).toList());
    await (await prefs).setString(saveDateList, jsonString);
  }

  static setOAuth(LoginAuthModel oAuth) async {
    (await prefs).setString(oauth, jsonEncode(oAuth));
  }

  static Future<LoginAuthModel?> getOAuth() async {
    String oAuthData = (await prefs).getString(oauth) ?? '';
    if (oAuthData.isNotEmpty) {
      Map json = jsonDecode(oAuthData);
      var oAuth = LoginAuthModel.fromJson(json);
      return oAuth;
    } else {
      return null;
    }
  }


  static setFirstCallOnboarding(bool oneTime) async{
    (await prefs).setBool(walkthrough, oneTime);
  }
  static getFirstCallOnboarding() async {
    return (await prefs).getBool(walkthrough) ?? false;
  }
}
