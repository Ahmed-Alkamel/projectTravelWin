// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProcessAppModel {
  bool state;
  String massege;
  List<ProcessApp>? data;
  ProcessAppModel({
    required this.state,
    required this.massege,
    this.data,
  }) {
    data ??= [];
  }

  ProcessAppModel copyWith({
    bool? state,
    String? massege,
    List<ProcessApp>? data,
  }) {
    return ProcessAppModel(
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

  factory ProcessAppModel.fromMap(Map<String, dynamic> map) {
    return ProcessAppModel(
      state: map['state'] as bool,
      massege: map['massege'] as String,
      data: map['data'] != null
          ? List<ProcessApp>.from(
              (map['data'] as List<dynamic>).map<ProcessApp?>(
                (x) => ProcessApp.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProcessAppModel.fromJson(String source) =>
      ProcessAppModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProcessAppModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant ProcessAppModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}

class ProcessApp {
  int? id;
  String? name;
  List<PermisstionApp>? permission;
  ProcessApp({
    this.id,
    this.name,
    this.permission,
  }) {
    permission ??= [];
  }

  ProcessApp copyWith({
    int? id,
    String? name,
    List<PermisstionApp>? permission,
  }) {
    return ProcessApp(
      id: id ?? this.id,
      name: name ?? this.name,
      permission: permission ?? this.permission,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'permission': permission?.map((x) => x.toMap()).toList(),
    };
  }

  factory ProcessApp.fromMap(Map<String, dynamic> map) {
    return ProcessApp(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      permission: map['permission'] != null
          ? List<PermisstionApp>.from(
              (map['permission'] as List<dynamic>).map<PermisstionApp?>(
                (x) => PermisstionApp.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProcessApp.fromJson(String source) =>
      ProcessApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProcessApp(id: $id, name: $name, permission: $permission)';

  @override
  bool operator ==(covariant ProcessApp other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.permission, permission);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ permission.hashCode;
}

class PermisstionApp {
  int? id;
  String? name;
  bool? allow;
  bool? deny;
  PermisstionApp({
    this.id,
    this.name,
    this.allow,
    this.deny,
  }) {
    allow ??= false;
    deny ??= true;
  }

  PermisstionApp copyWith({
    int? id,
    String? name,
    bool? allow,
    bool? deny,
  }) {
    return PermisstionApp(
      id: id ?? this.id,
      name: name ?? this.name,
      allow: allow ?? this.allow,
      deny: deny ?? this.deny,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'allow': allow,
      'deny': deny,
    };
  }

  factory PermisstionApp.fromMap(Map<String, dynamic> map) {
    return PermisstionApp(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      allow: map['allow'] != null ? map['allow'] as bool : null,
      deny: map['deny'] != null ? map['deny'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PermisstionApp.fromJson(String source) =>
      PermisstionApp.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PermisstionApp(id: $id, name: $name, allow: $allow, deny: $deny)';
  }

  @override
  bool operator ==(covariant PermisstionApp other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.allow == allow &&
        other.deny == deny;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ allow.hashCode ^ deny.hashCode;
  }
}
