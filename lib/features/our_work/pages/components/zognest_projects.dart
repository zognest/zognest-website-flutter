import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/our_work/models/project.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

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
    final theme = Theme.of(context);
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Constants.pageHorizontalPadding,
            vertical: Spacing.l40,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: Strings.our.toUpperCase(),
                      style: theme.textTheme.displaySmall,
                    ),
                    TextSpan(
                      text: Strings.best.toUpperCase(),
                      style: theme.textTheme.displaySmall
                          ?.copyWith(foreground: TextThemes.foreground),
                    ),
                    TextSpan(
                      text: Strings.projects.toUpperCase(),
                      style: theme.textTheme.displaySmall,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (_controller.offset ==
                      _controller.position.maxScrollExtent) {
                    currentIndex = 0;
                  }
                  _controller.animateTo(
                    Constants.projectBaseWidth * currentIndex,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.ease,
                  );
                  currentIndex++;
                },
                overlayColor: MaterialStateProperty.all(Palette.transparent),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          // textScaleFactor: TextThemes.textScale(context),
                          Strings.scroll.toUpperCase(),
                          style: theme.textTheme.displaySmall
                              ?.copyWith(fontSize: 54),
                        ),
                        Text(
                          '${Data.projects.length} Projects'.toUpperCase(),
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.primaryColor,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: Spacing.l24),
                    Image.asset(Assets.arrowRight),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Constants.projectHeight,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.pageHorizontalPadding),
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemBuilder: (context, index) {
                final i = index % Data.projects.length;
                final project = Data.projects[i];
                return ProjectItem(project: project);
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(width: Spacing.l24),
              itemCount: 10,
            ),
          ),
        ),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 1000),
      curve: Curves.fastOutSlowIn,
      width: over ? Constants.projectExtendedWidth : Constants.projectBaseWidth,
      height: Constants.projectHeight,
      child: InkWell(
        onTap: () {},
        onHover: (over) => setState(() => this.over = over),
        child: Stack(
          children: [
            ShaderMask(
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
              child: Image.asset(
                widget.project.image,
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
                  const Spacer(flex: 2),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(widget.project.icon),
                          const SizedBox(height: Spacing.l32),
                          Text(
                            widget.project.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelLarge
                                ?.copyWith(fontSize: 32),
                          ),
                          const SizedBox(height: Spacing.s4),
                          Text(
                            widget.project.brief,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelMedium
                                ?.copyWith(color: theme.primaryColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      if (over)
                        PrimaryButton(
                          title: Strings.visit.toUpperCase(),
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Spacing.s12,
                            vertical: Spacing.m20,
                          ),
                          onTap: () {},
                        ),
                    ],
                  ),
                  const SizedBox(height: Spacing.m16),
                  Expanded(
                    child: Text(
                      widget.project.description,
                      maxLines: over ? null : 3,
                      overflow: over ? null : TextOverflow.ellipsis,
                    ),
                  ),
                  if (!over) ...[
                    const SizedBox(height: Spacing.l32),
                    PrimaryButton(
                      title: Strings.more.toUpperCase(),
                      filled: false,
                      width: 100,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.s12,
                        vertical: Spacing.m20,
                      ),
                      onTap: () {},
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
