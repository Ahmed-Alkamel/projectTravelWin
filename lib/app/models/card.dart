// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class IdentifyCard {
  int id;
  String name;
  IdentifyCard({
    this.id = 0,
    this.name = '',
  });

  IdentifyCard copyWith({
    int? id,
    String? name,
  }) {
    return IdentifyCard(
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

  factory IdentifyCard.fromMap(Map<String, dynamic> map) {
    return IdentifyCard(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdentifyCard.fromJson(String source) =>
      IdentifyCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'IdentifyCard(id: $id, name: $name)';

  @override
  bool operator ==(covariant IdentifyCard other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
