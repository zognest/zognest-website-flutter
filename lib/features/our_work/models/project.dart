// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String title;
  final String brief;
  final String description;
  final String image;
  final String icon;

  const Project({
    required this.title,
    required this.brief,
    required this.description,
    required this.image,
    required this.icon,
  });

  Project copyWith({
    String? title,
    String? brief,
    String? description,
    String? image,
    String? icon,
  }) {
    return Project(
      title: title ?? this.title,
      brief: brief ?? this.brief,
      description: description ?? this.description,
      image: image ?? this.image,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'brief': brief,
      'description': description,
      'image': image,
      'icon': icon,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      title: map['title'] as String,
      brief: map['brief'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      icon: map['icon'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) => Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      title,
      brief,
      description,
      image,
      icon,
    ];
  }
}
