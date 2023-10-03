// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'trips.dart';

class Countries {
  int? id;
  String? countryName;
  bool? isLocal;
  List<City>? cities;

  Countries({
    this.id,
    this.countryName,
    this.isLocal,
    this.cities,
  }) {
    cities ??= [];
  }

  Countries copyWith({
    int? id,
    String? countryName,
    bool? isLocal,
    List<City>? cities,
  }) {
    return Countries(
      id: id ?? this.id,
      countryName: countryName ?? this.countryName,
      isLocal: isLocal ?? this.isLocal,
      cities: cities ?? this.cities,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'countryName': countryName,
      'isLocal': isLocal,
      'cities': cities?.map((x) => x.toMap()).toList(),
    };
  }

  factory Countries.fromMap(Map<String, dynamic> map) {
    return Countries(
      id: map['id'] != null ? map['id'] as int : null,
      countryName:
          map['countryName'] != null ? map['countryName'] as String : null,
      isLocal: map['isLocal'] != null ? map['isLocal'] as bool : null,
      cities: map['cities'] != null
          ? List<City>.from(
              (map['cities'] as List<dynamic>).map<City?>(
                (x) => City.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Countries.fromJson(String source) =>
      Countries.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Countries(id: $id, countryName: $countryName, isLocal: $isLocal, cities: $cities)';
  }

  @override
  bool operator ==(covariant Countries other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.countryName == countryName &&
        other.isLocal == isLocal &&
        listEquals(other.cities, cities);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        countryName.hashCode ^
        isLocal.hashCode ^
        cities.hashCode;
  }
}
