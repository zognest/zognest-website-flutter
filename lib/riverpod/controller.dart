import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/features/home/models/client_feedback.dart';
import 'package:zognest_website/features/home/models/offer.dart';
import 'package:zognest_website/features/our_space/models/event.dart';
import 'package:zognest_website/firebase_services/firestore_services.dart';
import 'package:zognest_website/riverpod/state.dart';
import 'package:zognest_website/shared/utils.dart';

final appControllerProvider = StateNotifierProvider<AppController, AppState>(
  (ref) {
    return AppController(
      const AppState(
        loaded: false,
        blogs: AsyncValue.data([]),
        clientFeedbacks: AsyncValue.data([]),
        events: AsyncValue.data([]),
        offers: AsyncValue.data([]),
        videoUrl: AsyncValue.loading(),
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
    ]);
  }

  Future<void> getBlogs() async {
    if (state.blogs.asData?.value.isNotEmpty ?? false) return;

    state = state.copyWith(blogs: const AsyncLoading());

    final List<Blog> blogs = await FirestoreServices.getBlogs();

    state = state.copyWith(blogs: AsyncData(blogs));

    Utils.log(message: 'Loaded Blogs => ${state.blogs.value?.length}');
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
}
