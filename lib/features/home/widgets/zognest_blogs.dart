import "dart:js" as js;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class ZognestBlogs extends StatefulWidget {
  const ZognestBlogs({super.key});

  @override
  State<ZognestBlogs> createState() => _ZognestBlogsState();
}

class _ZognestBlogsState extends State<ZognestBlogs> {
  late final ScrollController _controller;
  int currentIndex = 1;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

class BlogItem extends StatefulWidget {
  const BlogItem({
    super.key,
    required this.blog,
  });

  final Blog blog;

  @override
  State<BlogItem> createState() => _BlogItemState();
}

class _BlogItemState extends State<BlogItem> {
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
        onTap: () => js.context.callMethod('open', [widget.blog.urlLink]),

        overlayColor: MaterialStateProperty.all(Palette.transparent),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GreyscaleFilter(
                isHovered: true,
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  child: NetworkFadingImage(
                    width: double.infinity,
                    path: widget.blog.image,
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
                    widget.blog.title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SF Pro Rounded'),
                  ),
                  Text(
                    DateFormat('MMMM dd, yyyy').format(widget.blog.date),
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
