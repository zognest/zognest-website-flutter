// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PurchasableService extends Equatable {
  final String title;
  final String description;
  final String image;
  final int id;

  const PurchasableService({
    required this.title,
    required this.description,
    required this.image,
    required this.id,
  });

  PurchasableService copyWith({
    String? title,
    String? description,
    String? image,
    int? id,
  }) {
    return PurchasableService(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'image': image,
      'id': id,
    };
  }

  factory PurchasableService.fromMap(Map<String, dynamic> map) {
    return PurchasableService(
      title: map['title'],
      description: map['description'],
      image: map['image'],
      id: map['id'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PurchasableService.fromJson(String source) =>
      PurchasableService.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurchasableService(title: $title, description: $description, image: $image, id: $id)';
  }

  @override
  List<Object> get props => [title, description, image, id];
}
