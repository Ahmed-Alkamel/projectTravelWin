// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'option_type_filed.dart';
import 'type_filed.dart';

class DetaialSubRequerment {
  int? id;
  String? containt;
  TypeFiled? typeFiled;
  List<OptionTypeFiled>? optionTypeFiled;
  DetaialSubRequerment({
    this.id,
    this.containt,
    this.typeFiled,
    this.optionTypeFiled,
  });

  DetaialSubRequerment copyWith({
    int? id,
    String? containt,
    TypeFiled? typeFiled,
    List<OptionTypeFiled>? optionTypeFiled,
  }) {
    return DetaialSubRequerment(
      id: id ?? this.id,
      containt: containt ?? this.containt,
      typeFiled: typeFiled ?? this.typeFiled,
      optionTypeFiled: optionTypeFiled ?? this.optionTypeFiled,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'containt': containt,
      'typeFiled': typeFiled?.toMap(),
      'optionTypeFiled': optionTypeFiled?.map((x) => x.toMap()).toList(),
    };
  }

  factory DetaialSubRequerment.fromMap(Map<String, dynamic> map) {
    return DetaialSubRequerment(
      id: map['id'] != null ? map['id'] as int : null,
      containt: map['containt'] != null ? map['containt'] as String : null,
      typeFiled: map['typeFiled'] != null
          ? TypeFiled.fromMap(map['typeFiled'] as Map<String, dynamic>)
          : null,
      optionTypeFiled: map['optionTypeFiled'] != null
          ? List<OptionTypeFiled>.from(
              (map['optionTypeFiled'] as List<dynamic>).map<OptionTypeFiled?>(
                (x) => OptionTypeFiled.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetaialSubRequerment.fromJson(String source) =>
      DetaialSubRequerment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DetaialSubRequerment(id: $id, containt: $containt, typeFiled: $typeFiled, optionTypeFiled: $optionTypeFiled)';
  }

  @override
  bool operator ==(covariant DetaialSubRequerment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.containt == containt &&
        other.typeFiled == typeFiled &&
        listEquals(other.optionTypeFiled, optionTypeFiled);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        containt.hashCode ^
        typeFiled.hashCode ^
        optionTypeFiled.hashCode;
  }
}
