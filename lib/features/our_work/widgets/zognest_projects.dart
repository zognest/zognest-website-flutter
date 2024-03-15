import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/our_work/models/project.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

import '../../../config/theme/text_theme.dart';
import '../../../shared/widgets/network_fading_image.dart';
import '../../../shared/widgets/scroll_headline.dart';

class ZognestProjects extends StatefulWidget {
  const ZognestProjects({super.key});

  @override
  State<ZognestProjects> createState() => _ZognestProjectsState();
}

class _ZognestProjectsState extends State<ZognestProjects> {
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
    final controller = useScrollController();
    final currentIndex = useState(1);
    final showAnimatedHeadline = useState(false);
    final theme = Theme.of(context);
    return Column(
      children: [
        if (Responsive.isDesktop(context)) const Divider(),
        VisibilityDetector(
          onVisibilityChanged: (info) {
            if (info.visibleFraction == 1) showAnimatedHeadline.value = true;
            if (info.visibleFraction <= 0.5) showAnimatedHeadline.value = false;
          },
          key: ValueKey(runtimeType.toString()),
          child: ScrollHeadline(
            headline: TextSpan(
              text: Strings.our.toUpperCase(),
              style: theme.textTheme.displaySmall,
              children: [
                TextSpan(
                  text: Strings.best.toUpperCase(),
                  style: theme.textTheme.displaySmall?.copyWith(
                    foreground: TextThemes.foreground,
                  ),
                ),
                TextSpan(
                    text: Strings.projects.toUpperCase(),
                    style: theme.textTheme.displaySmall
                ),
              ],
            ),
            showHeadline: showAnimatedHeadline.value,
            onTapScroll: () {
              if (controller.offset ==
                  controller.position.maxScrollExtent) {
                currentIndex.value = 0;
              }
              controller.animateTo(
                Constants.zognestOffersItemWidth * currentIndex.value,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.ease,
              );
              currentIndex.value++;
            },
          ),),
        Consumer(builder: (context, ref, _) {
          final project = ref.watch(appControllerProvider).projects;
          return project.when(
              data: (project) {
                return SizedBox(
                  height: Constants.listHeight,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Constants.horizontalPadding,
                    ),
                    scrollDirection: Axis.horizontal,
                    controller: _controller,
                    itemBuilder: (context, index) {
                      return ProjectItem(project: project[index]);
                    },
                    separatorBuilder: (context, index) =>
                         SizedBox(width: Responsive.isDesktop(context)
                            ? Constants.listCardSeparatorWidth
                            : Constants.listCardSeparatorWidthMobile),
                    itemCount: project.length,
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

class ProjectItem extends StatefulWidget {
  const ProjectItem({super.key, required this.project});

  final Project project;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  bool over = false;
  bool ontap = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double widthMobile =
        Responsive.isMobile(context) || Responsive.isTablet(context)
            ? 290 * (ontap ? 1.5 : 1)
            : Constants.listCardWidth * (over ? 2 : 1);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
      width: Responsive.isDesktop(context)
          ? Constants.listCardWidth * (over ? 2 : 1)
          : widthMobile,
      height: Constants.projectHeight,
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: InkWell(
          onTap: () {},
          onHover: (over) => setState(() => this.over = over),
          child: Stack(
            children: [
              ShaderMask(
                // image
                blendMode: BlendMode.srcATop,
                shaderCallback: (bounds) {
                  return LinearGradient(
                    colors: [
                      Palette.transparent,
                      theme.scaffoldBackgroundColor.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: over ? Alignment.bottomCenter : Alignment.center,
                  ).createShader(
                    Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                  );
                },
                child: NetworkFadingImage(
                  path: widget.project.cover,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Spacing.l32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    NetworkFadingImage(path: widget.project.icon, width: 60,height: 60,),
                    const SizedBox(height: Spacing.l32),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.project.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontFamily: 'SF Pro Rounded',
                              fontSize: 32,
                            ),
                          ),
                        ),
                        if (over)
                          PrimaryButton(
                            title: Strings.visit.toUpperCase(),
                            width: Constants.listCardWidth * 0.3,
                            padding: const EdgeInsets.symmetric(
                              horizontal: Constants.listButtonHorizontalPadding,
                              vertical: Constants.listButtonVerticalPadding,
                            ),
                            onTap: () {},
                          ),
                      ],
                    ),
                    const SizedBox(height: Spacing.s4),
                    Text(
                      widget.project.brief,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.primaryColor,
                        fontFamily: 'SF Pro Rounded',
                      ),
                    ),
                    const SizedBox(height: Spacing.m16),
                    Expanded(
                      flex: over ? 5 : 1,
                      child: Text(
                        widget.project.description,
                        maxLines: over ? null : 2,
                        overflow: over ? null : TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                            fontFamily: 'SF Pro Rounded',
                            fontSize: Responsive.isDesktop(context) ? 20 : 16),
                      ),
                    ),
                    if (!over) ...[
                      const SizedBox(height: Spacing.l32),
                      PrimaryButton(
                        title: Strings.more.toUpperCase(),
                        filled: true,
                        width: Constants.listCardWidth * 0.3,
                        padding: const EdgeInsets.symmetric(
                          horizontal: Constants.listButtonHorizontalPadding,
                          vertical: Constants.listButtonVerticalPadding,
                        ),
                        onTap: () {
                         setState(() {
                           ontap=!ontap;
                         });
                        },
                      ),
                    ]
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
