import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:oneaddress/Classes/Authentication/Language.dart';
import 'package:oneaddress/Services/Network_Cache_Management/SharedPref.dart';
import 'package:oneaddress/Utilities/Constants.dart';

class LanguageManagement {
  static Language _lang;

  static checkLang() async {
    SharedPref sharedPref = SharedPref();
    _lang = await sharedPref.getAppLang();
  }

  static Language getLang() {
    return _lang;
  }

  static bool isArabic() {
    return (_lang.key == "ar");
  }

  static bool isEnglish() {
    return (_lang.key == "en");
  }

  static List<Language> getAllLanguages() {
    List<Language> langs = List<Language>();
    langs.add(Language.getEnglish());
    langs.add(Language.getArabic());
    return langs;
  }

  static bool equalLang(Language lang) {
    if (lang == null) return false;
    if (_lang == null) return false;
    return ((lang.key == _lang.key) && (lang.valueEn == _lang.valueEn));
  }

  static Locale getLocale() {
    return (LanguageManagement.isEnglish())
        ? Locale('en', 'US')
        : Locale('ar', 'SA');
  }

  static int getLangIndex() {
    return (LanguageManagement.isEnglish()) ? 0 : 1;
  }

  static updateLanguage(Language lang) async {
    if (lang != null && !LanguageManagement.equalLang(lang)) {
      SharedPref sharedPref = SharedPref();
      await sharedPref.save(kLangKey, jsonEncode(lang));
      await LanguageManagement.checkLang();
    }
  }
}
