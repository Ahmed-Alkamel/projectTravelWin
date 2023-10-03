// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StateRequest {
  int? id;
  String? name;
  StateRequest({
    this.id,
    this.name,
  });

  StateRequest copyWith({
    int? id,
    String? name,
  }) {
    return StateRequest(
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

  factory StateRequest.fromMap(Map<String, dynamic> map) {
    return StateRequest(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateRequest.fromJson(String source) =>
      StateRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StateRequest(id: $id, name: $name)';

  @override
  bool operator ==(covariant StateRequest other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
