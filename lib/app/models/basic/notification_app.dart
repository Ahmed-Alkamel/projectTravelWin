// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class NotificationApp {
  int? id;
  int? idCustomerRequsts;
  int? idCus;
  Message? message;
  NotificationApp({
    this.id,
    this.idCustomerRequsts,
    this.idCus,
    this.message,
  });

  NotificationApp copyWith({
    int? id,
    int? idCustomerRequsts,
    int? idCus,
    Message? message,
  }) {
    return NotificationApp(
      id: id ?? this.id,
      idCustomerRequsts: idCustomerRequsts ?? this.idCustomerRequsts,
      idCus: idCus ?? this.idCus,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idCustomerRequsts': idCustomerRequsts,
      'idCus': idCus,
      'message': message?.toMap(),
    };
  }

  factory NotificationApp.fromMap(Map<String, dynamic> map) {
    return NotificationApp(
      id: map['id'] != null ? map['id'] as int : null,
      idCustomerRequsts: map['idCustomerRequsts'] != null
          ? map['idCustomerRequsts'] as int
          : null,
      idCus: map['idCus'] != null ? map['idCus'] as int : null,
      message: map['message'] != null
          ? Message.fromMap(map['message'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationApp.fromJson(String source) =>
      NotificationApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationApp(id: $id, idCustomerRequsts: $idCustomerRequsts, idCus: $idCus, message: $message)';
  }

  @override
  bool operator ==(covariant NotificationApp other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.idCustomerRequsts == idCustomerRequsts &&
        other.idCus == idCus &&
        other.message == message;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idCustomerRequsts.hashCode ^
        idCus.hashCode ^
        message.hashCode;
  }
}

class Message {
  int id;
  String titleTemplet;
  String titleNotification;
  String body;
  String? summury;
  Message({
    required this.id,
    required this.titleTemplet,
    required this.titleNotification,
    required this.body,
    this.summury,
  });

  Message copyWith({
    int? id,
    String? titleTemplet,
    String? titleNotification,
    String? body,
    String? summury,
  }) {
    return Message(
      id: id ?? this.id,
      titleTemplet: titleTemplet ?? this.titleTemplet,
      titleNotification: titleNotification ?? this.titleNotification,
      body: body ?? this.body,
      summury: summury ?? this.summury,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'titleTemplet': titleTemplet,
      'titleNotification': titleNotification,
      'body': body,
      'summury': summury,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as int,
      titleTemplet: map['titleTemplet'] as String,
      titleNotification: map['titleNotification'] as String,
      body: map['body'] as String,
      summury: map['summury'] != null ? map['summury'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(id: $id, titleTemplet: $titleTemplet, titleNotification: $titleNotification, body: $body, summury: $summury)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.titleTemplet == titleTemplet &&
        other.titleNotification == titleNotification &&
        other.body == body &&
        other.summury == summury;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        titleTemplet.hashCode ^
        titleNotification.hashCode ^
        body.hashCode ^
        summury.hashCode;
  }
}

class MessageModel {
  bool state;
  String? massege;
  List<Message>? data;
  MessageModel({
    required this.state,
    this.massege,
    this.data,
  });

  MessageModel copyWith({
    bool? state,
    String? massege,
    List<Message>? data,
  }) {
    return MessageModel(
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

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      state: map['state'] as bool,
      massege: map['massege'] != null ? map['massege'] as String : null,
      data: map['data'] != null
          ? List<Message>.from(
              (map['data'] as List<dynamic>).map<Message?>(
                (x) => Message.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MessageModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}
