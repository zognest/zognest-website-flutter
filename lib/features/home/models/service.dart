// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:zognest_website/shared/models/technology.dart';

class Service extends Equatable {
  final String highlight;
  final String title;
  final String description;
  final String backgroundImage;
  final List<Technology> technologies;

  const Service({
    required this.highlight,
    required this.title,
    required this.description,
    required this.technologies,
    required this.backgroundImage,
  });

  Service copyWith({
    String? highlight,
    String? title,
    String? description,
    String? backgroundImage,
    List<Technology>? technologies,
    bool? staffList,
  }) {
    return Service(
      highlight: highlight ?? this.highlight,
      title: title ?? this.title,
      description: description ?? this.description,
      backgroundImage: backgroundImage ?? this.backgroundImage,
      technologies: technologies ?? this.technologies,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'highlight': highlight,
      'title': title,
      'description': description,
      'backgroundImage': backgroundImage,
      'technologies': technologies.map((x) => x.toMap()).toList(),
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      highlight: map['highlight'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      backgroundImage: map['background_image'] as String,
      technologies: [Technology.empty()],
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) =>
      Service.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Service(highlight: $highlight, title: $title, description: $description, backgroundImage:$backgroundImage,technologies: $technologies)';
  }

  @override
  List<Object> get props => [
        highlight,
        title,
        description,
        technologies,
        backgroundImage,
      ];
}
