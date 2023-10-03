import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class IdentitfyCard extends Equatable {
  int? id;
  String? name;
  RxBool isSelected = RxBool(false);
  IdentitfyCard({
    this.id,
    this.name,
  });

  IdentitfyCard copyWith({
    int? id,
    String? name,
  }) {
    return IdentitfyCard(
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

  factory IdentitfyCard.fromMap(Map<String, dynamic> map) {
    return IdentitfyCard(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdentitfyCard.fromJson(String source) =>
      IdentitfyCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IdentitfyCard(id: $id, name: $name)';

  @override
  bool operator ==(covariant IdentitfyCard other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  List<Object?> get props => [id, name];
}
