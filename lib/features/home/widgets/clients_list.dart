import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/riverpod/controller.dart';

import '../../our_work/models/project.dart';

class ClientsMarquee extends ConsumerStatefulWidget {
  const ClientsMarquee({super.key});

  @override
  ConsumerState<ClientsMarquee> createState() => _ClientsMarqueeState();
}

class _ClientsMarqueeState extends ConsumerState<ClientsMarquee>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;

  double offset = 0.0;
  int hoveredIndex = -1;

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..addListener(animationListener);
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.removeListener(animationListener);
    _animationController.dispose();
    super.dispose();
  }

  void animationListener() {
    if (_animationController.isCompleted) _animationController.repeat();
    offset += 1.0;
    _scrollController.jumpTo(offset);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final project = ref.watch(appControllerProvider).projects;
    return project.when(
      data: (project) {
        return Column(
          children: [
            const Divider(),
            SizedBox(
              height: Responsive.isDesktop(context)
                  ? Constants.clientsMarqueeHeight
                  : Constants.mobileClientsMarqueeHeight,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(vertical: Spacing.s8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final i = index % project.length;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Spacing.m20),
                    child: InkWell(
                      onTap: () {},
                      onHover: (over) {
                        if (over) {
                          setState(() => hoveredIndex = i);
                          _animationController.stop(canceled: false);
                          return;
                        }
                        setState(() => hoveredIndex = -1);
                        _animationController.repeat();
                      },
                      overlayColor:
                          MaterialStateProperty.all(Palette.transparent),
                      child: ItemServiceMarquee(project: project[i]),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
          ],
        );
      },
      error: (_, __) => const Text('error'),
      loading: () => CircularProgressIndicator(color: theme.primaryColor),
    );
  }
}

class ItemServiceMarquee extends StatelessWidget {
  const ItemServiceMarquee({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        color: Palette.cardBackgroundColor,
        shape: StadiumBorder(
          side: BorderSide(color: Color(0xff3B3B3B)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FittedBox(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(120),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(project.icon),
              ),
            ),
            const SizedBox(width: 10),
            Text(project.title),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
