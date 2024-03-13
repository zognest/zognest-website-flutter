import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/riverpod/controller.dart';

import '../../our_work/models/project.dart';

class ClientsMarquee extends HookConsumerWidget {
  const ClientsMarquee({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hoveredIndex = useState(-1);
    final offset = useState(0.0);
    final scrollController = useScrollController();
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 3000),
    );
    useEffect(
      () {
        void animationListener() {
          if (animationController.isCompleted) animationController.repeat();
          offset.value += 1.0;
          if (scrollController.hasClients) {
            scrollController.jumpTo(offset.value);
          }
        }

        animationController.addListener(animationListener);
        animationController.forward();

        return () => animationController.removeListener(animationListener);
      },
      [],
    );
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
                controller: scrollController,
                padding: const EdgeInsets.symmetric(vertical: Spacing.s8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final i = index % project.length;
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: Spacing.m14),
                    child: InkWell(
                      onTap: () {},
                      onHover: (over) {
                        if (over) {
                          hoveredIndex.value = i;
                          animationController.stop(canceled: false);
                          return;
                        }
                        hoveredIndex.value = -1;
                        animationController.repeat();
                      },
                      overlayColor:
                          MaterialStateProperty.all(Palette.transparent),
                      child: ItemServiceMarquee(
                        project: project[i],
                        isHovering: hoveredIndex.value == i,
                      ),
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
  const ItemServiceMarquee({
    super.key,
    required this.project,
    required this.isHovering,
  });

  final Project project;
  final bool isHovering;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: isHovering ? Palette.primary : Palette.cardBackgroundColor,
        shape: const StadiumBorder(
          side: BorderSide(color: Color(0xff3B3B3B)),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(120),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(project.icon),
            ),
            const SizedBox(width: 10),
            Text(
              project.title,
              style:
                  TextStyle(color: isHovering ? Palette.black : Palette.white),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
