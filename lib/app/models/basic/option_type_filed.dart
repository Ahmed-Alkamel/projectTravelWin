// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OptionTypeFiled {
  int? id;
  String? value;
  OptionTypeFiled({
    this.id,
    this.value,
  });

  OptionTypeFiled copyWith({
    int? id,
    String? value,
  }) {
    return OptionTypeFiled(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
    };
  }

  factory OptionTypeFiled.fromMap(Map<String, dynamic> map) {
    return OptionTypeFiled(
      id: map['id'] != null ? map['id'] as int : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OptionTypeFiled.fromJson(String source) =>
      OptionTypeFiled.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'OptionTypeFiled(id: $id, value: $value)';

  @override
  bool operator ==(covariant OptionTypeFiled other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode;
}
