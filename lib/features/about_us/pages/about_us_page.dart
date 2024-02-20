import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/features/about_us/widgets/zognest_staff.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';
import 'package:zognest_website/shared/widgets/image_text.dart';

class AboutUsPage extends HookWidget {
   AboutUsPage({super.key});

  static const route = '/about-us';
    late final ScrollController _controller= ScrollController();

  void disposeHook() {
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(scrollController: _controller),
      drawer: const PrimaryDrawer(),
      body: SingleChildScrollView(
        controller: _controller,
        child: Stack(
          children: [
            SvgPicture.asset(Assets.gridLines),
            Column(
              children: [
                const SizedBox(height: Constants.appBarHeight * 1.5),
                const ImageText(
                  image: Assets.zognestTeam,
                  hasGradient: true,
                ),
                const SizedBox(height: Constants.sectionSpacing),
                 ZognestStaff(),
                const SizedBox(height: Constants.sectionSpacing),
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
                  onTabUp: () => _controller.animateTo(
                    _controller.position.minScrollExtent,
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

