// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'customer.dart';
import 'data_basic.dart';
import 'identity_customers.dart';
import 'proccess_app.dart';
import 'requst_service_booking.dart';
import 'services_details.dart';
import 'state_request.dart';
import 'trips.dart';

class CutomerRequestModel {
  bool state;
  String massege;
  List<UserRequest>? data;
  CutomerRequestModel({
    required this.state,
    required this.massege,
    this.data,
  });

  CutomerRequestModel copyWith({
    bool? state,
    String? massege,
    List<UserRequest>? data,
  }) {
    return CutomerRequestModel(
      state: state ?? this.state,
      massege: massege ?? this.massege,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'massege': massege,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory CutomerRequestModel.fromMap(Map<String, dynamic> map) {
    return CutomerRequestModel(
      state: map['state'] as bool,
      massege: map['massege'] as String,
      data: map['data'] != null
          ? List<UserRequest>.from(
              (map['data'] as List<dynamic>).map<UserRequest?>(
                (x) => UserRequest.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CutomerRequestModel.fromJson(String source) =>
      CutomerRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CutomerRequestModel(state: $state, massege: $massege, data: $data)';
  @override
  bool operator ==(covariant CutomerRequestModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}

class UserRequest {
  int? idCustomerRequsts;
  String? serviceName;
  StateRequest? state;
  int? idCus;
  Employees? employees;
  RequestTrip? requestTrip;
  User? customer;
  RequestServicePublic? requestServicePublic;
  ServiceDetails? serviceDetails;
  UserRequest({
    this.idCustomerRequsts,
    this.serviceName,
    this.state,
    this.idCus,
    this.employees,
    this.requestTrip,
    this.customer,
    this.requestServicePublic,
    this.serviceDetails,
  });
  StateRequest get getState {
    return state!;
  }

  UserRequest copyWith({
    int? idCustomerRequsts,
    String? serviceName,
    StateRequest? state,
    int? idCus,
    Employees? employees,
    RequestTrip? requestTrip,
    User? customer,
    RequestServicePublic? requestServicePublic,
    ServiceDetails? serviceDetails,
  }) {
    return UserRequest(
      idCustomerRequsts: idCustomerRequsts ?? this.idCustomerRequsts,
      serviceName: serviceName ?? this.serviceName,
      state: state ?? this.state,
      idCus: idCus ?? this.idCus,
      employees: employees ?? this.employees,
      requestTrip: requestTrip ?? this.requestTrip,
      customer: customer ?? this.customer,
      requestServicePublic: requestServicePublic ?? this.requestServicePublic,
      serviceDetails: serviceDetails ?? this.serviceDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idCustomerRequsts': idCustomerRequsts,
      'serviceName': serviceName,
      'state': state?.toMap(),
      'idCus': idCus,
      'employees': employees?.toMap(),
      'requestTrip': requestTrip?.toMap(),
      'customer': customer?.toMap(),
      'requestServicePublic': requestServicePublic?.toMap(),
      'serviceDetails': serviceDetails?.toMap(),
    };
  }

  factory UserRequest.fromMap(Map<String, dynamic> map) {
    return UserRequest(
      idCustomerRequsts: map['idCustomerRequsts'] != null
          ? map['idCustomerRequsts'] as int
          : null,
      serviceName:
          map['serviceName'] != null ? map['serviceName'] as String : null,
      state: map['state'] != null
          ? StateRequest.fromMap(map['state'] as Map<String, dynamic>)
          : null,
      idCus: map['idCus'] != null ? map['idCus'] as int : null,
      employees: map['employees'] != null
          ? Employees.fromMap(map['employees'] as Map<String, dynamic>)
          : null,
      requestTrip: map['requestTrip'] != null
          ? RequestTrip.fromMap(map['requestTrip'] as Map<String, dynamic>)
          : null,
      customer: map['customer'] != null
          ? User.fromMap(map['customer'] as Map<String, dynamic>)
          : null,
      requestServicePublic: map['requestServicePublic'] != null
          ? RequestServicePublic.fromMap(
              map['requestServicePublic'] as Map<String, dynamic>)
          : null,
      serviceDetails: map['serviceDetails'] != null
          ? ServiceDetails.fromMap(
              map['serviceDetails'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserRequest.fromJson(String source) =>
      UserRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserRequest(idCustomerRequsts: $idCustomerRequsts, serviceName: $serviceName, state: $state, idCus: $idCus, employees: $employees, requestTrip: $requestTrip, customer: $customer, requestServicePublic: $requestServicePublic, serviceDetails: $serviceDetails)';
  }

  @override
  bool operator ==(covariant UserRequest other) {
    if (identical(this, other)) return true;

    return other.idCustomerRequsts == idCustomerRequsts &&
        other.serviceName == serviceName &&
        other.state == state &&
        other.idCus == idCus &&
        other.employees == employees &&
        other.requestTrip == requestTrip &&
        other.customer == customer &&
        other.requestServicePublic == requestServicePublic &&
        other.serviceDetails == serviceDetails;
  }

  @override
  int get hashCode {
    return idCustomerRequsts.hashCode ^
        serviceName.hashCode ^
        state.hashCode ^
        idCus.hashCode ^
        employees.hashCode ^
        requestTrip.hashCode ^
        customer.hashCode ^
        requestServicePublic.hashCode ^
        serviceDetails.hashCode;
  }
}

class StateRequestModel {
  bool state;
  String massege;
  List<StateRequest>? data;
  StateRequestModel({
    required this.state,
    required this.massege,
    this.data,
  });

  StateRequestModel copyWith({
    bool? state,
    String? massege,
    List<StateRequest>? data,
  }) {
    return StateRequestModel(
      state: state ?? this.state,
      massege: massege ?? this.massege,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'massege': massege,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory StateRequestModel.fromMap(Map<String, dynamic> map) {
    return StateRequestModel(
      state: map['state'] as bool,
      massege: map['massege'] as String,
      data: map['data'] != null
          ? List<StateRequest>.from(
              (map['data'] as List<dynamic>).map<StateRequest?>(
                (x) => StateRequest.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory StateRequestModel.fromJson(String source) =>
      StateRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'StateRequestModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant StateRequestModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}

class Employees {
  int? idEmp;
  Name? name;
  String? address;
  double? salary;
  bool? isAdmin;
  String? numberPhone;
  String? password;
  List<ProcessApp>? permisstion;
  Employees({
    this.idEmp,
    this.name,
    this.address,
    this.salary,
    this.isAdmin,
    this.numberPhone,
    this.password,
    this.permisstion,
  }) {
    name ??= Name();
    permisstion ??= [];
  }

  Employees copyWith({
    Name? name,
    String? address,
    int? idEmp,
    double? salary,
    bool? isAdmin,
    String? numberPhone,
    String? password,
    List<ProcessApp>? permisstion,
  }) {
    return Employees(
        name: name ?? this.name,
        address: address ?? this.address,
        salary: salary ?? this.salary,
        isAdmin: isAdmin ?? this.isAdmin,
        numberPhone: numberPhone ?? this.numberPhone,
        password: password ?? this.password,
        permisstion: permisstion ?? this.permisstion,
        idEmp: idEmp ?? this.idEmp);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idEmp': idEmp,
      'name': name?.toMap(),
      'address': address,
      'salary': salary,
      'isAdmin': isAdmin,
      'numberPhone': numberPhone,
      'password': password,
      'permisstion': permisstion?.map((x) => x.toMap()).toList(),
    };
  }

  factory Employees.fromMap(Map<String, dynamic> map) {
    return Employees(
      idEmp: map['idEmp'] != null ? map['idEmp'] as int : null,
      name: map['name'] != null
          ? Name.fromMap(map['name'] as Map<String, dynamic>)
          : null,
      address: map['address'] != null ? map['address'] as String : null,
      salary: map['salary'] != null
          ? map['salary'] is int
              ? map['salary'].toDouble()
              : map['salary'] as double
          : null,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as bool : null,
      numberPhone:
          map['numberPhone'] != null ? map['numberPhone'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      permisstion: map['permisstion'] != null
          ? List<ProcessApp>.from(
              (map['permisstion'] as List<dynamic>).map<ProcessApp?>(
                (x) => ProcessApp.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Employees.fromJson(String source) =>
      Employees.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Employees(name: $name, address: $address, salary: $salary, isAdmin: $isAdmin, numberPhone: $numberPhone, password: $password, permisstion: $permisstion)';
  }

  @override
  bool operator ==(covariant Employees other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.address == address &&
        other.salary == salary &&
        other.isAdmin == isAdmin &&
        other.numberPhone == numberPhone &&
        other.password == password &&
        other.idEmp == idEmp &&
        listEquals(other.permisstion, permisstion);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        address.hashCode ^
        salary.hashCode ^
        isAdmin.hashCode ^
        numberPhone.hashCode ^
        password.hashCode ^
        password.hashCode ^
        permisstion.hashCode;
  }
}

class RequestTrip {
  int? id;
  List<Info>? info;
  Plantrip? planTrip;
  DateTime? bookingTime;
  List<InfoBooking>? infoBooking;
  RequestTrip({
    this.id,
    this.info,
    this.planTrip,
    this.bookingTime,
    this.infoBooking,
  });

  RequestTrip copyWith({
    int? id,
    List<Info>? info,
    Plantrip? planTrip,
    DateTime? bookingTime,
    List<InfoBooking>? infoBooking,
  }) {
    return RequestTrip(
      id: id ?? this.id,
      info: info ?? this.info,
      planTrip: planTrip ?? this.planTrip,
      bookingTime: bookingTime ?? this.bookingTime,
      infoBooking: infoBooking ?? this.infoBooking,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'info': info?.map((x) => x.toMap()).toList(),
      'planTrip': planTrip?.toMap(),
      'bookingTime': bookingTime?.millisecondsSinceEpoch,
      'infoBooking': infoBooking?.map((x) => x.toMap()).toList(),
    };
  }

  factory RequestTrip.fromMap(Map<String, dynamic> map) {
    return RequestTrip(
      id: map['id'] != null ? map['id'] as int : null,
      info: map['info'] != null
          ? List<Info>.from(
              (map['info'] as List<dynamic>).map<Info?>(
                (x) => Info.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      planTrip: map['planTrip'] != null
          ? Plantrip.fromMap(map['planTrip'] as Map<String, dynamic>)
          : null,
      bookingTime: map['bookingTime'] != null
          ? DateTime.tryParse(map['bookingTime'] as String)
          : null,
      infoBooking: map['infoBooking'] != null
          ? List<InfoBooking>.from(
              (map['infoBooking'] as List<dynamic>).map<InfoBooking?>(
                (x) => InfoBooking.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestTrip.fromJson(String source) =>
      RequestTrip.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestTrip(id: $id, info: $info, planTrip: $planTrip, bookingTime: $bookingTime, infoBooking: $infoBooking)';
  }

  @override
  bool operator ==(covariant RequestTrip other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.info, info) &&
        other.planTrip == planTrip &&
        other.bookingTime == bookingTime &&
        listEquals(other.infoBooking, infoBooking);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        info.hashCode ^
        planTrip.hashCode ^
        bookingTime.hashCode ^
        infoBooking.hashCode;
  }
}

class InfoModel {
  bool state;
  String massege;
  List<Info>? data;
  InfoModel({
    required this.state,
    required this.massege,
    this.data,
  }) {
    data ??= [];
  }

  InfoModel copyWith({
    bool? state,
    String? massege,
    List<Info>? data,
  }) {
    return InfoModel(
      state: state ?? this.state,
      massege: massege ?? this.massege,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'massege': massege,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory InfoModel.fromMap(Map<String, dynamic> map) {
    return InfoModel(
      state: map['state'] as bool,
      massege: map['massege'] as String,
      data: map['data'] != null
          ? List<Info>.from(
              (map['data'] as List<dynamic>).map<Info?>(
                (x) => Info.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory InfoModel.fromJson(String source) =>
      InfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InfoModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant InfoModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}

class Info {
  Trips? trip;
  DateTime? dateGo;
  DateTime? dataBack;
  Info({
    this.trip,
    this.dateGo,
    this.dataBack,
  });

  Info copyWith({
    Trips? trip,
    DateTime? dateGo,
    DateTime? dataBack,
  }) {
    return Info(
      trip: trip ?? this.trip,
      dateGo: dateGo ?? this.dateGo,
      dataBack: dataBack ?? this.dataBack,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'trip': trip?.toMap(),
      'dateGo': dateGo?.millisecondsSinceEpoch,
      'dataBack': dataBack?.millisecondsSinceEpoch,
    };
  }

  factory Info.fromMap(Map<String, dynamic> map) {
    return Info(
      trip: map['trip'] != null
          ? Trips.fromMap(map['trip'] as Map<String, dynamic>)
          : null,
      dateGo: map['dateGo'] != null
          ? DateTime.tryParse(map['dateGo'] as String)
          : null,
      dataBack: map['dataBack'] != null
          ? DateTime.tryParse(map['dataBack'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Info.fromJson(String source) =>
      Info.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Info(trip: $trip, dateGo: $dateGo, dataBack: $dataBack)';

  @override
  bool operator ==(covariant Info other) {
    if (identical(this, other)) return true;

    return other.trip == trip &&
        other.dateGo == dateGo &&
        other.dataBack == dataBack;
  }

  @override
  int get hashCode => trip.hashCode ^ dateGo.hashCode ^ dataBack.hashCode;
}

class InfoBooking {
  IdentityCustomers person;
  List<DataInputRequrment>? dataInputRequrment;
  InfoBooking({
    required this.person,
    this.dataInputRequrment,
  });

  InfoBooking copyWith({
    IdentityCustomers? person,
    List<DataInputRequrment>? dataInputRequrment,
  }) {
    return InfoBooking(
      person: person ?? this.person,
      dataInputRequrment: dataInputRequrment ?? this.dataInputRequrment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'person': person.toMap(),
      'dataInputRequrment': dataInputRequrment?.map((x) => x.toMap()).toList(),
    };
  }

  factory InfoBooking.fromMap(Map<String, dynamic> map) {
    return InfoBooking(
      person: IdentityCustomers.fromMap(map['person'] as Map<String, dynamic>),
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

  factory InfoBooking.fromJson(String source) =>
      InfoBooking.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InfoBooking(person: $person, dataInputRequrment: $dataInputRequrment)';

  @override
  bool operator ==(covariant InfoBooking other) {
    if (identical(this, other)) return true;

    return other.person == person &&
        listEquals(other.dataInputRequrment, dataInputRequrment);
  }

  @override
  int get hashCode => person.hashCode ^ dataInputRequrment.hashCode;
}
