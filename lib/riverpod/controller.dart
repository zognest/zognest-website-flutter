import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/features/home/models/service.dart';
import 'package:zognest_website/features/our_services/models/purchasable_service.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/firebase_services/firestore_services.dart';
import 'package:zognest_website/riverpod/state.dart';
import 'package:zognest_website/shared/utils.dart';

import '../features/our_work/models/project.dart';

final appControllerProvider = StateNotifierProvider<AppController, AppState>(
  (ref) {
    return AppController(
       const AppState(
        loaded: false,
        blogs: AsyncData([]),
        clientFeedbacks: AsyncData([]),
        events: AsyncData([]),
        offers: AsyncData([]),
        videoUrl: AsyncLoading(),
        project: AsyncData([]),
        purchasableService: AsyncData([]),
         services: AsyncData([]),
      ),
    );
  },
);

class AppController extends StateNotifier<AppState> {
  AppController(super.state) {
    loadData();
  }

  Future<void> loadData() async {
    await Future.wait([
      getBlogs(),
      getClientFeedbacks(),
      getEvents(),
      getOffers(),
      getVideoUrl(),
      getProject(),
    ]);
  }

  Future<void> getBlogs() async {
    if (state.blogs.asData?.value.isNotEmpty ?? false) return;

    state = state.copyWith(blogs: const AsyncLoading());

    final List<Blog> blogs = await FirestoreServices.getBlogs();

    state = state.copyWith(blogs: AsyncData(blogs));

    Utils.log(message: 'Loaded Blogs => ${state.blogs.value}');
  }

  Future<void> getClientFeedbacks() async {
    if (state.clientFeedbacks.asData?.value.isNotEmpty ?? false) return;

    state = state.copyWith(clientFeedbacks: const AsyncLoading());

    final List<ClientFeedback> clientFeedbacks =
        await FirestoreServices.getClientFeedbacks();

    state = state.copyWith(clientFeedbacks: AsyncData(clientFeedbacks));

    Utils.log(
      message:
          'Loaded Client Feedbacks => ${state.clientFeedbacks.value?.length}',
    );
  }

  Future<void> getEvents() async {
    if (state.events.asData?.value.isNotEmpty ?? false) return;

    state = state.copyWith(events: const AsyncLoading());

    final List<Event> events = await FirestoreServices.getEvents();

    state = state.copyWith(events: AsyncData(events));

    Utils.log(message: 'Loaded Events => ${state.events.value?.length}');
  }

  Future<void> getOffers() async {
    if (state.offers.asData?.value.isNotEmpty ?? false) return;

    state = state.copyWith(offers: const AsyncLoading());

    final List<Offer> offers = await FirestoreServices.getOffers();

    state = state.copyWith(offers: AsyncData(offers));

    Utils.log(message: 'Loaded Offers => ${state.offers.value?.length}');
  }

  Future<void> getVideoUrl() async {
    if (state.videoUrl.asData?.value.isNotEmpty ?? false) return;

    state = state.copyWith(videoUrl: const AsyncLoading());

    final String videoUrl = await FirestoreServices.getVideoUrl();

    state = state.copyWith(videoUrl: AsyncData(videoUrl));

    Utils.log(message: 'Loaded Video => ${state.videoUrl.value}');
  }

  //point 1  in 2
  Future<void> getProject() async {
    if (state.project.asData?.value.isNotEmpty ?? false) return;

    state = state.copyWith(project: const AsyncLoading());

    final List<Project> project = await FirestoreServices.getProject();

    state = state.copyWith(project: AsyncData(project));

    Utils.log(message: 'Loaded Project => ${state.project.value}');
  }

  //point 2 in 2
  Future<void> getPurchasableService() async {
    if (state.purchasableService.asData?.value.isNotEmpty ?? false) return;

    state = state.copyWith(purchasableService: const AsyncLoading());

    final List<PurchasableService> purchasableService =
        await FirestoreServices.getPurchasableService();

    state =state.copyWith(purchasableService: AsyncData(purchasableService));

    Utils.log(message: 'purchasableService => ${state.purchasableService.value}');
  }

  //point 3 in 2
Future<void> getService()async{
    if(state.services.asData?.value.isNotEmpty ?? false)return;

    state=state.copyWith(services: const AsyncLoading());

   final List<Service> service= await FirestoreServices.getService();

    state =state.copyWith(services: AsyncData(service));

    Utils.log(message: 'Service => ${state.services.value}');

}
}
