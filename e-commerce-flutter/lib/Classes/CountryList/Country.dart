import 'package:json_utilities/json_utilities.dart';

class Country {
  int id;
  String name;

  Country({
    this.id,
    this.name,
  });

  Country.fromJson(Map<String, dynamic> json)
      : id = JSONUtils().get(json, 'id', 0),
        name = JSONUtils().get(json, 'name', '');

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
