import 'dart:convert';

import 'package:in_setu/constants/strings.dart';
import 'package:in_setu/screens/login_view/model/LoginAuthModel.dart';
import 'package:in_setu/screens/login_view/model/register_model/RegisterResponse.dart';
import 'package:in_setu/screens/mainpower_screen/model/ManPowerModelResponse.dart';
import 'package:in_setu/screens/material_view/model/MaterialSearchKeyword.dart';
import 'package:in_setu/screens/material_view/model/SearchUnitResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferenceManager {

  static const String oauth = "oauth";
  static const String registerAuth = "registerAuth";
  static const String walkthrough = "walkthrough";
  static const String saveDateList = "saveDateList";
  static const String siteNumber = "siteNumber";
  static const String searchDataListKey = "searchDataList";
  static const String searchUnitDataKey = "searchUnitData";

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }


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
  static Future<void> clearOAuth() async {
    (await prefs).remove(oauth);
  }


  static setFirstCallOnboarding(bool oneTime) async{
    (await prefs).setBool(walkthrough, oneTime);
  }
  static getFirstCallOnboarding() async {
    return (await prefs).getBool(walkthrough) ?? false;
  }
  static Future<void> saveNumValue(num value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(siteNumber, value);
    } else if (value is double) {
      await prefs.setDouble(siteNumber, value);
    }
  }
  static Future<num> getNumValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(siteNumber) ?? prefs.getDouble(siteNumber) ?? 0;
  }

  // For SearchData list
  static Future<void> saveSearchDataList(List<SearchData>? list) async {
    if (list == null) {
      await (await prefs).remove(searchDataListKey);
      return;
    }

    try {
      final jsonList = list.map((item) => item.toJson()).toList();
      await (await prefs).setString(searchDataListKey, jsonEncode(jsonList));
    } catch (e) {
      print('Error saving searchDataList: $e');
      await (await prefs).remove(searchDataListKey);
    }
  }

  static Future<List<SearchData>> getSearchDataList() async {
    try {
      final jsonString = (await prefs).getString(searchDataListKey);
      if (jsonString == null || jsonString.isEmpty) return [];

      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => SearchData.fromJson(json)).toList();
    } catch (e) {
      print('Error loading searchDataList: $e');
      await (await prefs).remove(searchDataListKey);
      return [];
    }
  }

// For SearchUnitData list
  static Future<void> saveSearchUnitDataList(List<SearchUnitData>? list) async {
    if (list == null) {
      await (await prefs).remove(searchUnitDataKey);
      return;
    }

    try {
      final jsonList = list.map((item) => item.toJson()).toList();
      await (await prefs).setString(searchUnitDataKey, jsonEncode(jsonList));
    } catch (e) {
      print('Error saving searchUnitDataList: $e');
      await (await prefs).remove(searchUnitDataKey);
    }
  }

  static Future<List<SearchUnitData>> getSearchUnitDataList() async {
    final jsonString = (await prefs).getString(searchUnitDataKey) ?? '';
    if (jsonString.isEmpty) return [];

    try {
      final jsonList = jsonDecode(jsonString) as List;
      return jsonList.map((json) => SearchUnitData.fromJson(json)).toList();
    } catch (e) {
      print('Error parsing searchUnitDataList: $e');
      return [];
    }
  }

}
