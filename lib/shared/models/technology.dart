// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zognest_website/resources/assets.dart';

class Technology extends Equatable {
  final String name;
  final String image;

  const Technology({
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
    return {
      'name': name,
      'image': image,
    };
  }

  factory Technology.fromMap(Map<String, dynamic> map) {
    return Technology(
      name: map['name'],
      image: map['image'],
    );
  }

  factory Technology.empty() =>
      const Technology(name: 'Test', image: Assets.zognestLogoNew);

  String toJson() => json.encode(toMap());

  factory Technology.fromJson(String source) =>
      Technology.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Technology(name: $name, image: $image)';

  @override
  List<Object> get props => [name, image];
}

class StaffList extends Equatable {
 final String name;
 final String image;

  const StaffList({
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
    return {
      'name': name,
      'image': image,
    };
  }

  factory StaffList.fromMap(Map<String, dynamic> map) {
    return StaffList(
      name: map['name'],
      image: map['image'],
    );
  }

  factory StaffList.empty() =>
      const StaffList(name: 'Test', image: Assets.zognestLogoNew);

  String toJson() => json.encode(toMap());

  factory StaffList.fromJson(String source) =>
      StaffList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'StaffList(name: $name, image: $image)';

  @override
  List<Object> get props => [name, image];
}