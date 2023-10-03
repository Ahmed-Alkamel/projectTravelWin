// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import './type_filed.dart';


import 'identity_customers.dart';
import 'sub_requiremnt.dart';

class RequestServices {
  IdentityCustomers identityCustomers;
  int? idCust;
  int? idServ;
  int? idPlan;
  List<TripHelperBooking>? dataTrip;
  Rxn<SubRequiremnt>? subRequiremnt = Rxn<SubRequiremnt>();
  List<RequestServicesMainDetails>? detailsMain;
  List<RequestServicesMainDetails>? detailsSub;

  int getLengthDetailsSubReq() {
    if (subRequiremnt!.value == null) {
      return 0;
    } else {
      if (subRequiremnt!.value!.detaial == null) {
        return 0;
      } else {
        return subRequiremnt!.value!.detaial!.length;
      }
    }
  }

  RequestServices(
      {required this.identityCustomers,
      this.idCust,
      this.idServ,
      this.idPlan,
      this.dataTrip,
      this.subRequiremnt,
      this.detailsMain,
      this.detailsSub});

  RequestServices copyWith({
    IdentityCustomers? identityCustomers,
    int? idCust,
    int? idServ,
    int? idPlan,
    List<TripHelperBooking>? dataTrip,
    Rxn<SubRequiremnt>? subRequiremnt,
    List<RequestServicesMainDetails>? detailsMain,
    List<RequestServicesMainDetails>? detailsSub,
  }) {
    return RequestServices(
      subRequiremnt: subRequiremnt ?? this.subRequiremnt,
      identityCustomers: identityCustomers ?? this.identityCustomers,
      idCust: idCust ?? this.idCust,
      idServ: idServ ?? this.idServ,
      dataTrip: dataTrip ?? this.dataTrip,
      idPlan: idPlan ?? this.idPlan,
      detailsMain: detailsMain ?? this.detailsMain,
      detailsSub: detailsSub ?? this.detailsSub,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'identityCustomers': identityCustomers.toMap(),
      'idCust': idCust,
      'idServ': idServ,
      'dataTrip': dataTrip?.map((e) => e.toMap()).toList(),
      'idPlan': idPlan,
      'detailsMain': detailsMain?.map((x) => x.toMap()).toList(),
      'detailsSub': detailsSub?.map((x) => x.toMap()).toList(),
    };
  }

  Map<String, dynamic> toMapToServer() {
    return <String, dynamic>{
      'identityCustomers': identityCustomers.toMap(),
      'idCust': idCust,
      'idServ': idServ,
      'dataTrip': dataTrip?.map((e) => e.toMap()).toList(),
      'idPlan': idPlan,
      'detailsMain': detailsMain?.map((x) {
        return x.toMapWithFileServer();
      }).toList(),
      'detailsSub': detailsSub?.map((x) {
        return x.toMapWithFileServer();
      }).toList(),
    };
  }

