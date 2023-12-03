// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Technology {
  final String name;
  final String image;

  Technology({
    required this.name,
    required this.image,
  });

  Technology copyWith({
    String? name,
    String? image,
  }) {
    return Technology(
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
    };
  }

  factory Technology.fromMap(Map<String, dynamic> map) {
    return Technology(
      name: map['name'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Technology.fromJson(String source) =>
      Technology.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Technology(name: $name, image: $image)';

  @override
  bool operator ==(covariant Technology other) {
    if (identical(this, other)) return true;

    return other.name == name && other.image == image;
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode;
}
