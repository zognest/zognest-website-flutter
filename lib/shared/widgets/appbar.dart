import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/about_us/pages/about_us_page.dart';
import 'package:zognest_website/features/home/pages/home_page.dart';
import 'package:zognest_website/features/home/widgets/contact_form.dart';
import 'package:zognest_website/features/our_services/pages/our_services_page.dart';
import 'package:zognest_website/features/our_space/pages/our_space_page.dart';
import 'package:zognest_website/features/our_work/pages/our_work_page.dart';
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
    route: OurWorkPage.route,
    title: Strings.ourWork,
  ),
  ourSpace(
    route: OurSpacePage.route,
    title: Strings.ourSpace,
  ),
  aboutUs(
    route: AboutUsPage.route,
    title: Strings.aboutUs,
  );

  final String route;
  final String title;

  const AppBarButtons({required this.route, required this.title});
}

class PrimaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PrimaryAppBar({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  State<PrimaryAppBar> createState() => _PrimaryAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(Constants.appBarHeight);
}

class _PrimaryAppBarState extends State<PrimaryAppBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _appBarAnimationController;
  late final Animation<Offset> _appBarOffsetAnimation;
  late final ScrollController _controller;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String hoveredRoute = '/';

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
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
    _controller.dispose();
    _appBarAnimationController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (widget.scrollController.offset <= Constants.appBarHeight ||
        widget.scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
      _appBarAnimationController.reverse();
      return;
    }

    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _appBarAnimationController.forward();
    }
  }

  bool over = false;

  @override
  Widget build(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    final route = GoRouterState.of(context);
    return SlideTransition(
      position: _appBarOffsetAnimation,
      child: FrostedContainer(
        width: double.infinity,
        height: Constants.appBarHeight,
        padding: const EdgeInsets.symmetric(
          vertical: Spacing.s12,
          horizontal: Constants.horizontalPadding,
        ),
        decoration: BoxDecoration(
          color: Palette.appBarBackground.withOpacity(0.6),
        ),
        child: Responsive.appBar(context)
            ? const MobileAppBar()
            : Row(
                children: [
                  const ZognestLogo(),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: AppBarButtons.values.map(
                        (button) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Spacing.m16),
                            child: InkWell(
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
                              overlayColor: MaterialStateProperty.all(
                                  Palette.transparent),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 2000),
                                child: Text(
                                  button.title.toUpperCase(),
                                  style: route.name == button.route
                                      ? theme.textTheme.labelLarge
                                          ?.copyWith(color: theme.primaryColor)
                                      : theme.textTheme.labelMedium?.copyWith(
                                          color: hoveredRoute == button.route
                                              ? theme.primaryColor
                                                  .withOpacity(0.7)
                                              : null,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  //button get in touch
                  PrimaryButton(
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Palette.cardBackgroundColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Palette.dividerColor),
                            ),
                            child: SingleChildScrollView(child: ContactForm()),
                          ),
                        ),
                      );
                    },
                    title: Strings.getInTouch.toUpperCase(),
                    trailing:
                        CircleButton(child: SvgPicture.asset(Assets.mail)),
                  ),
                ],
              ),
      ),
    );
  }
}

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ZognestLogo(),
        const Spacer(),
        const Spacer(),
        InkWell(
          onTap: () {
            if (Scaffold.of(context).isDrawerOpen) {
              Scaffold.of(context).closeDrawer();
              return;
            }
            Scaffold.of(context).openDrawer();
          },
          child: SvgPicture.asset(Assets.drawer),
        ),
      ],
    );
  }
}