  factory RequestServices.fromMap(Map<String, dynamic> map) {
    return RequestServices(
      // subRequiremnt:  Rxn<SubRequiremnt>(null),
      identityCustomers: IdentityCustomers.fromMap(
          map['identityCustomers'] as Map<String, dynamic>),
      idCust: map['idCust'] != null ? map['idCust'] as int : null,
      idServ: map['idServ'] != null ? map['idServ'] as int : null,
      idPlan: map['idPlan'] != null ? map['idPlan'] as int : null,
      dataTrip: map['dataTrip'] != null
          ? List<TripHelperBooking>.from(
              (map['dataTrip'] as List<dynamic>).map<TripHelperBooking?>(
                (x) => TripHelperBooking.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      detailsMain: map['details'] != null
          ? List<RequestServicesMainDetails>.from(
              (map['details'] as List<dynamic>)
                  .map<RequestServicesMainDetails?>(
                (x) => RequestServicesMainDetails.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
      detailsSub: map['details'] != null
          ? List<RequestServicesMainDetails>.from(
              (map['details'] as List<dynamic>)
                  .map<RequestServicesMainDetails?>(
                (x) => RequestServicesMainDetails.fromMap(
                    x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestServices.fromJson(String source) =>
      RequestServices.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestServices(identityCustomers: $identityCustomers, idCust: $idCust, idServ: $idServ, idTrip: $dataTrip, detailsMain: $detailsMain)';
  }

  @override
  bool operator ==(covariant RequestServices other) {
    if (identical(this, other)) return true;

    return other.identityCustomers == identityCustomers &&
        other.idCust == idCust &&
        other.idServ == idServ &&
        other.dataTrip == dataTrip &&
        listEquals(other.detailsSub, detailsSub) &&
        listEquals(other.detailsMain, detailsMain);
  }

  @override
  int get hashCode {
    return identityCustomers.hashCode ^
        idCust.hashCode ^
        idServ.hashCode ^
        dataTrip.hashCode ^
        detailsSub.hashCode ^
        detailsMain.hashCode;
  }
}

class RequestServicesModelSend {
  List<RequestServices>? data;
  RequestServicesModelSend({
    this.data,
  });

  RequestServicesModelSend copyWith({
    List<RequestServices>? data,
  }) {
    return RequestServicesModelSend(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.map((x) {
        return x.toMapToServer();
      }).toList(),
    };
  }

  factory RequestServicesModelSend.fromMap(Map<String, dynamic> map) {
    return RequestServicesModelSend(
      data: map['data'] != null
          ? List<RequestServices>.from(
              (map['data'] as List<dynamic>).map<RequestServices?>(
                (x) => RequestServices.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  Future<String> toJson() async {
    return json.encode(toMap());
  }

  factory RequestServicesModelSend.fromJson(String source) =>
      RequestServicesModelSend.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RequestServicesModelSend(data: $data)';

  @override
  bool operator ==(covariant RequestServicesModelSend other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}

class RequestServicesSubDetails {
  int? idSubReqDetail;

  String? textValue;
  int? idTypeFiled;
  String? urlFile;
  Rx<Choose?> choice;

  int? stateOfRequiremnt;
  RequestServicesSubDetails({
    this.idSubReqDetail,
    this.textValue,
    this.idTypeFiled,
    this.urlFile,
    required this.choice,
    this.stateOfRequiremnt,
  });

  RequestServicesSubDetails copyWith({
    int? idSubReqDetail,
    String? textValue,
    int? idTypeFiled,
    String? urlFile,
    Rx<Choose?>? choice,
    int? stateOfRequiremnt,
  }) {
    return RequestServicesSubDetails(
      idSubReqDetail: idSubReqDetail ?? this.idSubReqDetail,
      textValue: textValue ?? this.textValue,
      idTypeFiled: idTypeFiled ?? this.idTypeFiled,
      urlFile: urlFile ?? this.urlFile,
      choice: choice ?? this.choice,
      stateOfRequiremnt: stateOfRequiremnt ?? this.stateOfRequiremnt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idSubReqDetail': idSubReqDetail,
      'textValue': textValue,
      'idTypeFiled': idTypeFiled,
      'urlFile': urlFile,
      'choice': choice.value!.toMap(),
      'stateOfRequiremnt': stateOfRequiremnt,
    };
  }

  Future<Map<String, dynamic>> toMapWithFileServer() async {
    return ({
      'idSubReqDetail': idSubReqDetail,
      'textValue': textValue,
      'idTypeFiled': idTypeFiled,
      'urlFile':
          urlFile == null ? null : await dio.MultipartFile.fromFile(urlFile!),
      'choice': choice.value == null ? null : choice.value!.toMap(),
      'stateOfRequiremnt': stateOfRequiremnt,
    });
  }

  factory RequestServicesSubDetails.fromMap(Map<String, dynamic> map) {
    return RequestServicesSubDetails(
      idSubReqDetail:
          map['idSubReqDetail'] != null ? map['idSubReqDetail'] as int : null,
      textValue: map['textValue'] != null ? map['textValue'] as String : null,
      idTypeFiled:
          map['idTypeFiled'] != null ? map['idTypeFiled'] as int : null,
      urlFile: map['urlFile'] != null ? map['urlFile'] as String : null,
      choice:
          Rx<Choose?>(Choose.fromMap(map['choice'] as Map<String, dynamic>)),
      stateOfRequiremnt: map['stateOfRequiremnt'] != null
          ? map['stateOfRequiremnt'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestServicesSubDetails.fromJson(String source) =>
      RequestServicesSubDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestServicesSubDetails(idSubReqDetail: $idSubReqDetail, textValue: $textValue, idTypeFiled: $idTypeFiled, urlFile: $urlFile, choice: $choice, stateOfRequiremnt: $stateOfRequiremnt)';
  }

  @override
  bool operator ==(covariant RequestServicesSubDetails other) {
    if (identical(this, other)) return true;

    return other.idSubReqDetail == idSubReqDetail &&
        other.textValue == textValue &&
        other.idTypeFiled == idTypeFiled &&
        other.urlFile == urlFile &&
        other.choice == choice &&
        other.stateOfRequiremnt == stateOfRequiremnt;
  }

  @override
  int get hashCode {
    return idSubReqDetail.hashCode ^
        textValue.hashCode ^
        idTypeFiled.hashCode ^
        urlFile.hashCode ^
        choice.hashCode ^
        stateOfRequiremnt.hashCode;
  }
}

class RequestServicesMainDetails {
  int? id;

  String? textValue;
  int? idTypeFiled;
  String? file;
  String? fileName;

  Rx<Choose?> choice;
  Rx<ChooseSub?> choiceSub;
  int? stateOfRequiremnt;
  RequestServicesMainDetails({
    this.id,
    this.textValue,
    this.idTypeFiled,
    this.fileName,
    this.file,
    required this.choice,
    required this.choiceSub,
    this.stateOfRequiremnt,
  });

  RequestServicesMainDetails copyWith({
    int? id,
    String? textValue,
    int? idTypeFiled,
    String? file,
    String? fileName,
    Rx<Choose?>? choice,
    Rx<ChooseSub?>? choiceSub,
    int? stateOfRequiremnt,
  }) {
    return RequestServicesMainDetails(
        id: id ?? this.id,
        textValue: textValue ?? this.textValue,
        idTypeFiled: idTypeFiled ?? this.idTypeFiled,
        file: file ?? this.file,
        choice: choice ?? this.choice,
        fileName: fileName ?? this.fileName,
        stateOfRequiremnt: stateOfRequiremnt ?? this.stateOfRequiremnt,
        choiceSub: choiceSub ?? this.choiceSub);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'textValue': textValue,
      'idTypeFiled': idTypeFiled,
      'typeFile': fileName,
      'urlFile': file,
      'choice': choice.value == null ? null : choice.value!.toMap(),
      'choiceSub': choice.value == null ? null : choiceSub.value!.toMap(),
      'stateOfRequiremnt': stateOfRequiremnt,
    };
  }

  Map<String, dynamic> toMapWithFileServer() {
    return {
      'id': id,
      'textValue': textValue,
      'idTypeFiled': idTypeFiled,
      'fileName': fileName,
      'file': file == null ? null : file!,
      'choice': choice.value == null ? null : choice.value!.toMap(),
      'choiceSub': choiceSub.value == null ? null : choiceSub.value!.toMap(),
      'stateOfRequiremnt': stateOfRequiremnt,
    };
  }

  factory RequestServicesMainDetails.fromMap(Map<String, dynamic> map) {
    return RequestServicesMainDetails(
      id: map['id'] != null ? map['id'] as int : null,
      textValue: map['textValue'] != null ? map['textValue'] as String : null,
      fileName: map['fileName'] != null ? map['fileName'] as String : null,
      idTypeFiled:
          map['idTypeFiled'] != null ? map['idTypeFiled'] as int : null,
      file: map['file'] != null ? map['file'] as String : null,
      choice:
          Rx<Choose?>(Choose.fromMap(map['choice'] as Map<String, dynamic>)),
      choiceSub: Rx<ChooseSub?>(
          ChooseSub.fromMap(map['choice'] as Map<String, dynamic>)),
      stateOfRequiremnt: map['stateOfRequiremnt'] != null
          ? map['stateOfRequiremnt'] as int
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestServicesMainDetails.fromJson(String source) =>
      RequestServicesMainDetails.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestServicesMainDetails(idMainRequire: $id, textValue: $textValue, idTypeFiled: $idTypeFiled, urlFile: $file, choice: $choice, stateOfRequiremnt: $stateOfRequiremnt)';
  }

  @override
  bool operator ==(covariant RequestServicesMainDetails other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.textValue == textValue &&
        other.idTypeFiled == idTypeFiled &&
        other.file == file &&
        other.choice == choice &&
        other.choiceSub == choiceSub &&
        other.stateOfRequiremnt == stateOfRequiremnt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        textValue.hashCode ^
        idTypeFiled.hashCode ^
        file.hashCode ^
        choice.hashCode ^
        choiceSub.hashCode ^
        stateOfRequiremnt.hashCode;
  }
}

class TripHelperBooking {
  int? idTrips;
  DateTime? dateGo;
  DateTime? dateBack;
  TripHelperBooking({
    this.idTrips,
    this.dateGo,
    this.dateBack,
  });

  TripHelperBooking copyWith({
    int? idTrips,
    DateTime? dateGo,
    DateTime? dateBack,
  }) {
    return TripHelperBooking(
      idTrips: idTrips ?? this.idTrips,
      dateGo: dateGo ?? this.dateGo,
      dateBack: dateBack ?? this.dateBack,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idTrips': idTrips,
      'dateGo': dateGo?.toIso8601String(),
      'dateBack': dateBack?.toIso8601String(),
    };
  }

  factory TripHelperBooking.fromMap(Map<String, dynamic> map) {
    return TripHelperBooking(
      idTrips: map['idTrips'] != null ? map['idTrips'] as int : null,
      dateGo: map['dateGo'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateGo'] as int)
          : null,
      dateBack: map['dateBack'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateBack'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TripHelperBooking.fromJson(String source) =>
      TripHelperBooking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TripHelperBooking(idTrips: $idTrips, dateGo: $dateGo, dateBack: $dateBack)';

  @override
  bool operator ==(covariant TripHelperBooking other) {
    if (identical(this, other)) return true;

    return other.idTrips == idTrips &&
        other.dateGo == dateGo &&
        other.dateBack == dateBack;
  }

  @override
  int get hashCode => idTrips.hashCode ^ dateGo.hashCode ^ dateBack.hashCode;
}
