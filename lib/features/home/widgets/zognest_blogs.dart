import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/models/blog.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';
import 'package:zognest_website/shared/widgets/greyscale_filter.dart';
import 'package:zognest_website/shared/widgets/scroll_headline.dart';

import '../../../../resources/spacing.dart';

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
        SizedBox(
          height: Constants.listHeight,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.isDesktop(context)
                  ? Constants.webHorizontalPadding
                  : Constants.mobileHorizontalPadding,
            ),
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemBuilder: (context, index) {
              final i = index % Data.blogs.length;
              final client = Data.blogs[i];
              return BlogItem(blog: client);
            },
            separatorBuilder: (context, index) =>
                const SizedBox(width: Constants.listCardSeparatorWidth),
            itemCount: 10,
          ),
        ),
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
      width:
          Constants.listCardWidth,
      padding: const EdgeInsets.symmetric(
          horizontal: Spacing.l32, vertical: Spacing.l24),
      child: InkWell(
        onTap: () {},
        onHover: (over) {
          setState(() => hovered = !hovered);
        },
        overlayColor: MaterialStateProperty.all(Palette.transparent),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreyscaleFilter(
              isHovered: hovered,
              child: Image.asset(widget.blog.image, fit: BoxFit.cover),
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
                    ),
                  ),
                  Text(
                    DateFormat('MMMM dd, yyyy').format(widget.blog.date),
                    style: theme.textTheme.labelMedium
                        ?.copyWith(color: theme.primaryColor),
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
