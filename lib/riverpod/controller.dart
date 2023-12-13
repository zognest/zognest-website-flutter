import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/firebase_services/firestore_services.dart';
import 'package:zognest_website/riverpod/state.dart';

final appControllerProvider = StateNotifierProvider<AppController, AppState>(
  (ref) {
    return AppController(
      const AppState(
        blogs: AsyncValue.data([]),
      ),
    );
  },
);

class AppController extends StateNotifier<AppState> {
  AppController(super.state) {
    getData();
  }

  Future<void> getData() async {
    state = state.copyWith(
      blogs: const AsyncLoading(),
    );

    final List<Blog> blogs = await FirestoreServices.getBlogs();

    state = state.copyWith(
      blogs: AsyncData(blogs),
    );

    print(state.blogs);
  }
}
