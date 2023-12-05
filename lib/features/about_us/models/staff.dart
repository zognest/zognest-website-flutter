// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zognest_website/shared/models/technology.dart';

class Staff extends Equatable {
  final String name;
  final String position;
  final String description;
  final String url;
  final List<Technology> technologies;

  const Staff({
    required this.name,
    required this.position,
    required this.description,
    required this.url,
    required this.technologies,
  });

  Staff copyWith({
    String? name,
    String? position,
    String? description,
    String? url,
    List<Technology>? technologies,
  }) {
    return Staff(
      name: name ?? this.name,
      position: position ?? this.position,
      description: description ?? this.description,
      url: url ?? this.url,
      technologies: technologies ?? this.technologies,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'position': position,
      'description': description,
      'url': url,
      'technologies': technologies.map((x) => x.toMap()).toList(),
    };
  }

  factory Staff.fromMap(Map<String, dynamic> map) {
    return Staff(
      name: map['name'] as String,
      position: map['position'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
      technologies: List<Technology>.from(
        (map['technologies'] as List<int>).map<Technology>(
          (x) => Technology.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Staff.fromJson(String source) =>
      Staff.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Staff(name: $name, position: $position, description: $description, url: $url, technologies: $technologies)';
  }

  @override
  List<Object> get props {
    return [
      name,
      position,
      description,
      url,
      technologies,
    ];
  }
}
