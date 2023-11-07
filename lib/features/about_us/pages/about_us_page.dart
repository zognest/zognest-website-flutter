import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/features/about_us/pages/components/team_description.dart';
import 'package:zognest_website/features/about_us/pages/components/zognest_staff.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

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
    final double sectionSpacing = Responsive.isDesktop(context)
        ? Constants.webSectionSpacing
        : Constants.mobileSectionSpacing;
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const PrimaryDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _controller,
            child: Stack(
              children: [
                SvgPicture.asset(Assets.gridLines),
                Column(
                  children: [
                    const SizedBox(height: Constants.appBarHeight),
                    const TeamDescription(),
                    SizedBox(height: sectionSpacing),
                    const ZognestStaff(),
                    SizedBox(height: sectionSpacing),
                    Image.asset(
                      Responsive.isDesktop(context)
                          ? Assets.aboutUsText
                          : Assets.mobileAboutUsText,
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      height: Responsive.isDesktop(context)
                          ? Constants.webSectionSpacing
                          : Spacing.s0,
                    ),
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
          PrimaryAppBar(scrollController: _controller),
        ],
      ),
    );
  }
}
