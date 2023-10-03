// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// import 'package:flutter/material.dart';

// class Trip {
//   int? id;
//   String fromCity;
//   String toCity;
//   DateTime goTime;
//   String lineTrip;
//   String companyTransport;
//   String level;
//   int avaiableNumber;
//   double price;
//   Trip({
//     this.id,
//     required this.fromCity,
//     required this.toCity,
//     required this.goTime,
//     required this.lineTrip,
//     required this.companyTransport,
//     required this.level,
//     required this.avaiableNumber,
//     required this.price,
//   });

//   Trip copyWith({
//     int? id,
//     String? fromCity,
//     String? toCity,
//     DateTime? goTime,
//     String? lineTrip,
//     String? companyTransport,
//     String? level,
//     int? avaiableNumber,
//     double? price,
//   }) {
//     return Trip(
//       id: id ?? this.id,
//       fromCity: fromCity ?? this.fromCity,
//       toCity: toCity ?? this.toCity,
//       goTime: goTime ?? this.goTime,
//       lineTrip: lineTrip ?? this.lineTrip,
//       companyTransport: companyTransport ?? this.companyTransport,
//       level: level ?? this.level,
//       avaiableNumber: avaiableNumber ?? this.avaiableNumber,
//       price: price ?? this.price,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'fromCity': fromCity,
//       'toCity': toCity,
//       'goTime': goTime.millisecondsSinceEpoch,
//       'lineTrip': lineTrip,
//       'companyTransport': companyTransport,
//       'level': level,
//       'avaiableNumber': avaiableNumber,
//       'price': price,
//     };
//   }

//   factory Trip.fromMap(Map<String, dynamic> map) {
//     return Trip(
//       id: map['id'] != null ? map['id'] as int : null,
//       fromCity: map['fromCity'] as String,
//       toCity: map['toCity'] as String,
//       goTime: DateTime.fromMillisecondsSinceEpoch(map['goTime'] as int),
//       lineTrip: map['lineTrip'] as String,
//       companyTransport: map['companyTransport'] as String,
//       level: map['level'] as String,
//       avaiableNumber: map['avaiableNumber'] as int,
//       price: map['price'] as double,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Trip.fromJson(String source) =>
//       Trip.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() {
//     return 'Trip(id: $id, fromCity: $fromCity, toCity: $toCity, goTime: $goTime, lineTrip: $lineTrip, companyTransport: $companyTransport, level: $level, avaiableNumber: $avaiableNumber, price: $price)';
//   }

//   @override
//   bool operator ==(covariant Trip other) {
//     if (identical(this, other)) return true;

//     return other.id == id &&
//         other.fromCity == fromCity &&
//         other.toCity == toCity &&
//         other.goTime == goTime &&
//         other.lineTrip == lineTrip &&
//         other.companyTransport == companyTransport &&
//         other.level == level &&
//         other.avaiableNumber == avaiableNumber &&
//         other.price == price;
//   }

//   @override
//   int get hashCode {
//     return id.hashCode ^
//         fromCity.hashCode ^
//         toCity.hashCode ^
//         goTime.hashCode ^
//         lineTrip.hashCode ^
//         companyTransport.hashCode ^
//         level.hashCode ^
//         avaiableNumber.hashCode ^
//         price.hashCode;
//   }
// }
