// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Global {
  String? laravelBaseUrl;
  String? apiPath;
  Global({
    this.laravelBaseUrl,
    this.apiPath,
  });

  Global copyWith({
    String? laravelBaseUrl,
    String? apiPath,
  }) {
    return Global(
      laravelBaseUrl: laravelBaseUrl ?? this.laravelBaseUrl,
      apiPath: apiPath ?? this.apiPath,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'laravelBaseUrl': laravelBaseUrl,
      'apiPath': apiPath,
    };
  }

  factory Global.fromMap(Map<String, dynamic> map) {
    return Global(
      laravelBaseUrl: map['laravelBaseUrl'] != null
          ? map['laravelBaseUrl'] as String
          : null,
      apiPath: map['apiPath'] != null ? map['apiPath'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Global.fromJson(String source) =>
      Global.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Global(laravelBaseUrl: $laravelBaseUrl, apiPath: $apiPath)';

  @override
  bool operator ==(covariant Global other) {
    if (identical(this, other)) return true;

    return other.laravelBaseUrl == laravelBaseUrl && other.apiPath == apiPath;
  }

  @override
  int get hashCode => laravelBaseUrl.hashCode ^ apiPath.hashCode;
}
