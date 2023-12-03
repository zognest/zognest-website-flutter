// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Offer extends Equatable {
  final String highlight;
  final String title;
  final String description;

  const Offer({
    required this.highlight,
    required this.title,
    required this.description,
  });

  Offer copyWith({
    String? highlight,
    String? title,
    String? description,
  }) {
    return Offer(
      highlight: highlight ?? this.highlight,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'highlight': highlight,
      'title': title,
      'description': description,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      highlight: map['highlight'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) =>
      Offer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Offer(highlight: $highlight, title: $title, description: $description)';

  @override
  List<Object> get props => [highlight, title, description];
}
