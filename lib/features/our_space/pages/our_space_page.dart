import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/features/our_space/pages/components/zognest_events.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

class OurSpacePage extends StatefulWidget {
  const OurSpacePage({super.key});

  static const route = '/our-space';

  @override
  State<OurSpacePage> createState() => _OurSpacePageState();
}

class _OurSpacePageState extends State<OurSpacePage> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void scrollListener() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const PrimaryDrawer(),
      body: Stack(
        children: [
          Stack(
            children: [
              SvgPicture.asset(Assets.gridLines),
              ListView(
                controller: _controller,
                shrinkWrap: true,
                children: [
                  const SizedBox(height: Constants.appBarHeight),
                  ZognestEvents(events: Data.events),
                  SizedBox(
                    height: Responsive.isDesktop(context)
                        ? Constants.webSectionSpacing
                        : Constants.mobileSectionSpacing,
                  ),
                  Image.asset(Assets.ourSpaceText),
                  SizedBox(
                    height: Responsive.isDesktop(context)
                        ? Constants.webSectionSpacing
                        : Constants.mobileSectionSpacing,
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
          PrimaryAppBar(scrollController: _controller),
        ],
      ),
    );
  }
}
