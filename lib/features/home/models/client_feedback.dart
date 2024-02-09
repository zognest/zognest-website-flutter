// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ClientFeedback extends Equatable {
  final String clientImage;
  final String name;

  final String audioUrl;
  final String id;
  final List<String> backgroundImages;
  final String description;

  const ClientFeedback(
      {required this.clientImage,
      required this.name,
      required this.id,
      required this.backgroundImages,
      required this.description,
      required this.audioUrl});

  ClientFeedback copyWith(
      {String? clientImage,
      String? name,
      String? id,
      List<String>? backgroundImages,
      String? description,
      String? audioUrl}) {
    return ClientFeedback(
      audioUrl: audioUrl ?? this.audioUrl,
      clientImage: clientImage ?? this.clientImage,
      name: name ?? this.name,
      id: id ?? this.id,
      backgroundImages: backgroundImages ?? this.backgroundImages,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clientImage': clientImage,
      'name': name,
      'id': id,
      'backgroundImages': backgroundImages,
      'description': description,
      'audiourl': audioUrl,
    };
  }

  factory ClientFeedback.fromMap(Map<String, dynamic> map) {
    return ClientFeedback(
      audioUrl: map['audio_url'],
      clientImage: map['client_image'],
      name: map['name'],
      id: map['id'],
      backgroundImages: List<String>.from(map['background_images']),
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientFeedback.fromJson(String source) =>
      ClientFeedback.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ClientFeedback(clientImage: $clientImage, name: $name, id: $id, backgroundImages: $backgroundImages, description: $description, audioUrl:$audioUrl)';
  }

  @override
  List<Object> get props {
    return [
      clientImage,
      name,
      id,
      backgroundImages,
      description,
      audioUrl
    ];
  }
}
