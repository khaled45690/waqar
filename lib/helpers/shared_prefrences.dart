import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceHelper {

  static SharedPreferences _prefs;

  static final SharedPrefrenceHelper _instance =  SharedPrefrenceHelper._internal();

  factory SharedPrefrenceHelper() {
    if(_prefs == null){
       _initPrefs();
    }
    return _instance;
  }

  SharedPrefrenceHelper._internal();

  static _initPrefs() async{
    _prefs = await SharedPreferences.getInstance();
  }
  dynamic getValueForKey(String key){
    return _prefs.get(key);
  }

  dynamic getValueForKeyWithAlternativeValue({@required String key,@required dynamic alternativeValue}){
    if(_prefs.get(key)==null)
      setValueForKey(key, alternativeValue);
    return _prefs.get(key);
  }

  setValueForKey(String key, dynamic value) {
    if (value == null) {
      removeValueForKey(key);
    } else if (value is int) {
      _prefs.setInt(key, value);
    } else if (value is String) {
      _prefs.setString(key, value);
    } else if (value is bool) {
      _prefs.setBool(key, value);
    } else {
      throw "unknown value type :(";
    }
  }

  Future<bool> removeValueForKey(String key){
    return _prefs.remove(key);
  }
}
