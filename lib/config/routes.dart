import 'package:go_router/go_router.dart';
import 'package:zognest_website/features/home/pages/home_page.dart';
import 'package:zognest_website/shared/widgets/undefined_screen.dart';

abstract final class Routing {
  Routing._();

  static final router = GoRouter(
    initialLocation: HomePage.route,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: HomePage.route,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: UndefinedPage.route,
        builder: (_, __) => const UndefinedPage(),
      ),
    ],
  );
}
