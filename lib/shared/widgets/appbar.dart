import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/circle_button.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/zognest_logo.dart';

enum AppBarButtons {
  home(
    route: '',
    title: Strings.home,
  ),
  ourServices(
    route: '',
    title: Strings.ourServices,
  ),
  ourWork(
    route: '',
    title: Strings.ourWork,
  ),
  ourSpace(
    route: '',
    title: Strings.ourSpace,
  ),
  aboutUs(
    route: '',
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
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -1),
    ).animate(curvedAnimation);
    widget.scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      _animationController.reverse();
    }
    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Constants.webHorizontalPadding,
          vertical: Spacing.l32,
        ),
        child: Container(
          width: double.infinity,
          height: Spacing.xl72,
          padding: const EdgeInsets.all(Spacing.s12),
          decoration: ShapeDecoration(
            color: Palette.appBarBackground.withOpacity(0.6),
            shape: StadiumBorder(
              side: BorderSide(
                color: Palette.white.withOpacity(0.2),
                width: 2,
              ),
            ),
          ),
          child: Row(
            children: [
              const ZognestLogo(),
              const Spacer(),
              SizedBox(
                width: size.width * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: AppBarButtons.values.map(
                    (button) {
                      return InkWell(
                        onHover: (hovered) {},
                        onTap: () {},
                        overlayColor:
                            MaterialStateProperty.all(Palette.transparent),
                        child: Text(
                          button.title.toUpperCase(),
                          style: theme.textTheme.labelLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              PrimaryButton(
                onTap: () {},
                title: Strings.getInTouch.toUpperCase(),
                trailing: const CircleButton(asset: Assets.whatsAppLogo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
