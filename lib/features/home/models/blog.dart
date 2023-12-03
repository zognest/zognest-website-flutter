// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Blog extends Equatable {
  final String image;
  final String title;
  final DateTime date;

  const Blog({
    required this.image,
    required this.title,
    required this.date,
  });

  Blog copyWith({
    String? image,
    String? title,
    DateTime? date,
  }) {
    return Blog(
      image: image ?? this.image,
      title: title ?? this.title,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      image: map['image'] as String,
      title: map['title'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) =>
      Blog.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Blog(image: $image, title: $title, date: $date)';

  @override
  List<Object> get props => [image, title, date];
}
