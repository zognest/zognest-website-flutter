import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/about_us/models/staff.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/flipping_widget.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import 'package:zognest_website/shared/widgets/technology_container.dart';

import '../../../config/theme/text_theme.dart';
import '../../../shared/widgets/network_fading_image.dart';
import '../../../shared/widgets/scroll_headline.dart';

class ZognestStaff extends HookWidget {
   const ZognestStaff({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController =
    useAnimationController(duration: const Duration(seconds: 1));
    final controller = useScrollController();
    final currentIndex = useState(1);
    final showAnimatedHeadline = useState(true);
    final theme = Theme.of(context);
    return Column(
      children: [
        AnimatedListItem(
          length: 1,
          key: ValueKey('${runtimeType.toString()} text'),
          animationType: AnimationType.slide,
          index:0,
          aniController:animationController,
          child: ScrollHeadline(
            headline: TextSpan(
              text: '',
              style: theme.textTheme.displaySmall?.copyWith(),
              children: [
                TextSpan(
                  text: '${Strings.our.toUpperCase()}\n',
                  style: theme.textTheme.displaySmall?.copyWith(
                    foreground: TextThemes.foreground,
                  ),
                ),
                TextSpan(
                  text: Strings.birds.toUpperCase(),
                  style: theme.textTheme.displaySmall?.copyWith(),
                ),
              ],
            ),
            showHeadline: showAnimatedHeadline.value,
            onTapScroll: () {
              if (controller.offset == controller.position.maxScrollExtent) {
                currentIndex.value = 0;
              }
              controller.animateTo(
                Constants.zognestOffersItemWidth * currentIndex.value,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
              currentIndex.value++;
            },
          ),
        ),
        const Divider(),
        VisibilityDetector(
          onVisibilityChanged: (info) {
            if (info.visibleFraction >= 0.8) animationController.forward();
          },
          key: ValueKey('${runtimeType.toString()} List'),
          child: Consumer(builder: (__, ref, _) {
            final staff = ref.watch(appControllerProvider).staff;
            return staff.when(
                data: (staff) {
                  return SizedBox(
                    height: Constants.listHeight,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.horizontalPadding),
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return AnimatedListItem(
                          index: index,
                          length: staff.length,
                          aniController: animationController,
                          animationType: AnimationType.slide,
                          startX: 1,
                          child: SizedBox(
                            width: Responsive.isDesktop(context)
                                ? Constants.listCardWidth
                                : 300,
                            child: Card(
                              color: Palette.transparent,
                              clipBehavior: Clip.antiAlias,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25)),
                              ),
                              child: FlippingWidget(
                                front: FrontCard(staff: staff[index]),
                                back: BackCard(staff: staff[index]),
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(width: Responsive.isDesktop(context) ? 16 : 6),
                      itemCount: staff.length,
                    ),
                  );
                },
                error: (_, __) => const Text('error'),
                loading: () =>
                    CircularProgressIndicator(color: theme.primaryColor));
          }),
        ),
        const Divider(),
      ],
    );
  }
}

class FrontCard extends StatelessWidget {
  const FrontCard({super.key, required this.staff});

  final Staff staff;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Palette.transparent,
      child: Column(
        children: [
          Expanded(
            child: Card(
              clipBehavior: Clip.hardEdge,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
              ),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                child: NetworkFadingImage(
                  path: staff.avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.l24,
                vertical: Spacing.l24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          staff.name.toUpperCase(),
                          style: theme.textTheme.headlineLarge?.copyWith(
                              fontSize: 32, fontFamily: 'SF Pro Rounded'),
                        ),
                        Text(
                          staff.position.toUpperCase(),
                          style: theme.textTheme.labelMedium?.copyWith(
                              color: theme.primaryColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'SF Pro Rounded'),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Spacing.m14,
                            ),
                            child: Text(
                              staff.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                color: Palette.transparent,
                                fontSize:
                                    Responsive.isDesktop(context) ? 20 : 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  PrimaryButton(
                    title: Strings.more.toUpperCase(),
                    filled: false,
                    width: Constants.listCardWidth * 0.3,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.listButtonHorizontalPadding,
                      vertical: Constants.listButtonVerticalPadding,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BackCard extends StatelessWidget {
  const BackCard({super.key, required this.staff});

  final Staff staff;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Palette.transparent,
      child: Stack(
        children: [
          Opacity(
            opacity: 0.2,
            child: ColoredBox(
              color: Colors.transparent,
              child: NetworkFadingImage(
                path: staff.avatar,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Spacing.l24,
              vertical: Spacing.l24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        staff.name.toUpperCase(),
                        style: theme.textTheme.headlineLarge?.copyWith(
                            fontSize: 32, fontFamily: 'SF Pro Rounded'),
                      ),
                      Text(
                        staff.position.toUpperCase(),
                        style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SF Pro Rounded'),
                      ),
                      const SizedBox(height: Spacing.m20),
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          padding:
                              const EdgeInsets.symmetric(vertical: Spacing.s12),
                          child: Wrap(
                            runSpacing: Spacing.s8,
                            spacing: Spacing.s8,
                            children: staff.technologies.map((tech) {
                              return TechnologyContainer(
                                image: tech.image,
                                title: tech.name,
                                isPng: tech.isPng,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
               /* PrimaryButton(
                  title: Strings.linkedIn.toUpperCase(),
                  width: Constants.listCardWidth * 0.3,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.listButtonHorizontalPadding,
                    vertical: Constants.listButtonVerticalPadding,
                  ),
                  onTap: () => js.context.callMethod('open', [staff.url]),
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
