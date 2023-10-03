import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'country.dart';

class DataBasicModel {
  bool state;
  String massege;
  DataBasic? data;
  DataBasicModel({
    required this.state,
    required this.massege,
    this.data,
  });

  DataBasicModel copyWith({
    bool? state,
    String? massege,
    DataBasic? data,
  }) {
    return DataBasicModel(
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

  factory DataBasicModel.fromMap(Map<String, dynamic> map) {
    return DataBasicModel(
      state: map['state'] as bool,
      massege: map['massege'] as String,
      data: map['data'] != null
          ? DataBasic.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataBasicModel.fromJson(String source) =>
      DataBasicModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DataBasicModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant DataBasicModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        other.data == data;
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}

class DataBasic {
  List<Gender>? gender;
  List<MartialStatus>? martialStatus;

  List<Countries>? countries;
  List<Plantrip>? planTrip;
  DataBasic({
    this.gender,
    this.martialStatus,
    this.countries,
    this.planTrip,
  });

  DataBasic copyWith({
    List<Gender>? gender,
    List<MartialStatus>? martialStatus,
    List<Countries>? countries,
    List<Plantrip>? planTrip,
  }) {
    return DataBasic(
      gender: gender ?? this.gender,
      martialStatus: martialStatus ?? this.martialStatus,
      countries: countries ?? this.countries,
      planTrip: planTrip ?? this.planTrip,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gender': gender?.map((x) => x.toMap()).toList(),
      'martialStatus': martialStatus?.map((x) => x.toMap()).toList(),
      'countries': countries?.map((x) => x.toMap()).toList(),
      'planTrip': planTrip?.map((x) => x.toMap()).toList(),
    };
  }

  factory DataBasic.fromMap(Map<String, dynamic> map) {
    return DataBasic(
      gender: map['gender'] != null
          ? List<Gender>.from(
              (map['gender'] as List<dynamic>).map<Gender?>(
                (x) => Gender.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      martialStatus: map['martialStatus'] != null
          ? List<MartialStatus>.from(
              (map['martialStatus'] as List<dynamic>).map<MartialStatus?>(
                (x) => MartialStatus.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      countries: map['countries'] != null
          ? List<Countries>.from(
              (map['countries'] as List<dynamic>).map<Countries?>(
                (x) => Countries.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      planTrip: map['planTrip'] != null
          ? List<Plantrip>.from(
              (map['planTrip'] as List<dynamic>).map<Plantrip?>(
                (x) => Plantrip.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataBasic.fromJson(String source) =>
      DataBasic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataBasic(gender: $gender, martialStatus: $martialStatus, countries: $countries, planTrip: $planTrip)';
  }

  @override
  bool operator ==(covariant DataBasic other) {
    if (identical(this, other)) return true;

    return listEquals(other.gender, gender) &&
        listEquals(other.martialStatus, martialStatus) &&
        listEquals(other.countries, countries) &&
        listEquals(other.planTrip, planTrip);
  }

  @override
  int get hashCode {
    return gender.hashCode ^
        martialStatus.hashCode ^
        countries.hashCode ^
        planTrip.hashCode;
  }
}

class Plantrip {
  int? id;
  String? name;
  Plantrip({
    this.id,
    this.name,
  });

  Plantrip copyWith({
    int? id,
    String? name,
  }) {
    return Plantrip(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Plantrip.fromMap(Map<String, dynamic> map) {
    return Plantrip(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plantrip.fromJson(String source) =>
      Plantrip.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Plantrip(id: $id, name: $name)';

  @override
  bool operator ==(covariant Plantrip other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

class Gender {
  int? idGender;
  String? nameAr;
  String? nameEn;
  Gender({
    this.idGender,
    this.nameAr,
    this.nameEn,
  });

  Gender copyWith({
    int? idGender,
    String? nameAr,
    String? nameEn,
  }) {
    return Gender(
      idGender: idGender ?? this.idGender,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idGender': idGender,
      'nameAr': nameAr,
      'nameEn': nameEn,
    };
  }

  factory Gender.fromMap(Map<String, dynamic> map) {
    return Gender(
      idGender: map['idGender'] != null ? map['idGender'] as int : null,
      nameAr: map['nameAr'] != null ? map['nameAr'] as String : null,
      nameEn: map['nameEn'] != null ? map['nameEn'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Gender.fromJson(String source) =>
      Gender.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Gender(idGender: $idGender, nameAr: $nameAr, nameEn: $nameEn)';

  @override
  bool operator ==(covariant Gender other) {
    if (identical(this, other)) return true;

    return other.idGender == idGender &&
        other.nameAr == nameAr &&
        other.nameEn == nameEn;
  }

  @override
  int get hashCode => idGender.hashCode ^ nameAr.hashCode ^ nameEn.hashCode;
}

class MartialStatus {
  int? idMartial;
  String? nameAr;
  String? nameEn;
  MartialStatus({
    this.idMartial,
    this.nameAr,
    this.nameEn,
  });

  MartialStatus copyWith({
    int? idMartial,
    String? nameAr,
    String? nameEn,
  }) {
    return MartialStatus(
      idMartial: idMartial ?? this.idMartial,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idMartial': idMartial,
      'nameAr': nameAr,
      'nameEn': nameEn,
    };
  }

  factory MartialStatus.fromMap(Map<String, dynamic> map) {
    return MartialStatus(
      idMartial: map['idMartial'] != null ? map['idMartial'] as int : null,
      nameAr: map['nameAr'] != null ? map['nameAr'] as String : null,
      nameEn: map['nameEn'] != null ? map['nameEn'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MartialStatus.fromJson(String source) =>
      MartialStatus.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MartialStatus(idMartial: $idMartial, nameAr: $nameAr, nameEn: $nameEn)';

  @override
  bool operator ==(covariant MartialStatus other) {
    if (identical(this, other)) return true;

    return other.idMartial == idMartial &&
        other.nameAr == nameAr &&
        other.nameEn == nameEn;
  }

  @override
  int get hashCode => idMartial.hashCode ^ nameAr.hashCode ^ nameEn.hashCode;
}
