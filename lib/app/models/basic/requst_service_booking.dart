// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'identity_customers.dart';
import 'main_requiremnt.dart';

// class CutomerRequestModel {
//   RequestServicePublic requestServicePublic;

//   CutomerRequestModel({
//     required this.requestServicePublic,
//   });
// }

class RequestServicePublic {
  int idServicesBooking;
  int idCustomerRequsts;
  DateTime? bookingServicesDate;
  String? dateEndDurtion;
  List<InfoBookingService>? infoBookingService;
  RequestServicePublic({
    required this.idServicesBooking,
    required this.idCustomerRequsts,
    this.bookingServicesDate,
    this.dateEndDurtion,
    this.infoBookingService,
  });

  RequestServicePublic copyWith({
    int? idServicesBooking,
    int? idCustomerRequsts,
    DateTime? bookingServicesDate,
    String? dateEndDurtion,
    List<InfoBookingService>? infoBookingService,
  }) {
    return RequestServicePublic(
      idServicesBooking: idServicesBooking ?? this.idServicesBooking,
      idCustomerRequsts: idCustomerRequsts ?? this.idCustomerRequsts,
      bookingServicesDate: bookingServicesDate ?? this.bookingServicesDate,
      dateEndDurtion: dateEndDurtion ?? this.dateEndDurtion,
      infoBookingService: infoBookingService ?? this.infoBookingService,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idServicesBooking': idServicesBooking,
      'idCustomerRequsts': idCustomerRequsts,
      'bookingServicesDate': bookingServicesDate?.millisecondsSinceEpoch,
      'dateEndDurtion': dateEndDurtion,
      'infoBookingService': infoBookingService?.map((x) => x.toMap()).toList(),
    };
  }

