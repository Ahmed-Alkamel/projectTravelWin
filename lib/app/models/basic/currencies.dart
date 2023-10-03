// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Currencies {
  int? id;
  String? name;
  String? codeAr;
  String? codeEn;
  double? conversionRate;
  bool? isDefaulte;
  DateTime? timeUpdate;
  DateTime? timeAdd;
  Currencies({
    this.id,
    this.name,
    this.codeAr,
    this.codeEn,
    this.conversionRate,
    this.isDefaulte,
    this.timeUpdate,
    this.timeAdd,
  });

  Currencies copyWith({
    int? id,
    String? name,
    String? codeAr,
    String? codeEn,
    double? conversionRate,
    bool? isDefaulte,
    DateTime? timeUpdate,
    DateTime? timeAdd,
  }) {
    return Currencies(
      id: id ?? this.id,
      name: name ?? this.name,
      codeAr: codeAr ?? this.codeAr,
      codeEn: codeEn ?? this.codeEn,
      conversionRate: conversionRate ?? this.conversionRate,
      isDefaulte: isDefaulte ?? this.isDefaulte,
      timeUpdate: timeUpdate ?? this.timeUpdate,
      timeAdd: timeAdd ?? this.timeAdd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'codeAr': codeAr,
      'codeEn': codeEn,
      'conversionRate': conversionRate,
      'isDefaulte': isDefaulte,
      'timeUpdate': timeUpdate?.millisecondsSinceEpoch,
      'timeAdd': timeAdd?.millisecondsSinceEpoch,
    };
  }

  factory Currencies.fromMap(Map<String, dynamic> map) {
    return Currencies(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      codeAr: map['codeAr'] != null ? map['codeAr'] as String : null,
      codeEn: map['codeEn'] != null ? map['codeEn'] as String : null,
      conversionRate: map['conversionRate'] == null
          ? null
          : map['conversionRate'] is int
              ? map['conversionRate'].toDouble()
              : map['conversionRate'] as double,
      isDefaulte: map['isDefaulte'] != null ? map['isDefaulte'] as bool : null,
      timeUpdate: map['timeUpdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeUpdate'] as int)
          : null,
      timeAdd: map['timeAdd'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeAdd'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Currencies.fromJson(String source) =>
      Currencies.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Currencies(id: $id, name: $name, codeAr: $codeAr, codeEn: $codeEn, conversionRate: $conversionRate, isDefaulte: $isDefaulte, timeUpdate: $timeUpdate, timeAdd: $timeAdd)';
  }

  @override
  bool operator ==(covariant Currencies other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.codeAr == codeAr &&
        other.codeEn == codeEn &&
        other.conversionRate == conversionRate &&
        other.isDefaulte == isDefaulte &&
        other.timeUpdate == timeUpdate &&
        other.timeAdd == timeAdd;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        codeAr.hashCode ^
        codeEn.hashCode ^
        conversionRate.hashCode ^
        isDefaulte.hashCode ^
        timeUpdate.hashCode ^
        timeAdd.hashCode;
  }
}
