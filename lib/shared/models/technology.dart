// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zognest_website/resources/assets.dart';

class Technology extends Equatable {
  final String name;
  final String image;
  final bool isPng;

  const Technology({
    required this.name,
    required this.image,
    required this.isPng,
  });

  Technology copyWith({
    String? name,
    String? image,
    bool? isPng,

  }) {
    return Technology(
      name: name ?? this.name,
      image: image ?? this.image,
      isPng: isPng ?? this.isPng,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'isPng': isPng,

    };
  }

  factory Technology.fromMap(Map<String, dynamic> map) {
    return Technology(
      name: map['name'],
      image: map['image'],
      isPng: map['ispng'] ?? false,
    );
  }

  factory Technology.empty() =>
      const Technology(name: '', image: Assets.zognestLogoNew,isPng: false);

  String toJson() => json.encode(toMap());

  factory Technology.fromJson(String source) =>
      Technology.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Technology(name: $name, image: $image, isPng: $isPng)';

  @override
  List<Object> get props => [name, image, isPng];
}