// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'card.dart';

class Customer {
  int? id;
  String? fristName;
  String? lastName;
  String? nikName;
  IdentifyCard card;
  String? datePirth;
  String? placePirth;
  String? gender;
  String? numberPhone;
  String? dateReleas;
  String? dateExp;
  Customer({
    this.id,
    this.fristName,
    this.lastName,
    this.nikName,
    required this.card,
    this.datePirth,
    this.placePirth,
    this.gender,
    this.numberPhone,
    this.dateReleas,
    this.dateExp,
  });

  Customer copyWith({
    int? id,
    String? fristName,
    String? lastName,
    String? nikName,
    IdentifyCard? card,
    String? datePirth,
    String? placePirth,
    String? gender,
    String? numberPhone,
    String? dateReleas,
    String? dateExp,
  }) {
    return Customer(
      id: id ?? this.id,
      fristName: fristName ?? this.fristName,
      lastName: lastName ?? this.lastName,
      nikName: nikName ?? this.nikName,
      card: card ?? this.card,
      datePirth: datePirth ?? this.datePirth,
      placePirth: placePirth ?? this.placePirth,
      gender: gender ?? this.gender,
      numberPhone: numberPhone ?? this.numberPhone,
      dateReleas: dateReleas ?? this.dateReleas,
      dateExp: dateExp ?? this.dateExp,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fristName': fristName,
      'lastName': lastName,
      'nikName': nikName,
      'card': card.toMap(),
      'datePirth': datePirth,
      'placePirth': placePirth,
      'gender': gender,
      'numberPhone': numberPhone,
      'dateReleas': dateReleas,
      'dateExp': dateExp,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] != null ? map['id'] as int : null,
      fristName: map['fristName'] != null ? map['fristName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      nikName: map['nikName'] != null ? map['nikName'] as String : null,
      card: IdentifyCard.fromMap(map['card'] as Map<String, dynamic>),
      datePirth: map['datePirth'] != null ? map['datePirth'] as String : null,
      placePirth:
          map['placePirth'] != null ? map['placePirth'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      numberPhone:
          map['numberPhone'] != null ? map['numberPhone'] as String : null,
      dateReleas:
          map['dateReleas'] != null ? map['dateReleas'] as String : null,
      dateExp: map['dateExp'] != null ? map['dateExp'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Customer(id: $id, fristName: $fristName, lastName: $lastName, nikName: $nikName, card: $card, datePirth: $datePirth, placePirth: $placePirth, gender: $gender, numberPhone: $numberPhone, dateReleas: $dateReleas, dateExp: $dateExp)';
  }

  @override
  bool operator ==(covariant Customer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fristName == fristName &&
        other.lastName == lastName &&
        other.nikName == nikName &&
        other.card == card &&
        other.datePirth == datePirth &&
        other.placePirth == placePirth &&
        other.gender == gender &&
        other.numberPhone == numberPhone &&
        other.dateReleas == dateReleas &&
        other.dateExp == dateExp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fristName.hashCode ^
        lastName.hashCode ^
        nikName.hashCode ^
        card.hashCode ^
        datePirth.hashCode ^
        placePirth.hashCode ^
        gender.hashCode ^
        numberPhone.hashCode ^
        dateReleas.hashCode ^
        dateExp.hashCode;
  }
}
