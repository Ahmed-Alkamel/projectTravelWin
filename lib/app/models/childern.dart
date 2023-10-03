// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Child {
  int? id;
  String? fristName;
  String? lastName;
  String? nikName;
  String? datePith;
  String? placePith;
  String? gender;
  Child({
    this.id,
    this.fristName,
    this.lastName,
    this.nikName,
    this.datePith,
    this.placePith,
    this.gender,
  });

  Child copyWith({
    int? id,
    String? fristName,
    String? lastName,
    String? nikName,
    String? datePith,
    String? placePith,
    String? gender,
  }) {
    return Child(
      id: id ?? this.id,
      fristName: fristName ?? this.fristName,
      lastName: lastName ?? this.lastName,
      nikName: nikName ?? this.nikName,
      datePith: datePith ?? this.datePith,
      placePith: placePith ?? this.placePith,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fristName': fristName,
      'lastName': lastName,
      'nikName': nikName,
      'datePith': datePith,
      'placePith': placePith,
      'gender': gender,
    };
  }

  factory Child.fromMap(Map<String, dynamic> map) {
    return Child(
      id: map['id'] != null ? map['id'] as int : null,
      fristName: map['fristName'] != null ? map['fristName'] as String : null,
      lastName: map['lastName'] != null ? map['lastName'] as String : null,
      nikName: map['nikName'] != null ? map['nikName'] as String : null,
      datePith: map['datePith'] != null ? map['datePith'] as String : null,
      placePith: map['placePith'] != null ? map['placePith'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Child.fromJson(String source) =>
      Child.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Child(id: $id, fristName: $fristName, lastName: $lastName, nikName: $nikName, datePith: $datePith, placePith: $placePith, gender: $gender)';
  }

  @override
  bool operator ==(covariant Child other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fristName == fristName &&
        other.lastName == lastName &&
        other.nikName == nikName &&
        other.datePith == datePith &&
        other.placePith == placePith &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fristName.hashCode ^
        lastName.hashCode ^
        nikName.hashCode ^
        datePith.hashCode ^
        placePith.hashCode ^
        gender.hashCode;
  }
}
