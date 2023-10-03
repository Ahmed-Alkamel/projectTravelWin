// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'type_filed.dart';

class MainRequirment {
  int? id;
  String? name;
  TypeFiled? typeFiled;
  List<Choose>? choose;
  String? containt;
  MainRequirment({
    this.id,
    this.name,
    this.typeFiled,
    this.choose,
    this.containt,
  }) {
    choose ?? [];
  }

  MainRequirment copyWith({
    int? id,
    String? name,
    TypeFiled? typeFiled,
    List<Choose>? choose,
    String? containt,
  }) {
    return MainRequirment(
      id: id ?? this.id,
      name: name ?? this.name,
      typeFiled: typeFiled ?? this.typeFiled,
      choose: choose ?? this.choose,
      containt: containt ?? this.containt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'typeFiled': typeFiled?.toMap(),
      'choose': choose?.map((x) => x.toMap()).toList(),
      'containt': containt,
    };
  }

  factory MainRequirment.fromMap(Map<String, dynamic> map) {
    return MainRequirment(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      typeFiled: map['typeFiled'] != null
          ? TypeFiled.fromMap(map['typeFiled'] as Map<String, dynamic>)
          : null,
      choose: map['choose'] != null
          ? List<Choose>.from(
              (map['choose'] as List<dynamic>).map<Choose?>(
                (x) => Choose.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      containt: map['containt'] != null ? map['containt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MainRequirment.fromJson(String source) =>
      MainRequirment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MainRequirment(id: $id, name: $name, typeFiled: $typeFiled, choose: $choose, containt: $containt)';
  }

  @override
  bool operator ==(covariant MainRequirment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.typeFiled == typeFiled &&
        listEquals(other.choose, choose) &&
        other.containt == containt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        typeFiled.hashCode ^
        choose.hashCode ^
        containt.hashCode;
  }
}

class SubRequirmentDetails {
  int? id;
  String? name;
  TypeFiled? typeFiled;
  List<ChooseSub>? choose;
  String? containt;
  SubRequirmentDetails({
    this.id,
    this.name,
    this.typeFiled,
    this.choose,
    this.containt,
  }) {
    choose = [];
  }

  SubRequirmentDetails copyWith({
    int? id,
    String? name,
    TypeFiled? typeFiled,
    List<ChooseSub>? choose,
    String? containt,
  }) {
    return SubRequirmentDetails(
      id: id ?? this.id,
      name: name ?? this.name,
      typeFiled: typeFiled ?? this.typeFiled,
      choose: choose ?? this.choose,
      containt: containt ?? this.containt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'typeFiled': typeFiled?.toMap(),
      'choose': choose?.map((x) => x.toMap()).toList(),
      'containt': containt,
    };
  }

  factory SubRequirmentDetails.fromMap(Map<String, dynamic> map) {
    return SubRequirmentDetails(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      typeFiled: map['typeFiled'] != null
          ? TypeFiled.fromMap(map['typeFiled'] as Map<String, dynamic>)
          : null,
      choose: map['choose'] != null
          ? List<ChooseSub>.from(
              (map['choose'] as List<dynamic>).map<ChooseSub?>(
                (x) => ChooseSub.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      containt: map['containt'] != null ? map['containt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubRequirmentDetails.fromJson(String source) =>
      SubRequirmentDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubRequirmentDetails(id: $id, name: $name, typeFiled: $typeFiled, choose: $choose, containt: $containt)';
  }

  @override
  bool operator ==(covariant SubRequirmentDetails other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.typeFiled == typeFiled &&
        listEquals(other.choose, choose) &&
        other.containt == containt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        typeFiled.hashCode ^
        choose.hashCode ^
        containt.hashCode;
  }
}
