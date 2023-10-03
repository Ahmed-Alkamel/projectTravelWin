// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'currencies.dart';

class ServiceDetails {
  int? idServiceDetail;
  double? priceService;
  Currencies? currencie;
  ServiceDetails({
    this.idServiceDetail,
    this.priceService,
    this.currencie,
  });

  ServiceDetails copyWith({
    int? idServiceDetail,
    double? priceService,
    Currencies? currencie,
  }) {
    return ServiceDetails(
      idServiceDetail: idServiceDetail ?? this.idServiceDetail,
      priceService: priceService ?? this.priceService,
      currencie: currencie ?? this.currencie,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idServiceDetail': idServiceDetail,
      'priceService': priceService,
      'currencie': currencie?.toMap(),
    };
  }

  factory ServiceDetails.fromMap(Map<String, dynamic> map) {
    return ServiceDetails(
      idServiceDetail:
          map['idServiceDetail'] != null ? map['idServiceDetail'] as int : null,
      priceService: map['priceService'] == null
          ? null
          : map['priceService'] is int
              ? map['priceService'].toDouble()
              : map['priceService'] as double,
      currencie: map['currencie'] != null
          ? Currencies.fromMap(map['currencie'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceDetails.fromJson(String source) =>
      ServiceDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ServiceDetails(idServiceDetail: $idServiceDetail, priceService: $priceService, currencie: $currencie)';

  @override
  bool operator ==(covariant ServiceDetails other) {
    if (identical(this, other)) return true;

    return other.idServiceDetail == idServiceDetail &&
        other.priceService == priceService &&
        other.currencie == currencie;
  }

  @override
  int get hashCode =>
      idServiceDetail.hashCode ^ priceService.hashCode ^ currencie.hashCode;
}
