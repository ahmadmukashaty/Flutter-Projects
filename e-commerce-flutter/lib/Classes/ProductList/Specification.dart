import 'package:json_utilities/json_utilities.dart';

class Specification {
  String key;
  String value;

  Specification({
    this.key,
    this.value,
  });

  Specification.fromJson(Map<String, dynamic> json)
      : key = JSONUtils().get(json, 'key', ''),
        value = JSONUtils().get(json, 'value', '');

  // method
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}
