import 'package:json_utilities/json_utilities.dart';
import 'package:oneaddress/Services/Management/LanguageManagement.dart';

class Language {
  String key;
  String valueEn;
  String valueAr;

  Language({this.key, this.valueEn, this.valueAr});

  Language.getDefault() {
    this.key = "en";
    this.valueEn = "English";
    this.valueAr = "الانكليزية";
  }

  Language.getArabic() {
    this.key = "ar";
    this.valueEn = "Arabic";
    this.valueAr = "العربية";
  }

  Language.getEnglish() {
    this.key = "en";
    this.valueEn = "English";
    this.valueAr = "الانكليزية";
  }

  Language.fromJson(Map<String, dynamic> json)
      : key = JSONUtils().get(json, 'key', ''),
        valueEn = JSONUtils().get(json, 'valueEn', ''),
        valueAr = JSONUtils().get(json, 'valueAr', '');

  Map<String, dynamic> toJson() {
    return {'key': key, 'valueEn': valueEn, 'valueAr': valueAr};
  }

  String getValue() {
    return (LanguageManagement.isEnglish()) ? this.valueEn : this.valueAr;
  }
}
