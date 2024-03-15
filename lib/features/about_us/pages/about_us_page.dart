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
   const AboutUsPage({super.key});
  static const route = '/about-us';
  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
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
                  const ImageText(
                    title: true,
                    isAboutus: true,
                    image: Assets.zognestTeam,
                    hasGradient: true,
                  ),
                  const SizedBox(height: Constants.sectionSpacing),
                   ZognestStaff(),
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
