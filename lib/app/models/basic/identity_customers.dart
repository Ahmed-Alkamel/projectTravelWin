// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:get/get.dart';

import 'data_basic.dart';
import 'identitfy_card.dart';

class IdentityCustomers {
  int? id;
  Name name;
  Rx<Gender?> gender;
  Rx<MartialStatus?> martial;
  IdentitfyCard? typeIdentity;
  String? datePirth;
  String? releaseDate;
  IdentityCustomers({
    this.id,
    required this.name,
    required this.gender,
    required this.martial,
    this.typeIdentity,
    this.datePirth,
    this.releaseDate,
  });

  IdentityCustomers copyWith({
    int? id,
    Name? name,
    Rx<Gender?>? gender,
    Rx<MartialStatus?>? martial,
    IdentitfyCard? typeIdentity,
    String? datePirth,
    String? releaseDate,
  }) {
    return IdentityCustomers(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      martial: martial ?? this.martial,
      typeIdentity: typeIdentity ?? this.typeIdentity,
      datePirth: datePirth ?? this.datePirth,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name.toMap(),
      'gender': gender.value?.toMap(),
      'martial': martial.value?.toMap(),
      'typeIdentity': typeIdentity!.toMap(),
      'datePirth': datePirth,
      'releaseDate': releaseDate,
    };
  }

  String? get nameid {
    return '${name.frisName!} ${name.lastName} ${name.surName}';
  }

  String? get getGender {
    return gender.value!.nameAr;
  }

  String? get getMartiall {
    return martial.value!.nameAr;
  }

  factory IdentityCustomers.fromMap(Map<String, dynamic> map) {
    return IdentityCustomers(
      id: map['id'] != null ? map['id'] as int : null,
      name: Name.fromMap(map['name'] as Map<String, dynamic>),
      gender:
          Rx<Gender?>(Gender.fromMap(map['gender'] as Map<String, dynamic>)),
      martial: Rx<MartialStatus?>(
          MartialStatus.fromMap(map['martial'] as Map<String, dynamic>)),
      typeIdentity: map['typeIdentity'] != null
          ? IdentitfyCard.fromMap(map['typeIdentity'] as Map<String, dynamic>)
          : null,
      datePirth: map['datePirth'] != null ? map['datePirth'] as String : null,
      releaseDate:
          map['releaseDate'] != null ? map['releaseDate'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdentityCustomers.fromJson(String source) =>
      IdentityCustomers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IdentityCustomers(id: $id, name: $name, gender: $gender, martial: $martial, typeIdentity: $typeIdentity, datePirth: $datePirth, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(covariant IdentityCustomers other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.gender == gender &&
        other.martial == martial &&
        other.typeIdentity == typeIdentity &&
        other.datePirth == datePirth &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        martial.hashCode ^
        typeIdentity.hashCode ^
        datePirth.hashCode ^
        releaseDate.hashCode;
  }
}

class Name {
  String? frisName;
  String? lastName;
  String? surName;
  Name({
    this.frisName,
    this.lastName,
    this.surName,
  });

  Name copyWith({
    String? frisName,
    String? lastName,
    String? surName,
  }) {
    return Name(
      frisName: frisName ?? this.frisName,
      lastName: lastName ?? this.lastName,
      surName: surName ?? this.surName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'frisName': frisName,
      'lastName': lastName,
      'surName': surName,
    };
  }

  factory Name.fromMap(Map<String, dynamic> map) {
    return Name(
      frisName: map['frisName'] != null ? map['frisName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      surName: map['surName'] != null ? map['surName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Name.fromJson(String source) =>
      Name.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Name(frisName: $frisName, lastName: $lastName, surName: $surName)';

  @override
  bool operator ==(covariant Name other) {
    if (identical(this, other)) return true;

    return other.frisName == frisName &&
        other.lastName == lastName &&
        other.surName == surName;
  }

  String get getFullName {
    return frisName! + ' '.toString() + lastName! + ' '.toString() + surName!;
  }

  @override
  int get hashCode => frisName.hashCode ^ lastName.hashCode ^ surName.hashCode;
}
