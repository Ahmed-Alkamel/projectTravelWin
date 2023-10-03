// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'main_requiremnt.dart';

class SubRequiremnt {
  int? idSubRequerment;
  int? gender;
  int? idMartial;
  bool? isFamely;
  int? lessThanAge;
  int? moreThanAge;
  List<SubRequirmentDetails>? detaial;
  SubRequiremnt({
    this.idSubRequerment,
    this.gender,
    this.idMartial,
    this.isFamely,
    this.lessThanAge,
    this.moreThanAge,
    this.detaial,
  }) {
    detaial = [];
  }

  SubRequiremnt copyWith({
    int? idSubRequerment,
    int? gender,
    int? idMartial,
    bool? isFamely,
    int? lessThanAge,
    int? moreThanAge,
    List<SubRequirmentDetails>? detaial,
  }) {
    return SubRequiremnt(
      idSubRequerment: idSubRequerment ?? this.idSubRequerment,
      gender: gender ?? this.gender,
      idMartial: idMartial ?? this.idMartial,
      isFamely: isFamely ?? this.isFamely,
      lessThanAge: lessThanAge ?? this.lessThanAge,
      moreThanAge: moreThanAge ?? this.moreThanAge,
      detaial: detaial ?? this.detaial,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idSubRequerment': idSubRequerment,
      'gender': gender,
      'idMartial': idMartial,
      'isFamely': isFamely,
      'lessThanAge': lessThanAge,
      'moreThanAge': moreThanAge,
      'detaial': detaial?.map((x) => x.toMap()).toList(),
    };
  }

  factory SubRequiremnt.fromMap(Map<String, dynamic> map) {
    return SubRequiremnt(
      idSubRequerment:
          map['idSubRequerment'] != null ? map['idSubRequerment'] as int : null,
      gender: map['idGender'] != null ? map['idGender'] as int : null,
      idMartial: map['idMartial'] != null ? map['idMartial'] as int : null,
      isFamely: map['isFamely'] != null ? map['isFamely'] as bool : null,
      lessThanAge:
          map['lessThanAge'] != null ? map['lessThanAge'] as int : null,
      moreThanAge:
          map['moreThanAge'] != null ? map['moreThanAge'] as int : null,
      detaial: map['detaial'] != null
          ? List<SubRequirmentDetails>.from(
              (map['detaial'] as List<dynamic>).map<SubRequirmentDetails?>(
                (x) => SubRequirmentDetails.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubRequiremnt.fromJson(String source) =>
      SubRequiremnt.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubRequiremnt(idSubRequerment: $idSubRequerment, gender: $gender, idMartial: $idMartial, isFamely: $isFamely, lessThanAge: $lessThanAge, moreThanAge: $moreThanAge, detaial: $detaial)';
  }

  @override
  bool operator ==(covariant SubRequiremnt other) {
    if (identical(this, other)) return true;

    return other.idSubRequerment == idSubRequerment &&
        other.gender == gender &&
        other.idMartial == idMartial &&
        other.isFamely == isFamely &&
        other.lessThanAge == lessThanAge &&
        other.moreThanAge == moreThanAge &&
        listEquals(other.detaial, detaial);
  }

  @override
  int get hashCode {
    return idSubRequerment.hashCode ^
        gender.hashCode ^
        idMartial.hashCode ^
        isFamely.hashCode ^
        lessThanAge.hashCode ^
        moreThanAge.hashCode ^
        detaial.hashCode;
  }
}
