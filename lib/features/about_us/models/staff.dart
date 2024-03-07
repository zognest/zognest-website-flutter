// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/shared/models/technology.dart';

class Staff extends Equatable {
  final String name;
  final String position;
  final String description;
  final String url;
  final List<Technology> technologies;
  final String avatar;
  final Color color;

  const Staff({
    required this.avatar,
    required this.name,
    required this.position,
    required this.description,
    required this.url,
    required this.technologies,
    required this.color,
  });

  Staff copyWith({
    String? name,
    String? position,
    String? description,
    String? url,
    List<Technology>? technologies,
    String? avatar,
    Color? color,
  }) {
    return Staff(
      name: name ?? this.name,
      position: position ?? this.position,
      description: description ?? this.description,
      url: url ?? this.url,
      technologies: technologies ?? this.technologies,
      avatar: avatar ?? this.avatar,
      color: color??this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'position': position,
      'description': description,
      'url': url,
      'color':color,
      'backgroundImage': avatar,
      'technologies': technologies.map((x) => x.toMap()).toList(),
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      name: map['name'],
      position: map['position'],
      description: map['description'],
      url: map['url'],
      avatar: map['avatar'],
      technologies: [Technology.empty()],
      color:Color(int.parse(map['color'],radix: 16)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) =>
      Staff.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Staff('
        'name: $name'
        ', position: $position,'
        ' description: $description,'
        ' url: $url,'
        ' technologies: '
        '$technologies, '
        'avatar: $avatar,'
        ' color: $color'
        ')';
  }

  @override
  List<Object> get props {
    return [
      name,
      color,
      position,
      description,
      url,
      technologies,
      avatar,
    ];
  }
}
