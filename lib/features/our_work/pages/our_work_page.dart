import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/features/our_work/widgets/our_work_text.dart';
import 'package:zognest_website/features/our_work/widgets/zognest_projects.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

class OurWorkPage extends StatefulWidget {
  const OurWorkPage({super.key});

  static const route = '/our-work';

  @override
  State<OurWorkPage> createState() => _OurWorkPageState();
}

class _OurWorkPageState extends State<OurWorkPage> {
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
            Positioned(
              top: Constants.projectHeight,
              child: SvgPicture.asset(Assets.gridLines),
            ),
            Column(
              children: [
                SizedBox(
                  height: Constants.appBarHeight *
                      (Responsive.isDesktop(context) ? 1.5 : 1),
                ),
                const ZognestProjects(),
                const SizedBox(height: Constants.sectionSpacing),
                const OurWorkText(),
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
