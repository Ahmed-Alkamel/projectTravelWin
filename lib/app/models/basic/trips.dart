// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'category.dart' as cat;
import 'company.dart';
import 'currencies.dart';

class TripsModel {
  bool state;
  String? message;
  List<Trips>? data;
  TripsModel({
    required this.state,
    this.message,
    this.data,
  });

  TripsModel copyWith({
    bool? state,
    String? message,
    List<Trips>? data,
  }) {
    return TripsModel(
      state: state ?? this.state,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory TripsModel.fromMap(Map<String, dynamic> map) {
    return TripsModel(
      state: map['state'] as bool,
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? List<Trips>.from(
              (map['data'] as List<dynamic>).map<Trips?>(
                (x) => Trips.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TripsModel.fromJson(String source) =>
      TripsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TripsModel(state: $state, message: $message, data: $data)';

  @override
  bool operator ==(covariant TripsModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ message.hashCode ^ data.hashCode;
}

class Trips extends Equatable {
  int? idTrips;
  Company? company;
  int? idService;
  cat.Category? category;
  String? level;
  double? price;
  Scheduler? scheduler;
  DateTime? dateGo;

  Currencies? currencie;
  DateTime? dateBack;
  TimeOfDay? timeLeave;
  City? fromCity;
  City? toCity;
  Trips({
    this.idTrips,
    this.company,
    this.idService,
    this.category,
    this.level,
    this.price,
    this.scheduler,
    this.currencie,
    this.dateGo,
    this.dateBack,
    this.timeLeave,
    this.fromCity,
    this.toCity,
  }) {
    scheduler ??= Scheduler();
  }
  String? get getDateGo {
    if (dateGo != null) {
      return '${dateGo!.day} - ${dateGo!.month} - ${dateGo!.year}';
    } else {
      return null;
    }
  }

  Trips copyWith({
    int? idTrips,
    Company? company,
    int? idService,
    cat.Category? category,
    String? level,
    double? price,
    Scheduler? scheduler,
    DateTime? dateGo,
    DateTime? dateBack,
    TimeOfDay? timeLeave,
    Currencies? currencie,
    City? fromCity,
    City? toCity,
  }) {
    return Trips(
        idTrips: idTrips ?? this.idTrips,
        company: company ?? this.company,
        idService: idService ?? this.idService,
        category: category ?? this.category,
        level: level ?? this.level,
        price: price ?? this.price,
        scheduler: scheduler ?? this.scheduler,
        dateGo: dateGo ?? this.dateGo,
        dateBack: dateBack ?? this.dateBack,
        timeLeave: timeLeave ?? this.timeLeave,
        fromCity: fromCity ?? this.fromCity,
        toCity: toCity ?? this.toCity,
        currencie: currencie ?? this.currencie);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idTrips': idTrips,
      'company': company?.toMap(),
      'idService': idService,
      'category': category?.toMap(),
      'level': level,
      'price': price,
      'scheduler': scheduler?.toMap(),
      'dateGo': dateGo?.millisecondsSinceEpoch,
      'dateBack': dateBack?.millisecondsSinceEpoch,
      'timeLeave': DateFormat.Hms('en')
          .format(DateTime(2023, 1, 1, timeLeave!.hour, timeLeave!.minute)),
      'fromCity': fromCity?.toMap(),
      'toCity': toCity?.toMap(),
      'currencie': currencie?.toMap()
    };
  }

  factory Trips.fromMap(Map<String, dynamic> map) {
    return Trips(
      idTrips: map['idTrips'] != null ? map['idTrips'] as int : null,
      company: map['company'] != null
          ? Company.fromMap(map['company'] as Map<String, dynamic>)
          : null,
      idService: map['idService'] != null ? map['idService'] as int : null,
      category: map['category'] != null
          ? cat.Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      level: map['level'] != null ? map['level'] as String : null,
      price: map['price'] != null
          ? map['price'] is int
              ? map['price'].toDouble()
              : map['price'] as double
          : null,
      scheduler: map['scheduler'] != null
          ? Scheduler.fromMap(map['scheduler'] as Map<String, dynamic>)
          : null,
      dateGo: map['dateGo'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateGo'] as int)
          : null,
      dateBack: map['dateBack'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateBack'] as int)
          : null,
      timeLeave: map['timeLeave'] != null
          ? TimeOfDay.fromDateTime(
              DateTime.tryParse('2023-05-05 '.toString() + map['timeLeave'])!)
          : null,
      fromCity: map['fromCity'] != null
          ? City.fromMap(map['fromCity'] as Map<String, dynamic>)
          : null,
      toCity: map['toCity'] != null
          ? City.fromMap(map['toCity'] as Map<String, dynamic>)
          : null,
      currencie: map['currencie'] != null
          ? Currencies.fromMap(map['currencie'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Trips.fromJson(String source) =>
      Trips.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Trips(idTrips: $idTrips, company: $company, idService: $idService, category: $category, level: $level, price: $price, scheduler: $scheduler, dateGo: $dateGo, dateBack: $dateBack, timeLeave: $timeLeave, fromCity: $fromCity, toCity: $toCity)';
  }

  // @override
  // bool operator ==(covariant Trips other) {
  //   if (identical(this, other)) return true;

  //   return other.idTrips == idTrips &&
  //       other.company == company &&
  //       other.idService == idService &&
  //       other.category == category &&
  //       other.level == level &&
  //       other.price == price &&
  //       other.scheduler == scheduler &&
  //       other.dateGo == dateGo &&
  //       other.dateBack == dateBack &&
  //       other.timeLeave == timeLeave &&
  //       other.fromCity == fromCity &&
  //       other.toCity == toCity;
  // }

  @override
  int get hashCode {
    return idTrips.hashCode ^
        company.hashCode ^
        idService.hashCode ^
        category.hashCode ^
        level.hashCode ^
        price.hashCode ^
        scheduler.hashCode ^
        dateGo.hashCode ^
        dateBack.hashCode ^
        timeLeave.hashCode ^
        fromCity.hashCode ^
        toCity.hashCode;
  }

  @override
  List<Object?> get props => [
        idTrips,
      ];
}

class SubCategory {
  int idSec;
  String name;
  SubCategory({
    required this.idSec,
    required this.name,
  });

  SubCategory copyWith({
    int? idSec,
    String? name,
  }) {
    return SubCategory(
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

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      idSec: map['idSec'] as int,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategory.fromJson(String source) =>
      SubCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SubCategory(idSec: $idSec, name: $name)';

  @override
  bool operator ==(covariant SubCategory other) {
    if (identical(this, other)) return true;

    return other.idSec == idSec && other.name == name;
  }

  @override
  int get hashCode => idSec.hashCode ^ name.hashCode;
}

class SubService {
  int id;
  bool isInternal;
  String name;
  SubCategory category;
  SubService({
    required this.id,
    required this.isInternal,
    required this.name,
    required this.category,
  });

  SubService copyWith({
    int? id,
    bool? isInternal,
    String? name,
    SubCategory? category,
  }) {
    return SubService(
      id: id ?? this.id,
      isInternal: isInternal ?? this.isInternal,
      name: name ?? this.name,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'isInternal': isInternal,
      'name': name,
      'category': category.toMap(),
    };
  }

  factory SubService.fromMap(Map<String, dynamic> map) {
    return SubService(
      id: map['id'] as int,
      isInternal: map['isInternal'] as bool,
      name: map['name'] as String,
      category: SubCategory.fromMap(map['category'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubService.fromJson(String source) =>
      SubService.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubService(id: $id, isInternal: $isInternal, name: $name, category: $category)';
  }

  @override
  bool operator ==(covariant SubService other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.isInternal == isInternal &&
        other.name == name &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        isInternal.hashCode ^
        name.hashCode ^
        category.hashCode;
  }
}

class City extends Equatable {
  int? id;
  int? idCountry;
  String? name;
  bool? isFrom;
  City({this.id, this.idCountry, this.name, this.isFrom});

  City copyWith({
    int? id,
    int? idCountry,
    String? name,
  }) {
    return City(
      id: id ?? this.id,
      idCountry: idCountry ?? this.idCountry,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idCountry': idCountry,
      'name': name,
    };
  }

  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      id: map['id'] != null ? map['id'] as int : null,
      idCountry: map['idCountry'] != null ? map['idCountry'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory City.fromJson(String source) =>
      City.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'City(id: $id, idCountry: $idCountry, name: $name)';

  @override
  int get hashCode => id.hashCode ^ idCountry.hashCode ^ name.hashCode;

  @override
  List<Object?> get props => [id, idCountry, name];
}

class Scheduler {
  int? idScheduler;
  Method? method;
  int? idTrips;
  int? atCount;
  List<Day>? days;
  String? time;
  Scheduler({
    this.idScheduler,
    this.method,
    this.idTrips,
    this.atCount,
    this.days,
    this.time,
  }) {
    days ??= [];
  }

  Scheduler copyWith({
    int? idScheduler,
    Method? method,
    int? idTrips,
    int? atCount,
    List<Day>? days,
    String? time,
  }) {
    return Scheduler(
      idScheduler: idScheduler ?? this.idScheduler,
      method: method ?? this.method,
      idTrips: idTrips ?? this.idTrips,
      atCount: atCount ?? this.atCount,
      days: days ?? this.days,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idScheduler': idScheduler,
      'method': method?.toMap(),
      'idTrips': idTrips,
      'atCount': atCount,
      'days': days?.map((x) => x.toMap()).toList(),
      'time': time,
    };
  }

  factory Scheduler.fromMap(Map<String, dynamic> map) {
    return Scheduler(
      idScheduler:
          map['idScheduler'] != null ? map['idScheduler'] as int : null,
      method: map['method'] != null
          ? Method.fromMap(map['method'] as Map<String, dynamic>)
          : null,
      idTrips: map['idTrips'] != null ? map['idTrips'] as int : null,
      atCount: map['atCount'] != null ? map['atCount'] as int : null,
      days: map['days'] != null
          ? List<Day>.from(
              (map['days'] as List<dynamic>).map<Day?>(
                (x) => Day.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      time: map['time'] != null ? map['time'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Scheduler.fromJson(String source) =>
      Scheduler.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Scheduler(idScheduler: $idScheduler, method: $method, idTrips: $idTrips, atCount: $atCount, days: $days, time: $time)';
  }

  @override
  bool operator ==(covariant Scheduler other) {
    if (identical(this, other)) return true;

    return other.idScheduler == idScheduler &&
        other.method == method &&
        other.idTrips == idTrips &&
        other.atCount == atCount &&
        listEquals(other.days, days) &&
        other.time == time;
  }

  @override
  int get hashCode {
    return idScheduler.hashCode ^
        method.hashCode ^
        idTrips.hashCode ^
        atCount.hashCode ^
        days.hashCode ^
        time.hashCode;
  }
}

class Day extends Equatable {
  int? id;
  String? name;
  Day({
    this.id,
    this.name,
  });

  Day copyWith({
    int? id,
    String? name,
  }) {
    return Day(
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

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Day.fromJson(String source) =>
      Day.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Day(id: $id, name: $name)';

  @override
  bool operator ==(covariant Day other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  List<Object?> get props => [id, name];
}

class Method {
  int? id;
  String? name;
  bool? isActive;
  Method({
    this.id,
    this.name,
    this.isActive,
  });

  Method copyWith({
    int? id,
    String? name,
    bool? isActive,
  }) {
    return Method(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'isActive': isActive,
    };
  }

  factory Method.fromMap(Map<String, dynamic> map) {
    return Method(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Method.fromJson(String source) =>
      Method.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Method(id: $id, name: $name, isActive: $isActive)';

  @override
  bool operator ==(covariant Method other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.isActive == isActive;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isActive.hashCode;
}
