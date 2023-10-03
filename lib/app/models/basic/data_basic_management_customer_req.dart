// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:projecttravelwin/app/models/basic/state_request.dart';

import 'requst_service_booking.dart';

class DataBasicCustomerRequest {
  List<StateRequiremnt>? stateRequerment;
  List<StateRequest>? stateRequest;
  DataBasicCustomerRequest({
    this.stateRequerment,
    this.stateRequest,
  }) {
    stateRequerment ??= [];
    stateRequest ??= [];
  }

  DataBasicCustomerRequest copyWith({
    List<StateRequiremnt>? stateRequerment,
    List<StateRequest>? stateRequest,
  }) {
    return DataBasicCustomerRequest(
      stateRequerment: stateRequerment ?? this.stateRequerment,
      stateRequest: stateRequest ?? this.stateRequest,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stateRequerment': stateRequerment?.map((x) => x.toMap()).toList(),
      'stateRequest': stateRequest?.map((x) => x.toMap()).toList(),
    };
  }

  factory DataBasicCustomerRequest.fromMap(Map<String, dynamic> map) {
    return DataBasicCustomerRequest(
      stateRequerment: map['stateRequerment'] != null
          ? List<StateRequiremnt>.from(
              (map['stateRequerment'] as List<dynamic>).map<StateRequiremnt?>(
                (x) => StateRequiremnt.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      stateRequest: map['stateRequest'] != null
          ? List<StateRequest>.from(
              (map['stateRequest'] as List<dynamic>).map<StateRequest?>(
                (x) => StateRequest.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DataBasicCustomerRequest.fromJson(String source) =>
      DataBasicCustomerRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DataBasicCustomerRequest(stateRequerment: $stateRequerment, stateRequest: $stateRequest)';

  @override
  bool operator ==(covariant DataBasicCustomerRequest other) {
    if (identical(this, other)) return true;

    return listEquals(other.stateRequerment, stateRequerment) &&
        listEquals(other.stateRequest, stateRequest);
  }

  @override
  int get hashCode => stateRequerment.hashCode ^ stateRequest.hashCode;
}
