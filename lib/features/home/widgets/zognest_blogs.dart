import "dart:js" as js;

import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';
import 'package:zognest_website/shared/widgets/greyscale_filter.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';

import '../../../../resources/spacing.dart';
import '../../../shared/widgets/network_fading_image.dart';

class ZognestBlogs extends HookWidget {
  const ZognestBlogs({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = useScrollController();
    final currentIndex = useState(1);
    final showAnimatedHeadline = useState(true);
    final animationController = useAnimationController(duration: const Duration(seconds: 1));
    return Column(
      children: [
        const Divider(),
        AnimatedListItem(
          length: 1,
          key: ValueKey('${runtimeType.toString()} text'),
          animationType: AnimationType.slide,
          index: 0,
          aniController: animationController,
          child: ScrollHeadline(
            headline: TextSpan(
              children: [
                TextSpan(
                  text: '${Strings.our}\n'.toUpperCase(),
                  style: theme.textTheme.displaySmall?.copyWith(foreground: TextThemes.foreground),
                ),
                TextSpan(
                  text: Strings.blogs.toUpperCase(),
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
            showHeadline: showAnimatedHeadline.value,
            onTapScroll: () {
              if (controller.offset == controller.position.maxScrollExtent) {
                currentIndex.value = 0;
              }
              controller.animateTo(
                Constants.servicesCardWidth * currentIndex.value,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
              currentIndex.value++;
            },
          ),
        ),
        VisibilityDetector(
          onVisibilityChanged: (info) {
            if (info.visibleFraction >= 0.8) animationController.forward();
          },
          key: ValueKey('${runtimeType.toString()} List'),
          child: Consumer(builder: (context, ref, child) {
            final blogs = ref.watch(appControllerProvider).blogs;
            return blogs.when(
                data: (blogs) {
                  return SizedBox(
                    height: Responsive.isDesktop(context) ? Constants.listHeight : 450,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: Constants.horizontalPadding),
                      scrollDirection: Axis.horizontal,
                      controller: controller,
                      itemBuilder: (context, index) {
                        return AnimatedListItem(
                          aniController: animationController,
                          index: index,
                          length: blogs.length,
                          animationType: AnimationType.slide,
                          startX: 1,
                          child: BlogItem(
                            blog: blogs[index],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                          width: Responsive.isDesktop(context)
                              ? Constants.listCardSeparatorWidth
                              : Constants.listCardSeparatorWidthMobile),
                      itemCount: blogs.length,
                    ),
                  );
                },
                error: (_, __) => const SizedBox.shrink(),
                loading: () => const SizedBox.shrink());
          }),
        ),
        const Divider(),
      ],
    );
  }
}

class BlogItem extends HookWidget {
  const BlogItem({
    super.key,
    required this.blog,
  });
  final Blog blog;
  @override
  Widget build(BuildContext context) {
    final hovered = useState(false);
    final theme = Theme.of(context);
    return FrostedContainer(
      width: Responsive.isDesktop(context) ? Constants.listCardWidth : 300,
      borderRadius: 25,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.l24,
        vertical: Spacing.l24,
      ),
      child: InkWell(
        onHover: (over) => hovered.value = over,
        onTap: () => js.context.callMethod('open', [blog.urlLink]),
        overlayColor: WidgetStateProperty.all(Palette.transparent),
        child: GreyscaleFilter(
          isHovered: hovered.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GreyscaleFilter(
                  isHovered: hovered.value,
                  child: Card(
                    clipBehavior: Clip.hardEdge,
                    child: NetworkFadingImage(
                      width: double.infinity,
                      path: blog.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blog.title,
                      style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: hovered.value ? Palette.white : theme.primaryColor,
                          fontFamily: 'SF Pro Rounded'),
                    ),
                    Text(
                      DateFormat('MMMM dd, yyyy').format(blog.date),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.primaryColor,
                        fontFamily: 'SF Pro Rounded',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
