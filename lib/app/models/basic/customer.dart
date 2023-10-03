// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get_rx/get_rx.dart';

import 'identity_customers.dart';

class User {
  int? idCus;
  String? nikName;
  String? numberPhone;
  String? emailAddress;
  String? password;
  int? idChat;
  IdentitBeneficiares? identityMe;
  List<IdentitBeneficiares>? benefities;
  User({
    this.idCus,
    this.nikName,
    this.numberPhone,
    this.emailAddress,
    this.password,
    this.idChat,
    this.identityMe,
    this.benefities,
  });

  // String? get nameId {
  //   return '${identityMe!.identityCustomer!.name.frisName!} ${identityMe!.identityCustomer!.name.lastName} ${identityMe!.identityCustomer!.name.surName}';
  // }

  User copyWith({
    int? idCus,
    String? nikName,
    String? numberPhone,
    String? emailAddress,
    String? password,
    int? idChat,
    IdentitBeneficiares? identityMe,
    List<IdentitBeneficiares>? benefities,
  }) {
    return User(
      idCus: idCus ?? this.idCus,
      nikName: nikName ?? this.nikName,
      numberPhone: numberPhone ?? this.numberPhone,
      emailAddress: emailAddress ?? this.emailAddress,
      password: password ?? this.password,
      idChat: idChat ?? this.idChat,
      identityMe: identityMe ?? this.identityMe,
      benefities: benefities ?? this.benefities,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idCus': idCus,
      'nikName': nikName,
      'numberPhone': numberPhone,
      'emailAddress': emailAddress,
      'password': password,
      'idChat': idChat,
      'identityMe': identityMe?.toMap(),
      'benefities': benefities?.map((x) => x.toMap()).toList(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      idCus: map['idCus'] != null ? map['idCus'] as int : null,
      nikName: map['nikName'] != null ? map['nikName'] as String : null,
      numberPhone:
          map['numberPhone'] != null ? map['numberPhone'] as String : null,
      emailAddress:
          map['emailAddress'] != null ? map['emailAddress'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      idChat: map['idChat'] != null ? map['idChat'] as int : null,
      identityMe: map['identityMe'] != null
          ? IdentitBeneficiares.fromMap(
              map['identityMe'] as Map<String, dynamic>)
          : null,
      benefities: map['benefities'] != null
          ? List<IdentitBeneficiares>.from(
              (map['benefities'] as List<dynamic>).map<IdentitBeneficiares?>(
                (x) => IdentitBeneficiares.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(idCus: $idCus, nikName: $nikName, numberPhone: $numberPhone, emailAddress: $emailAddress, password: $password, idChat: $idChat, identityMe: $identityMe, benefities: $benefities)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.idCus == idCus &&
        other.nikName == nikName &&
        other.numberPhone == numberPhone &&
        other.emailAddress == emailAddress &&
        other.password == password &&
        other.idChat == idChat &&
        other.identityMe == identityMe &&
        listEquals(other.benefities, benefities);
  }

  @override
  int get hashCode {
    return idCus.hashCode ^
        nikName.hashCode ^
        numberPhone.hashCode ^
        emailAddress.hashCode ^
        password.hashCode ^
        idChat.hashCode ^
        identityMe.hashCode ^
        benefities.hashCode;
  }
}

class IdentitBeneficiares {
  bool? isMe;
  IdentityCustomers? identityCustomer;
  RxBool isSelected = RxBool(false);
  IdentitBeneficiares({
    this.isMe,
    this.identityCustomer,
  });

  IdentitBeneficiares copyWith({
    bool? isMe,
    IdentityCustomers? identityCustomer,
  }) {
    return IdentitBeneficiares(
      isMe: isMe ?? this.isMe,
      identityCustomer: identityCustomer ?? this.identityCustomer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isMe': isMe,
      'identityCustomer': identityCustomer?.toMap(),
    };
  }

  factory IdentitBeneficiares.fromMap(Map<String, dynamic> map) {
    return IdentitBeneficiares(
      isMe: map['isMe'] != null ? map['isMe'] as bool : null,
      identityCustomer: map['identityCustomer'] != null
          ? IdentityCustomers.fromMap(
              map['identityCustomer'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdentitBeneficiares.fromJson(String source) =>
      IdentitBeneficiares.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'IdentitBeneficiares(isMe: $isMe, identityCustomer: $identityCustomer)';

  @override
  bool operator ==(covariant IdentitBeneficiares other) {
    if (identical(this, other)) return true;

    return other.isMe == isMe && other.identityCustomer == identityCustomer;
  }

  @override
  int get hashCode => isMe.hashCode ^ identityCustomer.hashCode;
}
