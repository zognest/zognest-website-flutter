import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/features/our_space/widgets/zognest_events.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

class OurSpacePage extends HookWidget {
   OurSpacePage({super.key});

  static const route = '/our-space';



   final ScrollController _controller= ScrollController();




  void disposeHook() {
    _controller.dispose();
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
               SizedBox(height: Responsive.isDesktop(context)? Constants.appBarHeight * 1.5:56),
              const ZognestEvents(),
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
