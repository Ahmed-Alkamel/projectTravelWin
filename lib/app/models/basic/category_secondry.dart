import 'dart:convert';

class CategorySecondry {
  int? idSec;
  String? name;
  CategorySecondry({
    this.idSec,
    this.name,
  });

  CategorySecondry copyWith({
    int? idSec,
    String? name,
  }) {
    return CategorySecondry(
      idSec: idSec ?? this.idSec,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idSec': idSec,
      'name': name,
    };
  }

  factory CategorySecondry.fromMap(Map<String, dynamic> map) {
    return CategorySecondry(
      idSec: map['idSec'] != null ? map['idSec'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorySecondry.fromJson(String source) =>
      CategorySecondry.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategorySecondry(idSec: $idSec, name: $name)';

  @override
  bool operator ==(covariant CategorySecondry other) {
    if (identical(this, other)) return true;

    return other.idSec == idSec && other.name == name;
  }

  @override
  int get hashCode => idSec.hashCode ^ name.hashCode;
}
