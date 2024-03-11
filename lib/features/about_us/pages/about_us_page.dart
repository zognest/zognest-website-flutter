import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/features/about_us/widgets/zognest_staff.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';
import 'package:zognest_website/shared/widgets/image_text.dart';

import '../../../resources/strings.dart';
import '../../../shared/widgets/mouse_animation.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  static const route = '/about-us';

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  late final ScrollController _controller;

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
    return AnimatedMouse(
      scaffold: Scaffold(
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
                  const ImageTextAboutUs(
                    image: Assets.zognestTeam,
                    hasGradient: true,
                  ),
                  const SizedBox(height: Constants.sectionSpacing),
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
      ),
    );
  }
}
