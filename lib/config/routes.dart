import 'package:go_router/go_router.dart';
import 'package:zognest_website/features/home/pages/home_page.dart';
import 'package:zognest_website/features/our_services/pages/our_services_page.dart';
import 'package:zognest_website/features/our_work/pages/our_work_page.dart';
import 'package:zognest_website/shared/widgets/undefined_screen.dart';

abstract final class Routing {
  Routing._();

  static final router = GoRouter(
    initialLocation: OurWorkPage.route,
    debugLogDiagnostics: true,
    errorBuilder: (_, __) => const UndefinedPage(onlyBody: true),
    routes: [
      GoRoute(
        name: HomePage.route,
        path: HomePage.route,
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        name: OurServicesPage.route,
        path: OurServicesPage.route,
        builder: (_, __) => const OurServicesPage(),
      ),
      GoRoute(
        name: OurWorkPage.route,
        path: OurWorkPage.route,
        builder: (_, __) => const OurWorkPage(),
      ),
    ],
  );
}
