import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferanceStorage {
  static final SharedPreferanceStorage sharedPreferance =
      SharedPreferanceStorage._internal();
  SharedPreferanceStorage._internal();
  factory SharedPreferanceStorage() {
    return sharedPreferance;
  }

  Future<bool?> isDark() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('Dark');
  }

  Future<bool?> isTextHuge() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('TextHuge');
  }

  Future<bool?> isAccecsibiltySound() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('AccecsibiltySound');
  }

  Future<bool?> isEnglish() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('English');
  }

  Future<void> changeLocale(Locale locale) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (locale.countryCode == 'en') {
      preferences.setBool('English', true);
    } else {
      preferences.setBool('English', false);
    }
  }

  Future<void> changeTheme(String theme) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (theme == 'Dark') {
      preferences.setBool('Dark', true);
    } else {
      preferences.setBool('Dark', false);
    }
  }

  Future<void> changeTextSize(bool isAccesible) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (isAccesible) {
      preferences.setBool('TextHuge', true);
    } else {
      preferences.setBool('TextHuge', false);
    }
  }

  Future<void> changeVoiceSound(bool isAccesible) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (isAccesible) {
      preferences.setBool('AccecsibiltySound', true);
    } else {
      preferences.setBool('AccecsibiltySound', false);
    }
  }
}
