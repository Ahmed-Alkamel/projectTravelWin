// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Choose {
  int? idChooseMain;
  int? idMainRequire;
  String? containt;
  DateTime? timeUpdate;
  DateTime? timeAdd;
  Choose({
    this.idChooseMain,
    this.idMainRequire,
    this.containt,
    this.timeUpdate,
    this.timeAdd,
  });

  Choose copyWith({
    int? idChooseMain,
    int? idMainRequire,
    String? containt,
    DateTime? timeUpdate,
    DateTime? timeAdd,
  }) {
    return Choose(
      idChooseMain: idChooseMain ?? this.idChooseMain,
      idMainRequire: idMainRequire ?? this.idMainRequire,
      containt: containt ?? this.containt,
      timeUpdate: timeUpdate ?? this.timeUpdate,
      timeAdd: timeAdd ?? this.timeAdd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idChooseMain': idChooseMain,
      'idMainRequire': idMainRequire,
      'containt': containt,
      'timeUpdate': timeUpdate?.millisecondsSinceEpoch,
      'timeAdd': timeAdd?.millisecondsSinceEpoch,
    };
  }

  factory Choose.fromMap(Map<String, dynamic> map) {
    return Choose(
      idChooseMain:
          map['idChooseMain'] != null ? map['idChooseMain'] as int : null,
      idMainRequire:
          map['idMainRequire'] != null ? map['idMainRequire'] as int : null,
      containt: map['containt'] != null ? map['containt'] as String : null,
      timeUpdate: map['timeUpdate'] != null
          ? DateTime.tryParse(map['timeUpdate'] as String)
          : null,
      timeAdd: map['timeAdd'] != null
          ? DateTime.tryParse(map['timeAdd'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Choose.fromJson(String source) =>
      Choose.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Choose(idChooseMain: $idChooseMain, idMainRequire: $idMainRequire, containt: $containt, timeUpdate: $timeUpdate, timeAdd: $timeAdd)';
  }

  @override
  bool operator ==(covariant Choose other) {
    if (identical(this, other)) return true;

    return other.idChooseMain == idChooseMain &&
        other.idMainRequire == idMainRequire &&
        other.containt == containt &&
        other.timeUpdate == timeUpdate &&
        other.timeAdd == timeAdd;
  }

  @override
  int get hashCode {
    return idChooseMain.hashCode ^
        idMainRequire.hashCode ^
        containt.hashCode ^
        timeUpdate.hashCode ^
        timeAdd.hashCode;
  }
}

class ChooseSub {
  int? idChooseSub;
  int? idSubReqDetail;
  String? containt;
  DateTime? timeUpdate;
  ChooseSub({
    this.idChooseSub,
    this.idSubReqDetail,
    this.containt,
    this.timeUpdate,
  });

  ChooseSub copyWith({
    int? idChooseSub,
    int? idSubReqDetail,
    String? containt,
    DateTime? timeUpdate,
  }) {
    return ChooseSub(
      idChooseSub: idChooseSub ?? this.idChooseSub,
      idSubReqDetail: idSubReqDetail ?? this.idSubReqDetail,
      containt: containt ?? this.containt,
      timeUpdate: timeUpdate ?? this.timeUpdate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idChooseSub': idChooseSub,
      'idSubReqDetail': idSubReqDetail,
      'containt': containt,
      'timeUpdate': timeUpdate?.millisecondsSinceEpoch,
    };
  }

  factory ChooseSub.fromMap(Map<String, dynamic> map) {
    return ChooseSub(
      idChooseSub:
          map['idChooseSub'] != null ? map['idChooseSub'] as int : null,
      idSubReqDetail:
          map['idSubReqDetail'] != null ? map['idSubReqDetail'] as int : null,
      containt: map['containt'] != null ? map['containt'] as String : null,
      timeUpdate: map['timeUpdate'] != null
          ? DateTime.tryParse(map['timeUpdate'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChooseSub.fromJson(String source) =>
      ChooseSub.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChooseSub(idChooseSub: $idChooseSub, idSubReqDetail: $idSubReqDetail, containt: $containt, timeUpdate: $timeUpdate)';
  }

  @override
  bool operator ==(covariant ChooseSub other) {
    if (identical(this, other)) return true;

    return other.idChooseSub == idChooseSub &&
        other.idSubReqDetail == idSubReqDetail &&
        other.containt == containt &&
        other.timeUpdate == timeUpdate;
  }

  @override
  int get hashCode {
    return idChooseSub.hashCode ^
        idSubReqDetail.hashCode ^
        containt.hashCode ^
        timeUpdate.hashCode;
  }
}

class TypeFiled {
  int? id;
  String? name;
  String? value;
  TypeFiled({
    this.id,
    this.name,
    this.value,
  });

  TypeFiled copyWith({
    int? id,
    String? name,
    String? value,
  }) {
    return TypeFiled(
      id: id ?? this.id,
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'value': value,
    };
  }

  factory TypeFiled.fromMap(Map<String, dynamic> map) {
    return TypeFiled(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      value: map['value'] != null ? map['value'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeFiled.fromJson(String source) =>
      TypeFiled.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TypeFiled(id: $id, name: $name, value: $value)';

  @override
  bool operator ==(covariant TypeFiled other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ value.hashCode;
}

// enum TypeFiledValue {
//   Text,
//   Date,
//   Image,
//   File,
//   DropDown,
//   CheckBox,
//   Hint,
//   Number
// }

// String getTypeFiledEnum(TypeFiledValue value) {
//   switch (value) {
//     case TypeFiledValue.Text:
//       return 'Text';
//     case TypeFiledValue.Date:
//       return 'Date';
//     case TypeFiledValue.Image:
//       return 'Image';
//     case TypeFiledValue.File:
//       return 'File';
//     case TypeFiledValue.DropDown:
//       return 'DropDown';
//     case TypeFiledValue.CheckBox:
//       return 'CheckBox';
//     case TypeFiledValue.Hint:
//       return 'Hint';
//     case TypeFiledValue.Number:
//       return 'Number';
//     default:
//       return 'error in type';
//   }
// }
