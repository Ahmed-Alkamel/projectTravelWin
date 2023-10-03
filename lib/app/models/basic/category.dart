// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart' as found;

class Category {
  int? idCategoryMain;
  String? nameCategoryMain;
  int? idSubCategory;
  int? levelTwoCategory;
  List<Category>? subCategory;
  Category({
    this.idCategoryMain,
    this.nameCategoryMain,
    this.idSubCategory,
    this.levelTwoCategory,
    this.subCategory,
  });

  Category copyWith({
    int? idCategoryMain,
    String? nameCategoryMain,
    int? idSubCategory,
    int? levelTwoCategory,
    List<Category>? subCategory,
  }) {
    return Category(
      idCategoryMain: idCategoryMain ?? this.idCategoryMain,
      nameCategoryMain: nameCategoryMain ?? this.nameCategoryMain,
      idSubCategory: idSubCategory ?? this.idSubCategory,
      levelTwoCategory: levelTwoCategory ?? this.levelTwoCategory,
      subCategory: subCategory ?? this.subCategory,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idCategoryMain': idCategoryMain,
      'nameCategoryMain': nameCategoryMain,
      'idSubCategory': idSubCategory,
      'levelTwoCategory': levelTwoCategory,
      'subCategory': subCategory?.map((x) => x.toMap()).toList(),
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      idCategoryMain:
          map['idCategoryMain'] != null ? map['idCategoryMain'] as int : null,
      nameCategoryMain: map['nameCategoryMain'] != null
          ? map['nameCategoryMain'] as String
          : null,
      idSubCategory:
          map['idSubCategory'] != null ? map['idSubCategory'] as int : null,
      levelTwoCategory: map['levelTwoCategory'] != null
          ? map['levelTwoCategory'] as int
          : null,
      subCategory: map['SubCategory'] != null
          ? List<Category>.from(
              (map['SubCategory'] as List<dynamic>).map<Category?>(
                (x) => Category.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(idCategoryMain: $idCategoryMain, nameCategoryMain: $nameCategoryMain, idSubCategory: $idSubCategory, levelTwoCategory: $levelTwoCategory, subCategory: $subCategory)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.idCategoryMain == idCategoryMain &&
        other.nameCategoryMain == nameCategoryMain &&
        other.idSubCategory == idSubCategory &&
        other.levelTwoCategory == levelTwoCategory &&
        found.listEquals(other.subCategory, subCategory);
  }

  @override
  int get hashCode {
    return idCategoryMain.hashCode ^
        nameCategoryMain.hashCode ^
        idSubCategory.hashCode ^
        levelTwoCategory.hashCode ^
        subCategory.hashCode;
  }
}

class CategoryModel {
  bool state;
  String massege;
  List<Category>? data;
  CategoryModel({
    required this.state,
    required this.massege,
    this.data,
  });

  CategoryModel copyWith({
    bool? state,
    String? massege,
    List<Category>? data,
  }) {
    return CategoryModel(
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

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      state: map['state'] as bool,
      massege: map['massege'] as String,
      data: map['data'] != null
          ? List<Category>.from(
              (map['data'] as List<dynamic>).map<Category?>(
                (x) => Category.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CategoryModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        found.listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}
