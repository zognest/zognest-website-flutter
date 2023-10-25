import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/home/pages/home_page.dart';
import 'package:zognest_website/features/our_services/pages/our_services_page.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/circle_button.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/zognest_logo.dart';

enum AppBarButtons {
  home(
    route: HomePage.route,
    title: Strings.home,
  ),
  ourServices(
    route: OurServicesPage.route,
    title: Strings.ourServices,
  ),
  ourWork(
    route: '+',
    title: Strings.ourWork,
  ),
  ourSpace(
    route: '+_',
    title: Strings.ourSpace,
  ),
  aboutUs(
    route: '.',
    title: Strings.aboutUs,
  );

  final String route;
  final String title;

  const AppBarButtons({required this.route, required this.title});
}

class PrimaryAppBar extends StatefulWidget {
  const PrimaryAppBar({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<PrimaryAppBar> createState() => _PrimaryAppBarState();
}

class _PrimaryAppBarState extends State<PrimaryAppBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _appBarAnimationController;
  late final Animation<Offset> _appBarOffsetAnimation;

  String hoveredRoute = '/';

  @override
  void initState() {
    super.initState();
    _appBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    final curvedAnimation = CurvedAnimation(
      parent: _appBarAnimationController,
      curve: Curves.ease,
    );
    _appBarOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1),
    ).animate(curvedAnimation);

    widget.scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    _appBarAnimationController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (widget.scrollController.offset <= Constants.appBarHeight) {
      _appBarAnimationController.reverse();
    }
    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      _appBarAnimationController.reverse();
    }
    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _appBarAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final route = GoRouterState.of(context);
    return SlideTransition(
      position: _appBarOffsetAnimation,
      child: FrostedContainer(
        width: double.infinity,
        height: Constants.appBarHeight,
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.s12,
          horizontal: Constants.pageHorizontalPadding,
        ),
        decoration: BoxDecoration(
          color: Palette.appBarBackground.withOpacity(0.6),
        ),
        child: Row(
          children: [
            const ZognestLogo(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: AppBarButtons.values.map(
                  (button) {
                    return InkWell(
                      onTap: () => context.go(button.route),
                      onHover: (hovered) {
                        if (hovered) {
                          hoveredRoute = button.route;
                          setState(() {});
                          return;
                        }
                        hoveredRoute = '/';
                        setState(() {});
                      },
                      overlayColor:
                          MaterialStateProperty.all(Palette.transparent),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 2000),
                        child: Text(
                          button.title.toUpperCase(),
                          style: route.name == button.route
                              ? theme.textTheme.labelLarge
                                  ?.copyWith(color: theme.primaryColor)
                              : theme.textTheme.labelMedium?.copyWith(
                                  color: hoveredRoute == button.route
                                      ? theme.primaryColor.withOpacity(0.7)
                                      : null,
                                ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            PrimaryButton(
              onTap: () {},
              title: Strings.getInTouch.toUpperCase(),
              trailing: CircleButton(child: SvgPicture.asset(Assets.mail)),
            ),
          ],
        ),
      ),
    );
  }
}
