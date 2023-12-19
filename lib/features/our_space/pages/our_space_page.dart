import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/features/our_space/widgets/zognest_events.dart';
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
      body: Stack(
        children: [
          SvgPicture.asset(Assets.gridLines),
          ListView(
            controller: _controller,
            children: [
              const SizedBox(height: Constants.appBarHeight * 1.5),
              ZognestEvents(events: Data.events),
              const SizedBox(height: Constants.sectionSpacing),
              Image.asset(Assets.ourSpaceText),
              const SizedBox(height: Constants.sectionSpacing),
              Footer(
                onTabUp: () => _controller.animateTo(
                  _controller.position.minScrollExtent,
                  duration:
                      const Duration(milliseconds: Constants.scrollToDuration),
                  curve: Curves.ease,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
