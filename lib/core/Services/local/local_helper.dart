import 'dart:convert';

import 'package:bookia/features/auth/data/models/auth_response/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static const String kuserData = 'userData';
  static const String kwishList = 'wishList';

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static saveData(String key, dynamic value) {
    if (value is int) {
      pref.setInt(key, value);
    } else if (value is String) {
      pref.setString(key, value);
    } else if (value is bool) {
      pref.setBool(key, value);
    } else if (value is double) {
      pref.setDouble(key, value);
    } else if (value is List<String>) {
      pref.setStringList(key, value);
    }
  }

  static saveUserData(UserModel? model) {
    if (model == null) return;

    var json = model.toJson();
    var jsonToString = jsonEncode(json);
    saveData(kuserData, jsonToString);
  }

  static UserModel? getUserData() {
    String? stringdata = getData(kuserData);

    if (stringdata == null) return null;
    var stringjson = jsonDecode(stringdata);
    return UserModel.fromJson(stringjson);
  }

  static saveWishList(List<int> wishListIds) {
    List<String> listOfString = [];
    for (var id in wishListIds) {
      listOfString.add(id.toString());
    }
    saveData(kwishList, listOfString);
  }

  static List<int>? getWishList() {
    List<String>? listOfString = getData(kwishList);

    if (listOfString == null) return null;
    List<int> wishListIds = [];
    for (var id in listOfString) {
      wishListIds.add(int.tryParse(id) ?? 0);
    }
    return wishListIds;
  }

  static dynamic getData(String key) {
    return pref.get(key);
  }

  static remove(String key) async {
    await pref.remove(key);
  }
}
