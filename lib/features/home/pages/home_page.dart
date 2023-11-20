import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/home/pages/components/beyond_space.dart';
import 'package:zognest_website/features/home/pages/components/clients_list.dart';
import 'package:zognest_website/features/home/pages/components/contact_form.dart';
import 'package:zognest_website/features/home/pages/components/counters.dart';
import 'package:zognest_website/features/home/pages/components/marquee_text.dart';
import 'package:zognest_website/features/home/pages/components/optimism_text.dart';
import 'package:zognest_website/features/home/pages/components/zognest_blogs.dart';
import 'package:zognest_website/features/home/pages/components/zognest_clients.dart';
import 'package:zognest_website/features/home/pages/components/zognest_description.dart';
import 'package:zognest_website/features/home/pages/components/zognest_mocks.dart';
import 'package:zognest_website/features/home/pages/components/zognest_offers.dart';
import 'package:zognest_website/features/home/pages/components/zognest_services.dart';
import 'package:zognest_website/features/home/pages/components/zognest_video.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

import '../../../shared/widgets/gradient_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const PrimaryDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _controller,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: _controller.hasClients
                          ? _controller.position.maxScrollExtent * 0.22
                          : size.height * 4,
                      child: Stack(
                        children: [
                          const Stack(
                            children: [
                              GradientContainer(
                                alignment: Alignment(-0.6, -0.7),
                                color: Palette.primaryGradient,
                                secondaryColor: Palette.secondaryGradient,
                              ),
                              GradientContainer(
                                alignment: Alignment(0.6, -0.7),
                                color: Palette.secondaryGradient,
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 0,
                            child: SvgPicture.asset(Assets.gridLines),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(Assets.mercuries),
                    const SizedBox(
                        height: Constants.backgroundDecorationSpacing),
                    SvgPicture.asset(Assets.gridLines),
                    const SizedBox(
                        height: Constants.backgroundDecorationSpacing),
                    SvgPicture.asset(Assets.gridLines),
                  ],
                ),
                Foreground(controller: _controller),
              ],
            ),
          ),
          PrimaryAppBar(scrollController: _controller),
        ],
      ),
    );
  }
}

class Foreground extends StatelessWidget {
  const Foreground({super.key, required this.controller});

  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    // print(Theme.of(context).platform.name);
    final platform = Theme.of(context).platform;
    return Column(
      children: [
        /*(platform == TargetPlatform.windows ||
                platform == TargetPlatform.macOS ||
                platform == TargetPlatform.linux)*/
        Responsive.isDesktop(context)
            ? BeyondSpace(
                onTabDown: () => controller.animateTo(
                  controller.position.maxScrollExtent,
                  duration:
                      const Duration(milliseconds: Constants.scrollToDuration),
                  curve: Curves.ease,
                ),
              )
            : const BeyondSpaceMobile(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing * 0,
        ),
        const ClientsMarquee(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const ZognestVideo(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        Responsive.isDesktop(context)
            ? const ZognestDescription()
            : const ZognestDescriptionMobile(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        Responsive.isDesktop(context)
            ? const ZognestOffers()
            : const ZognestOffersMobile(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const MarqueeText(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const OptimismText(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const Counters(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const ZognestServices(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const ZognestMocks(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const ZognestClients(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const MarqueeText(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const ZognestBlogs(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        const ContactForm(),
        SizedBox(
          height: Responsive.isDesktop(context)
              ? Constants.webSectionSpacing
              : Constants.mobileSectionSpacing,
        ),
        Footer(
          onTabUp: () => controller.animateTo(
            controller.position.minScrollExtent,
            duration: const Duration(milliseconds: Constants.scrollToDuration),
            curve: Curves.ease,
          ),
        ),
      ],
    );
  }
}
