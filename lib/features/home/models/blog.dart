// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String image;
  final String title;
  final DateTime date;
  final String urlLink;

  const Blog({
    required this.image,
    required this.title,
    required this.date,
    required this.urlLink,
  });

  Blog copyWith({
    String? image,
    String? title,
    DateTime? date,
    String? urlLink,
  }) {
    return Blog(
      image: image ?? this.image,
      title: title ?? this.title,
      date: date ?? this.date,
      urlLink:urlLink??this.urlLink
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'urlLink':urlLink,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      image: map['image'] as String,
      title: map['title'] as String,
      date: (map['date'] as Timestamp).toDate(),
      urlLink: map['urlLink']as String
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) =>
      Blog.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Blog(image: $image, title: $title, date: $date, urlLink:$urlLink)';

  @override
  List<Object> get props => [image, title, date, urlLink];
}
