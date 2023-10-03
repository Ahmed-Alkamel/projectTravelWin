// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'data_basic_add_trip.dart';

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'data_basic_add_trip.dart';

class DataBasicAddCompany {
  List<ServiceMine>? serviceMine;
  DataBasicAddCompany({
    this.serviceMine,
  });

  DataBasicAddCompany copyWith({
    List<ServiceMine>? serviceMine,
  }) {
    return DataBasicAddCompany(
      serviceMine: serviceMine ?? this.serviceMine,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'serviceMine': serviceMine?.map((x) => x.toMap()).toList(),
    };
  }

  factory DataBasicAddCompany.fromMap(Map<String, dynamic> map) {
    return DataBasicAddCompany(
      serviceMine: map['serviceMine'] != null
          ? List<ServiceMine>.from(
              (map['serviceMine'] as List<dynamic>).map<ServiceMine?>(
                (x) => ServiceMine.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataBasicAddCompany.fromJson(String source) =>
      DataBasicAddCompany.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'DataBasicAddCompany(serviceMine: $serviceMine)';

  @override
  bool operator ==(covariant DataBasicAddCompany other) {
    if (identical(this, other)) return true;

    return listEquals(other.serviceMine, serviceMine);
  }

  @override
  int get hashCode => serviceMine.hashCode;
}
