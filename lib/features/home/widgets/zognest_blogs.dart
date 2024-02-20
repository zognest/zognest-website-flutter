import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
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
import "dart:js" as js;

class ZognestBlogs extends HookConsumerWidget {
   ZognestBlogs({super.key});



   final ScrollController _controller= ScrollController();
  int currentIndex = 1;


  void disposeHook() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    return Column(
      children: [
        const Divider(),
        ScrollHeadline(
          headline: TextSpan(
            children: [
              TextSpan(
                text: '${Strings.our}\n'.toUpperCase(),
                style: theme.textTheme.displaySmall
                    ?.copyWith(foreground: TextThemes.foreground),
              ),
              TextSpan(
                text: Strings.blogs.toUpperCase(),
                style: theme.textTheme.displaySmall,
              ),
            ],
          ),
          onTapScroll: () {
            if (_controller.offset == _controller.position.maxScrollExtent) {
              currentIndex = 0;
            }
            _controller.animateTo(
              Constants.blogsItemWidth * currentIndex,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.ease,
            );
            currentIndex++;
          },
        ),
        Consumer(builder: (context, ref, child) {
          final blogs = ref.watch(appControllerProvider).blogs;
          return blogs.when(
              data: (blogs) {
                return SizedBox(
                  height: Responsive.isDesktop(context)
                      ? Constants.listHeight
                      : 450,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Constants.horizontalPadding),
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return BlogItem(blog: blogs[index]);
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
        const Divider(),
      ],
    );
  }
}

class BlogItem extends HookWidget {
   BlogItem({
    super.key,
    required this.blog,
  });

  final Blog blog;



  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FrostedContainer(
      width: Responsive.isDesktop(context) ? Constants.listCardWidth : 300,
      borderRadius: 25,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.l24,
        vertical: Spacing.l24,
      ),
      child: InkWell(
        onTap: () => js.context.callMethod('open', [blog.urlLink]),

        overlayColor: MaterialStateProperty.all(Palette.transparent),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GreyscaleFilter(
                isHovered: true,
                child: Card(
                  clipBehavior: Clip.antiAlias,
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
    );
  }
}
