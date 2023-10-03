// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'user_request.dart';

class CustomerRequestStreamModel {
  List<UserRequest>? data;
  CustomerRequestStreamModel({
    this.data,
  });

  CustomerRequestStreamModel copyWith({
    List<UserRequest>? data,
  }) {
    return CustomerRequestStreamModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomerRequestStreamModel.fromMap(Map<String, dynamic> map) {
    return CustomerRequestStreamModel(
      data: map['info'] != null
          ? List<UserRequest>.from(
              (map['info'] as List<dynamic>).map<UserRequest?>(
                (x) => UserRequest.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerRequestStreamModel.fromJson(String source) =>
      CustomerRequestStreamModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CustomerRequestStreamModel(data: $data)';

  @override
  bool operator ==(covariant CustomerRequestStreamModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.data, data);
  }

  @override
  int get hashCode => data.hashCode;
}
