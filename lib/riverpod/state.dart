import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/features/our_space/models/event.dart';

@immutable
class AppState extends Equatable {
  const AppState({
    required this.loaded,
    required this.blogs,
    required this.clientFeedbacks,
    required this.events,
    required this.offers,
    required this.videoUrl,
  });

  /*
  * AsyncValue
  * AsyncData('link') = AsyncValue.data()
  * AsyncLoading()
  * AsyncError(error)
  * */

  final bool loaded;
  final AsyncValue<List<Blog>> blogs;
  final AsyncValue<List<ClientFeedback>> clientFeedbacks;
  final AsyncValue<List<Event>> events;
  final AsyncValue<List<Offer>> offers;
  final AsyncValue<String> videoUrl;

  AppState copyWith({
    bool? loaded,
    AsyncValue<List<Blog>>? blogs,
    AsyncValue<List<ClientFeedback>>? clientFeedbacks,
    AsyncValue<List<Event>>? events,
    AsyncValue<List<Offer>>? offers,
    AsyncValue<String>? videoUrl,
  }) {
    return AppState(
      loaded: loaded ?? this.loaded,
      blogs: blogs ?? this.blogs,
      clientFeedbacks: clientFeedbacks ?? this.clientFeedbacks,
      events: events ?? this.events,
      offers: offers ?? this.offers,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }

  @override
  List<Object?> get props =>
      [loaded, blogs, clientFeedbacks, events, offers, videoUrl];
}
