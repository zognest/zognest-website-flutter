import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/features/our_work/widgets/our_work_text.dart';
import 'package:zognest_website/features/our_work/widgets/zognest_projects.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

import '../../../config/theme/text_theme.dart';
import '../../../resources/strings.dart';
import '../../../shared/widgets/mouse_animation.dart';
import '../../../shared/widgets/scroll_headline.dart';

class OurWorkPage extends HookWidget {
   OurWorkPage({super.key});

  static const route = '/our-work';

    late final ScrollController controller;


  void initState() {

    controller = ScrollController();
  }


  void dispose() {
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final currentIndex = useState(1);
    final hoveredIndex = useState(-1);
    final showAnimatedHeadline = useState(false);
    final theme = Theme.of(context);
    return  Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(scrollController: controller),
      drawer: const PrimaryDrawer(),
      body: SingleChildScrollView(
        controller: controller,
        child: Stack(
          children: [
            Positioned(
              top: Constants.projectHeight,
              child: SvgPicture.asset(Assets.gridLines),
            ),
            Column(
              children: [
                SizedBox(
                  height: Constants.appBarHeight *
                      (Responsive.isDesktop(context) ? 1.5 : 1.1),
                ),
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
                const Align(
                    alignment:Alignment.topCenter ,
                    child: ZognestProjects()),
                const SizedBox(height: Constants.sectionSpacing),
                const OurWorkText(),
                 SizedBox(height:Responsive.isDesktop(context)? 25:Constants.sectionSpacing,),
                Footer(
                  onTabUp: () => controller.animateTo(
                    controller.position.minScrollExtent,
                    duration: const Duration(
                        milliseconds: Constants.scrollToDuration),
                    curve: Curves.ease,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
        );
  }
}
