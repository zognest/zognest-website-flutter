// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Project extends Equatable {
  final String title;
  final String brief;
  final String description;
  final String cover;
  final String? splash;
  final String icon;

  const Project({
    required this.title,
    required this.brief,
    required this.description,
    required this.cover,
    required this.splash,
    required this.icon,
  });

  Project copyWith({
    String? title,
    String? brief,
    String? description,
    String? cover,
    String? splash,
    String? icon,
  }) {
    return Project(
      title: title ?? this.title,
      brief: brief ?? this.brief,
      description: description ?? this.description,
      cover: cover ?? this.cover,
      splash: splash ?? this.splash,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'brief': brief,
      'description': description,
      'image': cover,
      'splash': splash,
      'icon': icon,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      title: map['title'],
      brief: map['brief'],
      description: map['description'],
      cover: map['cover'],
      splash: map['splash'],
      icon: map['icon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      title,
      brief,
      description,
      cover,
      splash ?? '',
      icon,
    ];
  }
}
