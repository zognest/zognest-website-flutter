import 'dart:convert';

import 'package:equatable/equatable.dart';
class Counter extends Equatable {
  final int count;
  final int end;
  final int index;
  final String title;
  final bool hasPlus;

  const Counter({
    required this.count,
    required this.title,
    required this.hasPlus,
    required this.end,
    required this.index,
  });

  Counter copyWith({
    int? count,
    int? end,
    int? index,
    String? title,
    bool? hasPlus,
  }) {
    return Counter(
      count: count ?? this.count,
      index: index ?? this.index,
      end: end ?? this.end,
      title: title ?? this.title,
      hasPlus: hasPlus ?? this.hasPlus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'index': index,
      'end': end,
      'title': title,
      'hasPlus': hasPlus,
    };
  }

  factory Counter.fromMap(Map<String, dynamic> map) {
    return Counter(
      count: map['count'],
      end: map['end'],
      index: map['index'],
      title: map['title'],
      hasPlus: map['hasPlus'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Counter.fromJson(String source) =>
      Counter.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Counters(count: $count, title: $title, hasPlus: $hasPlus, end:$end, index : $index)';

  @override
  List<Object> get props => [count, title, hasPlus,end,index];
}


/*class TitleZognet extends Equatable {
  final String titleZognet;
  final List<Counter> counter;
  const TitleZognet({
     required this.counter,
     this.titleZognet= '',
  });

  TitleZognet copyWith({
    String? titleZognet,
    List<Counter>? counter,
  }) {
    return TitleZognet(
      titleZognet: titleZognet ?? this.titleZognet,
      counter:counter ?? this.counter,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'titleZognet': titleZognet,
      'counter': counter,
    };
  }

  factory TitleZognet.fromMap(Map<String, dynamic> map) {
    return TitleZognet(
      titleZognet: map['title_Zognet'],
      counter: map['counter'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TitleZognet.fromJson(String source) =>
      TitleZognet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TitleZognet( titleZognet: $titleZognet,counter: $counter)';

  @override
  List<Object> get props => [titleZognet,counter];
}*/


