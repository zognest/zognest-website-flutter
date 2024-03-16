import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/features/our_work/widgets/our_work_text.dart';
import 'package:zognest_website/features/our_work/widgets/zognest_projects.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

class OurWorkPage extends HookWidget {
  const OurWorkPage({super.key});

  static const route = '/our-work';
  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return Scaffold(
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
                const Align(
                  alignment: Alignment.topCenter,
                  child: ZognestProjects(),
                ),
                const SizedBox(height: Constants.sectionSpacing),
                const OurWorkText(),
                SizedBox(
                  height: Responsive.isDesktop(context)
                      ? 25
                      : Constants.sectionSpacing,
                ),
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