  factory RequestServicePublic.fromMap(Map<String, dynamic> map) {
    return RequestServicePublic(
      idServicesBooking: map['idServicesBooking'] as int,
      idCustomerRequsts: map['idCustomerRequsts'] as int,
      bookingServicesDate: map['bookingServicesDate'] != null
          ? DateTime.tryParse(map['bookingServicesDate'] as String)
          : null,
      dateEndDurtion: map['dateEndDurtion'] != null
          ? map['dateEndDurtion'] as String
          : null,
      infoBookingService: map['infoBookingService'] != null
          ? List<InfoBookingService>.from(
              (map['infoBookingService'] as List<dynamic>)
                  .map<InfoBookingService?>(
                (x) => InfoBookingService.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestServicePublic.fromJson(String source) =>
      RequestServicePublic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestServicePublic(idServicesBooking: $idServicesBooking, idCustomerRequsts: $idCustomerRequsts, bookingServicesDate: $bookingServicesDate, dateEndDurtion: $dateEndDurtion, infoBookingService: $infoBookingService)';
  }

  @override
  bool operator ==(covariant RequestServicePublic other) {
    if (identical(this, other)) return true;

    return other.idServicesBooking == idServicesBooking &&
        other.idCustomerRequsts == idCustomerRequsts &&
        other.bookingServicesDate == bookingServicesDate &&
        other.dateEndDurtion == dateEndDurtion &&
        listEquals(other.infoBookingService, infoBookingService);
  }

  @override
  int get hashCode {
    return idServicesBooking.hashCode ^
        idCustomerRequsts.hashCode ^
        bookingServicesDate.hashCode ^
        dateEndDurtion.hashCode ^
        infoBookingService.hashCode;
  }
}

class InfoBookingService {
  int idServiceBookDetails;
  int idServicesBooking;
  IdentityCustomers? person;
  List<DataInputRequrment>? dataInputRequrment;
  InfoBookingService({
    required this.idServiceBookDetails,
    required this.idServicesBooking,
    this.person,
    this.dataInputRequrment,
  });

  InfoBookingService copyWith({
    int? idServiceBookDetails,
    int? idServicesBooking,
    IdentityCustomers? person,
    List<DataInputRequrment>? dataInputRequrment,
  }) {
    return InfoBookingService(
      idServiceBookDetails: idServiceBookDetails ?? this.idServiceBookDetails,
      idServicesBooking: idServicesBooking ?? this.idServicesBooking,
      person: person ?? this.person,
      dataInputRequrment: dataInputRequrment ?? this.dataInputRequrment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idServiceBookDetails': idServiceBookDetails,
      'idServicesBooking': idServicesBooking,
      'person': person?.toMap(),
      'dataInputRequrment': dataInputRequrment?.map((x) => x.toMap()).toList(),
    };
  }

  factory InfoBookingService.fromMap(Map<String, dynamic> map) {
    return InfoBookingService(
      idServiceBookDetails: map['idServiceBookDetails'] as int,
      idServicesBooking: map['idServicesBooking'] as int,
      person: map['person'] != null
          ? IdentityCustomers.fromMap(map['person'] as Map<String, dynamic>)
          : null,
      dataInputRequrment: map['dataInputRequrment'] != null
          ? List<DataInputRequrment>.from(
              (map['dataInputRequrment'] as List<dynamic>)
                  .map<DataInputRequrment?>(
                (x) => DataInputRequrment.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoBookingService.fromJson(String source) =>
      InfoBookingService.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InfoBookingService(idServiceBookDetails: $idServiceBookDetails, idServicesBooking: $idServicesBooking, person: $person, dataInputRequrment: $dataInputRequrment)';
  }

  @override
  bool operator ==(covariant InfoBookingService other) {
    if (identical(this, other)) return true;

    return other.idServiceBookDetails == idServiceBookDetails &&
        other.idServicesBooking == idServicesBooking &&
        other.person == person &&
        listEquals(other.dataInputRequrment, dataInputRequrment);
  }

  @override
  int get hashCode {
    return idServiceBookDetails.hashCode ^
        idServicesBooking.hashCode ^
        person.hashCode ^
        dataInputRequrment.hashCode;
  }
}

class DataInputRequrment {
  int? id;
  int? idprim;
  MainRequirment? mainRequire;
  SubRequirmentDetails? subReqDetail;
  String? textValue;
  int? idTypeFiled;
  String? urlFile;
  int? idChoice;
  StateRequiremnt? stateOfRequiremnt;
  DataInputRequrment({
    this.id,
    this.idprim,
    this.mainRequire,
    this.subReqDetail,
    this.textValue,
    this.idTypeFiled,
    this.urlFile,
    this.idChoice,
    this.stateOfRequiremnt,
  });

  DataInputRequrment copyWith({
    int? id,
    MainRequirment? mainRequire,
    SubRequirmentDetails? subReqDetail,
    String? textValue,
    int? idTypeFiled,
    int? idprim,
    String? urlFile,
    int? idChoice,
    StateRequiremnt? stateOfRequiremnt,
  }) {
    return DataInputRequrment(
        id: id ?? this.id,
        mainRequire: mainRequire ?? this.mainRequire,
        subReqDetail: subReqDetail ?? this.subReqDetail,
        textValue: textValue ?? this.textValue,
        idTypeFiled: idTypeFiled ?? this.idTypeFiled,
        urlFile: urlFile ?? this.urlFile,
        idChoice: idChoice ?? this.idChoice,
        stateOfRequiremnt: stateOfRequiremnt ?? this.stateOfRequiremnt,
        idprim: idprim ?? this.idprim);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idprim': idprim,
      'mainRequire': mainRequire?.toMap(),
      'subReqDetail': subReqDetail?.toMap(),
      'textValue': textValue,
      'idTypeFiled': idTypeFiled,
      'urlFile': urlFile,
      'idChoice': idChoice,
      'stateOfRequiremnt': stateOfRequiremnt?.toMap(),
    };
  }

  Map<String, dynamic> toMapedit() {
    return <String, dynamic>{
      'id': idprim,
      'stateOfRequiremnt': stateOfRequiremnt?.toMap(),
    };
  }

  factory DataInputRequrment.fromMap(Map<String, dynamic> map) {
    return DataInputRequrment(
      id: map['id'] != null ? map['id'] as int : null,
      idprim: map['idprim'] != null ? map['idprim'] as int : null,
      mainRequire: map['mainRequire'] != null
          ? MainRequirment.fromMap(map['mainRequire'] as Map<String, dynamic>)
          : null,
      subReqDetail: map['subReqDetail'] != null
          ? SubRequirmentDetails.fromMap(
              map['subReqDetail'] as Map<String, dynamic>)
          : null,
      textValue: map['textValue'] != null ? map['textValue'] as String : null,
      idTypeFiled:
          map['idTypeFiled'] != null ? map['idTypeFiled'] as int : null,
      urlFile: map['urlFile'] != null ? map['urlFile'] as String : null,
      idChoice: map['idChoice'] != null ? map['idChoice'] as int : null,
      stateOfRequiremnt: map['stateOfRequiremnt'] != null
          ? StateRequiremnt.fromMap(
              map['stateOfRequiremnt'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataInputRequrment.fromJson(String source) =>
      DataInputRequrment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DataInputRequrment(id: $id,$idprim, mainRequire: $mainRequire, subReqDetail: $subReqDetail, textValue: $textValue, idTypeFiled: $idTypeFiled, urlFile: $urlFile, idChoice: $idChoice, stateOfRequiremnt: $stateOfRequiremnt)';
  }

  @override
  bool operator ==(covariant DataInputRequrment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idprim == idprim &&
        other.mainRequire == mainRequire &&
        other.subReqDetail == subReqDetail &&
        other.textValue == textValue &&
        other.idTypeFiled == idTypeFiled &&
        other.urlFile == urlFile &&
        other.idChoice == idChoice &&
        other.stateOfRequiremnt == stateOfRequiremnt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        mainRequire.hashCode ^
        subReqDetail.hashCode ^
        textValue.hashCode ^
        idTypeFiled.hashCode ^
        urlFile.hashCode ^
        idChoice.hashCode ^
        idprim.hashCode ^
        stateOfRequiremnt.hashCode;
  }
}

class StateRequiremnt {
  int? id;
  String? name;
  StateRequiremnt({
    this.id,
    this.name,
  });

  StateRequiremnt copyWith({
    int? id,
    String? name,
  }) {
    return StateRequiremnt(
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

  factory StateRequiremnt.fromMap(Map<String, dynamic> map) {
    return StateRequiremnt(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateRequiremnt.fromJson(String source) =>
      StateRequiremnt.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StateRequiremnt(id: $id, name: $name)';

  @override
  bool operator ==(covariant StateRequiremnt other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}
