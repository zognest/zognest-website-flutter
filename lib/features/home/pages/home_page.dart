import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/home/widgets/contact_form.dart';
import 'package:zognest_website/features/home/widgets/marquee_text.dart';
import 'package:zognest_website/features/home/widgets/zognest_blogs.dart';
import 'package:zognest_website/features/home/widgets/zognest_clients.dart';
import 'package:zognest_website/features/home/widgets/zognest_mocks.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

import '../../../config/responsive.dart';
import '../../../shared/widgets/gradient_container.dart';
import '../../../shared/widgets/image_text.dart';
import '../widgets/beyond_space.dart';
import '../widgets/clients_list.dart';
import '../widgets/counters.dart';
import '../widgets/optimism_text.dart';
import '../widgets/zognest_offers.dart';
import '../widgets/zognest_services.dart';
import '../widgets/zognest_video.dart';

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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(scrollController: _controller),
      drawer: const PrimaryDrawer(),
      body: SingleChildScrollView(
        controller: _controller,
        child: Stack(
          children: [
            const Background(),
            Foreground(
              onTabDown: () {
                _controller.animateTo(
                  _controller.position.maxScrollExtent,
                  duration:
                      const Duration(milliseconds: Constants.scrollToDuration),
                  curve: Curves.ease,
                );
              },
              onTabUp: () {
                _controller.animateTo(
                  _controller.position.minScrollExtent,
                  duration:
                      const Duration(milliseconds: Constants.scrollToDuration),
                  curve: Curves.ease,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset(Assets.gridLines),
        Column(
          children: [
            const SizedBox(
              height: Constants.bgDecorationSpacing,
              child: Stack(
                children: [
                  GradientContainer(
                    alignment: Alignment(-0.4, 0),
                    color: Palette.primaryGradient,
                    colorStartingOpacity: 0.3,
                    radius: 0.5,
                    secondaryColor: Palette.secondaryGradient,
                    secondaryAlignment: Alignment(-0.6, -0.2),
                  ),
                  GradientContainer(
                    alignment: Alignment(0.6, 0),
                    color: Palette.secondaryGradient,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Constants.bgDecorationSpacing),
            Image.asset(Assets.mercuries),
            const SizedBox(height: Constants.bgDecorationSpacing),
            SvgPicture.asset(Assets.gridLines),
            const SizedBox(height: Constants.bgDecorationSpacing),
            SvgPicture.asset(Assets.gridLines),
          ],
        ),
      ],
    );
  }
}

class Foreground extends StatelessWidget {
  const Foreground({super.key, required this.onTabDown, required this.onTabUp});

  final VoidCallback onTabDown;
  final VoidCallback onTabUp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Constants.appBarHeight * 1.5),
        BeyondSpace(onTabDown: onTabDown),
        const SizedBox(height: Constants.sectionSpacing),
        const ClientsMarquee(),
        const SizedBox(height: Constants.sectionSpacing),
        const ZognestVideo(),
        const SizedBox(height: Constants.sectionSpacing),
        const ImageText(image: Assets.office),
        const SizedBox(height: Constants.sectionSpacing),
        Responsive.isDesktop(context)
            ? const ZognestOffers()
            : const ZognestOffersMobile(),
        const SizedBox(height: Constants.sectionSpacing),
        const MarqueeText(),
        const SizedBox(height: Constants.sectionSpacing),
        const OptimismText(),
        const SizedBox(height: Constants.sectionSpacing),
        const Counters(),
        const SizedBox(height: Constants.sectionSpacing),
        const ZognestServices(),
        const SizedBox(height: Constants.sectionSpacing),
        const ZognestMocks(),
        const SizedBox(height: Constants.sectionSpacing),
        const ZognestClients(),
        const SizedBox(height: Constants.sectionSpacing),
        const MarqueeText(),
        const SizedBox(height: Constants.sectionSpacing),
        const ZognestBlogs(),
        const SizedBox(height: Constants.sectionSpacing),
        ContactForm(),
        const SizedBox(height: Constants.sectionSpacing),
        Footer(onTabUp: onTabUp),
      ],
    );
  }
}
