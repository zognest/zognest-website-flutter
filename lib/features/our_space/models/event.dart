// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final String title;
  final DateTime date;
  final List<String> images;
  final String coverImage;

  const Event({
    required this.title,
    required this.date,
    required this.images,
    required this.coverImage,
  });

  @override
  List<Object> get props => [title, date, images, coverImage];

  Event copyWith({
    String? title,
    DateTime? date,
    List<String>? images,
    String? coverImage,
  }) {
    return Event(
      title: title ?? this.title,
      date: date ?? this.date,
      images: images ?? this.images,
      coverImage: coverImage ?? this.coverImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'images': images,
      'coverImage': coverImage,
    };
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      title: map['title'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      images: List<String>.from(map['images']),
      coverImage: map['coverImage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
