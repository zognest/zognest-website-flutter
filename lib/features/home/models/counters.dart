import 'dart:convert';

import 'package:equatable/equatable.dart';
class Counter extends Equatable {
  final int count;
  final String title;
  final bool hasPlus;

  const Counter({
    required this.count,
    required this.title,
    required this.hasPlus,
  });

  Counter copyWith({
    int? count,
    String? title,
    bool? hasPlus,
  }) {
    return Counter(
      count: count ?? this.count,
      title: title ?? this.title,
      hasPlus: hasPlus ?? this.hasPlus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'title': title,
      'hasPlus': hasPlus,
    };
  }

  factory Counter.fromMap(Map<String, dynamic> map) {
    return Counter(
      count: map['count'],
      title: map['title'],
      hasPlus: map['hasPlus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Counter.fromJson(String source) =>
      Counter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Counters(count: $count, title: $title, hasPlus: $hasPlus)';

  @override
  List<Object> get props => [count, title, hasPlus];
}
