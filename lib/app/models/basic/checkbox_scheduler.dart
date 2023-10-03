import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CheckboxScheduler {
  int id;
  String title;
  bool value;
  CheckboxScheduler({
    required this.id,
    required this.title,
    required this.value,
  });

  CheckboxScheduler copyWith({
    int? id,
    String? title,
    bool? value,
  }) {
    return CheckboxScheduler(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'value': value,
    };
  }

  factory CheckboxScheduler.fromMap(Map<String, dynamic> map) {
    return CheckboxScheduler(
      id: map['id'] as int,
      title: map['title'] as String,
      value: map['value'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckboxScheduler.fromJson(String source) =>
      CheckboxScheduler.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CheckboxScheduler(id: $id, title: $title, value: $value)';

  @override
  bool operator ==(covariant CheckboxScheduler other) {
    if (identical(this, other)) return true;

    return other.id == id && other.title == title && other.value == value;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ value.hashCode;
}
