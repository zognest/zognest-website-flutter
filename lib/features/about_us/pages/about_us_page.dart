import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/features/about_us/widgets/zognest_staff.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';
import 'package:zognest_website/shared/widgets/image_text.dart';

import '../../../config/theme/text_theme.dart';
import '../../../resources/strings.dart';
import '../../../shared/widgets/mouse_animation.dart';
import '../../../shared/widgets/scroll_headline.dart';

class AboutUsPage extends HookWidget {
   AboutUsPage({super.key});
  static const route = '/about-us';
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
              SvgPicture.asset(Assets.gridLines),
              Column(
                children: [
                  const SizedBox(height: Constants.appBarHeight * 1.5),
                  const ImageTextAboutUs(
                    image: Assets.zognestTeam,
                    hasGradient: true,
                  ),
                  const SizedBox(height: Constants.sectionSpacing),
                  VisibilityDetector(
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction == 1) showAnimatedHeadline.value = true;
                      if (info.visibleFraction <= 0.5) showAnimatedHeadline.value = false;
                    },
                    key: ValueKey(runtimeType.toString()),
                    child: ScrollHeadline(
                      headline: TextSpan(
                        text:'',
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
                  const ZognestStaff(),
                  const SizedBox(height: Constants.sectionSpacing),
                  const Divider(),
                  Image.asset(
                    Responsive.isDesktop(context)
                        ? Assets.aboutUsText
                        : Assets.mobileAboutUsText,
                    width: double.infinity,
                    alignment: Alignment.bottomCenter,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: Constants.sectionSpacing),
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
