import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/features/about_us/models/staff.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/features/home/models/service.dart';
import 'package:zognest_website/features/our_services/models/purchasable_service.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/features/our_work/models/project.dart';
import '../features/home/models/counters.dart';

@immutable
class AppState extends Equatable {
  const AppState({
    required this.loaded,
    required this.blogs,
    required this.clientFeedbacks,
    required this.events,
    required this.offers,
    required this.videoUrl,
    required this.projects,
    required this.purchasableServices,
    required this.staff,
    required this.services,
    required this.cartServices,
    required this.counters,
  });

  final bool loaded;
  final AsyncValue<List<Blog>> blogs;
  final AsyncValue<List<ClientFeedback>> clientFeedbacks;
  final AsyncValue<List<Event>> events;
  final AsyncValue<List<Offer>> offers;
  final AsyncValue<String> videoUrl;
  final AsyncValue<List<Project>> projects;
  final AsyncValue<List<PurchasableService>> purchasableServices;
  final AsyncValue<List<Service>> services;
  final AsyncValue<List<Staff>> staff;
  final List<PurchasableService> cartServices;
  final AsyncValue<List<Counter>>counters;

  AppState copyWith({
    bool? loaded,
    AsyncValue<List<Blog>>? blogs,
    AsyncValue<List<ClientFeedback>>? clientFeedbacks,
    AsyncValue<List<Event>>? events,
    AsyncValue<List<Offer>>? offers,
    AsyncValue<String>? videoUrl,
    AsyncValue<List<Project>>? projects,
    AsyncValue<List<PurchasableService>>? purchasableServices,
    AsyncValue<List<Service>>? services,
    AsyncValue<List<Staff>>? staff,
    List<PurchasableService>? cartServices,
    AsyncValue<List<Counter>>? counters,
  }) {
    return AppState(
      loaded: loaded ?? this.loaded,
      blogs: blogs ?? this.blogs,
      clientFeedbacks: clientFeedbacks ?? this.clientFeedbacks,
      events: events ?? this.events,
      offers: offers ?? this.offers,
      videoUrl: videoUrl ?? this.videoUrl,
      projects: projects ?? this.projects,
      services: services ?? this.services,
      staff: staff ?? this.staff,
      purchasableServices: purchasableServices ?? this.purchasableServices,
      cartServices: cartServices ?? this.cartServices,
      counters: counters ?? this.counters,
    );
  }

  @override
  List<Object?> get props => [
    loaded,
    blogs,
    clientFeedbacks,
    events,
    offers,
    videoUrl,
    projects,
    purchasableServices,
    services,
    staff,
    cartServices,
    counters
  ];
}
