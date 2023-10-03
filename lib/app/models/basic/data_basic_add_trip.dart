// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:projecttravelwin/app/models/basic/company.dart';
import 'package:projecttravelwin/app/models/basic/trips.dart';

import 'category.dart' as cat;
import 'country.dart';
import 'currencies.dart';

class DataBasicAddTripModel {
  bool state;
  String massege;
  DataBasicAddTrip? data;
  DataBasicAddTripModel({
    required this.state,
    required this.massege,
    this.data,
  });

  DataBasicAddTripModel copyWith({
    bool? state,
    String? massege,
    DataBasicAddTrip? data,
  }) {
    return DataBasicAddTripModel(
      state: state ?? this.state,
      massege: massege ?? this.massege,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'massege': massege,
      'data': data?.toMap(),
    };
  }

  factory DataBasicAddTripModel.fromMap(Map<String, dynamic> map) {
    return DataBasicAddTripModel(
      state: map['state'] as bool,
      massege: map['massege'] as String,
      data: map['data'] != null
          ? DataBasicAddTrip.fromMap(map['data'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataBasicAddTripModel.fromJson(String source) =>
      DataBasicAddTripModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DataBasicAddTripModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant DataBasicAddTripModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        other.data == data;
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}

class DataBasicAddTrip {
  List<Method>? methodScheduler;
  List<Day>? days;
  List<Company>? company;
  List<ServiceMine>? serviceMine;
  List<Countries>? countries;
  List<City>? cities;
  List<Currencies>? currencies;
  DataBasicAddTrip(
      {this.methodScheduler,
      this.days,
      this.company,
      this.serviceMine,
      this.countries,
      this.cities,
      this.currencies}) {
    methodScheduler ?? [];
    days ?? [];
    company ?? [];
    serviceMine ?? [];
    countries ?? [];
    cities ?? [];
    currencies ?? [];
  }

  DataBasicAddTrip copyWith(
      {List<Method>? methodScheduler,
      List<Day>? days,
      List<Company>? company,
      List<ServiceMine>? serviceMine,
      List<Countries>? countries,
      List<City>? cities,
      List<Currencies>? currencies}) {
    return DataBasicAddTrip(
        methodScheduler: methodScheduler ?? this.methodScheduler,
        days: days ?? this.days,
        company: company ?? this.company,
        serviceMine: serviceMine ?? this.serviceMine,
        countries: countries ?? this.countries,
        cities: cities ?? this.cities,
        currencies: currencies ?? this.currencies);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'methodScheduler': methodScheduler?.map((x) => x.toMap()).toList(),
      'days': days?.map((x) => x.toMap()).toList(),
      'company': company?.map((x) => x.toMap()).toList(),
      'serviceMine': serviceMine?.map((x) => x.toMap()).toList(),
      'countries': countries?.map((x) => x.toMap()).toList(),
      'cities': cities?.map((x) => x.toMap()).toList(),
      'currencies': currencies?.map((x) => x.toMap()).toList(),
    };
  }

  factory DataBasicAddTrip.fromMap(Map<String, dynamic> map) {
    return DataBasicAddTrip(
      methodScheduler: map['methodScheduler'] != null
          ? List<Method>.from(
              (map['methodScheduler'] as List<dynamic>).map<Method?>(
                (x) => Method.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      days: map['days'] != null
          ? List<Day>.from(
              (map['days'] as List<dynamic>).map<Day?>(
                (x) => Day.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      company: map['company'] != null
          ? List<Company>.from(
              (map['company'] as List<dynamic>).map<Company?>(
                (x) => Company.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      serviceMine: map['serviceMine'] != null
          ? List<ServiceMine>.from(
              (map['serviceMine'] as List<dynamic>).map<ServiceMine?>(
                (x) => ServiceMine.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      countries: map['countries'] != null
          ? List<Countries>.from(
              (map['countries'] as List<dynamic>).map<Countries?>(
                (x) => Countries.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      cities: map['cities'] != null
          ? List<City>.from(
              (map['cities'] as List<dynamic>).map<City?>(
                (x) => City.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      currencies: map['currencies'] != null
          ? List<Currencies>.from(
              (map['currencies'] as List<dynamic>).map<Currencies?>(
                (x) => Currencies.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataBasicAddTrip.fromJson(String source) =>
      DataBasicAddTrip.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataBasicAddTrip(methodScheduler: $methodScheduler, days: $days, company: $company, serviceMine: $serviceMine, countries: $countries, cities: $cities)';
  }

  @override
  bool operator ==(covariant DataBasicAddTrip other) {
    if (identical(this, other)) return true;

    return listEquals(other.methodScheduler, methodScheduler) &&
        listEquals(other.days, days) &&
        listEquals(other.company, company) &&
        listEquals(other.serviceMine, serviceMine) &&
        listEquals(other.countries, countries) &&
        listEquals(other.cities, cities);
  }

  @override
  int get hashCode {
    return methodScheduler.hashCode ^
        days.hashCode ^
        company.hashCode ^
        serviceMine.hashCode ^
        countries.hashCode ^
        cities.hashCode;
  }
}

class ServiceMine extends Equatable {
  int? idServ;
  cat.Category? category;
  String? name;
  ServiceMine({
    this.idServ,
    this.category,
    this.name,
  });

  ServiceMine copyWith({
    int? idServ,
    cat.Category? category,
    String? name,
  }) {
    return ServiceMine(
      idServ: idServ ?? this.idServ,
      category: category ?? this.category,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idServ': idServ,
      'category': category?.toMap(),
      'name': name,
    };
  }

  factory ServiceMine.fromMap(Map<String, dynamic> map) {
    return ServiceMine(
      idServ: map['idServ'] != null ? map['idServ'] as int : null,
      category: map['category'] != null
          ? cat.Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceMine.fromJson(String source) =>
      ServiceMine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ServiceMine(idServ: $idServ, category: $category, name: $name)';

  @override
  bool operator ==(covariant ServiceMine other) {
    if (identical(this, other)) return true;

    return other.idServ == idServ &&
        other.category == category &&
        other.name == name;
  }

  @override
  int get hashCode => idServ.hashCode ^ category.hashCode ^ name.hashCode;

  @override
  List<Object?> get props => [idServ, category, name];
}
