// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class Models {
  int? id;
  Models({
    this.id,
  });

  @override
  String toString() => 'Models(id: $id)';

  @override
  bool operator ==(covariant Models other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
