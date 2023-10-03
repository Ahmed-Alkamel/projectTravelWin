// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'category.dart' as cat;
import 'currencies.dart';
import 'data_basic.dart';
import 'identitfy_card.dart';
import 'type_filed.dart';

class DataBasicOfAddServic {
  List<cat.Category> categories;
  List<Gender> gender;
  List<MartialStatus> martialStatus;
  List<TypeFiled> typeFiled;
  List<IdentitfyCard> identities;
  List<Currencies> currencies;
  DataBasicOfAddServic({
    required this.categories,
    required this.gender,
    required this.martialStatus,
    required this.typeFiled,
    required this.identities,
    required this.currencies,
  });

  DataBasicOfAddServic copyWith({
    List<cat.Category>? categories,
    List<Gender>? gender,
    List<MartialStatus>? martialStatus,
    List<TypeFiled>? typeFiled,
    List<IdentitfyCard>? identities,
    List<Currencies>? currencies,
  }) {
    return DataBasicOfAddServic(
      categories: categories ?? this.categories,
      gender: gender ?? this.gender,
      martialStatus: martialStatus ?? this.martialStatus,
      typeFiled: typeFiled ?? this.typeFiled,
      identities: identities ?? this.identities,
      currencies: currencies ?? this.currencies,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categories': categories.map((x) => x.toMap()).toList(),
      'gender': gender.map((x) => x.toMap()).toList(),
      'martialStatus': martialStatus.map((x) => x.toMap()).toList(),
      'typeFiled': typeFiled.map((x) => x.toMap()).toList(),
      'identities': identities.map((x) => x.toMap()).toList(),
      'currencies': currencies.map((x) => x.toMap()).toList(),
    };
  }

  factory DataBasicOfAddServic.fromMap(Map<String, dynamic> map) {
    return DataBasicOfAddServic(
      categories: List<cat.Category>.from(
        (map['categories'] as List<dynamic>).map<cat.Category>(
          (x) => cat.Category.fromMap(x as Map<String, dynamic>),
        ),
      ),
      gender: List<Gender>.from(
        (map['gender'] as List<dynamic>).map<Gender>(
          (x) => Gender.fromMap(x as Map<String, dynamic>),
        ),
      ),
      martialStatus: List<MartialStatus>.from(
        (map['martialStatus'] as List<dynamic>).map<MartialStatus>(
          (x) => MartialStatus.fromMap(x as Map<String, dynamic>),
        ),
      ),
      typeFiled: List<TypeFiled>.from(
        (map['typeFiled'] as List<dynamic>).map<TypeFiled>(
          (x) => TypeFiled.fromMap(x as Map<String, dynamic>),
        ),
      ),
      identities: List<IdentitfyCard>.from(
        (map['identities'] as List<dynamic>).map<IdentitfyCard>(
          (x) => IdentitfyCard.fromMap(x as Map<String, dynamic>),
        ),
      ),
      currencies: List<Currencies>.from(
        (map['currencies'] as List<dynamic>).map<Currencies>(
          (x) => Currencies.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory DataBasicOfAddServic.fromJson(String source) =>
      DataBasicOfAddServic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataBasicOfAddServic(categories: $categories, gender: $gender, martialStatus: $martialStatus, typeFiled: $typeFiled, identities: $identities, currencies: $currencies)';
  }

  @override
  bool operator ==(covariant DataBasicOfAddServic other) {
    if (identical(this, other)) return true;

    return listEquals(other.categories, categories) &&
        listEquals(other.gender, gender) &&
        listEquals(other.martialStatus, martialStatus) &&
        listEquals(other.typeFiled, typeFiled) &&
        listEquals(other.identities, identities) &&
        listEquals(other.currencies, currencies);
  }

  @override
  int get hashCode {
    return categories.hashCode ^
        gender.hashCode ^
        martialStatus.hashCode ^
        typeFiled.hashCode ^
        identities.hashCode ^
        currencies.hashCode;
  }
}

class DataBasicOfAddServicModel {
  bool state;
  String massege;
  DataBasicOfAddServic? data;
  DataBasicOfAddServicModel({
    required this.state,
    required this.massege,
    this.data,
  });

  DataBasicOfAddServicModel copyWith({
    bool? state,
    String? massege,
    DataBasicOfAddServic? data,
  }) {
    return DataBasicOfAddServicModel(
      state: state ?? this.state,
      massege: massege ?? this.massege,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'massege': massege,
      'data': data?.toMap(),
    };
  }

  factory DataBasicOfAddServicModel.fromMap(Map<String, dynamic> map) {
    return DataBasicOfAddServicModel(
      state: map['state'] as bool,
      massege: map['massege'] as String,
      data: map['data'] != null
          ? DataBasicOfAddServic.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataBasicOfAddServicModel.fromJson(String source) =>
      DataBasicOfAddServicModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DataBasicOfAddServicModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant DataBasicOfAddServicModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        other.data == data;
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}
