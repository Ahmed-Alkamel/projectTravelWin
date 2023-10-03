// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'category.dart' as cat;
import 'identitfy_card.dart';
import 'main_requiremnt.dart';
import 'services_details.dart';
import 'sub_requiremnt.dart';

class ServicesModel {
  bool state;
  String massege;
  List<Service>? data;

  ServicesModel({
    required this.state,
    required this.massege,
    this.data,
  });

  ServicesModel copyWith({
    bool? state,
    String? massege,
    List<Service>? data,
  }) {
    return ServicesModel(
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

  factory ServicesModel.fromMap(Map<String, dynamic> map) {
    return ServicesModel(
      state: map['state'] as bool,
      massege: map['massege'] as String,
      data: map['data'] != null
          ? List<Service>.from(
              (map['data'] as List<dynamic>).map<Service?>(
                (x) => Service.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicesModel.fromJson(String source) =>
      ServicesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ServicesModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant ServicesModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}

class Service {
  int? id;
  String? name;
  cat.Category? category;
  String? pathImage;
  ServiceDetails? serviceDetails;
  List<IdentitfyCard>? identitfyRequerment;
  List<MainRequirment>? mainRequirment;
  List<SubRequiremnt>? subRequiremnts;

  Service({
    this.id,
    this.name,
    this.category,
    this.pathImage,
    this.serviceDetails,
    this.identitfyRequerment,
    this.mainRequirment,
    this.subRequiremnts,
  }) {
    identitfyRequerment ??= [];
    mainRequirment ??= [];
    subRequiremnts ??= [];
    serviceDetails ??= ServiceDetails();
  }

  Service copyWith({
    int? id,
    String? name,
    cat.Category? category,
    String? pathImage,
    ServiceDetails? serviceDetails,
    List<IdentitfyCard>? identitfyRequerment,
    List<MainRequirment>? mainRequirment,
    List<SubRequiremnt>? subRequiremnts,
  }) {
    return Service(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      pathImage: pathImage ?? this.pathImage,
      serviceDetails: serviceDetails ?? this.serviceDetails,
      identitfyRequerment: identitfyRequerment ?? this.identitfyRequerment,
      mainRequirment: mainRequirment ?? this.mainRequirment,
      subRequiremnts: subRequiremnts ?? this.subRequiremnts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'category': category?.toMap(),
      'serviceDetails': serviceDetails?.toMap(),
      'pathImage': pathImage,
      'identitfyRequerment':
          identitfyRequerment?.map((x) => x.toMap()).toList(),
      'mainRequirment': mainRequirment?.map((x) => x.toMap()).toList(),
      'subRequiremnts': subRequiremnts?.map((x) => x.toMap()).toList(),
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      category: map['category'] != null
          ? cat.Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      serviceDetails: map['serviceDetails'] != null
          ? ServiceDetails.fromMap(
              map['serviceDetails'] as Map<String, dynamic>)
          : null,
      pathImage: map['pathImage'] != null ? map['pathImage'] as String : null,
      identitfyRequerment: map['identitfyRequerment'] != []
          ? List<IdentitfyCard>.from(
              (map['identitfyRequerment'] as List<dynamic>).map<IdentitfyCard?>(
                (x) => IdentitfyCard.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      mainRequirment: map['mainRequirment'] != null
          ? List<MainRequirment>.from(
              (map['mainRequirment'] as List<dynamic>).map<MainRequirment?>(
                (x) => MainRequirment.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      subRequiremnts: map['subRequiremnts'] != null
          ? List<SubRequiremnt>.from(
              (map['subRequiremnts'] as List<dynamic>).map<SubRequiremnt?>(
                (x) => SubRequiremnt.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Service(id: $id, name: $name, category: $category, pathImage: $pathImage, identitfyRequerment: $identitfyRequerment, mainRequirment: $mainRequirment, subRequiremnts: $subRequiremnts)';
  }

  @override
  bool operator ==(covariant Service other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.serviceDetails == serviceDetails &&
        other.category == category &&
        other.pathImage == pathImage &&
        listEquals(other.identitfyRequerment, identitfyRequerment) &&
        listEquals(other.mainRequirment, mainRequirment) &&
        listEquals(other.subRequiremnts, subRequiremnts);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        category.hashCode ^
        pathImage.hashCode ^
        serviceDetails.hashCode ^
        identitfyRequerment.hashCode ^
        mainRequirment.hashCode ^
        subRequiremnts.hashCode;
  }
}
