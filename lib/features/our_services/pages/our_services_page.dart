import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/features/our_services/widgets/services_browser.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

import '../models/purchasable_service.dart';

class OurServicesPage extends StatefulWidget {
  const OurServicesPage({super.key});

  static const route = '/our-services';

  @override
  State<OurServicesPage> createState() => _OurServicesPageState();
}

class _OurServicesPageState extends State<OurServicesPage> {
  late final ScrollController _controller;
  late final PurchasableService purchasable;
  final bool showAnimatedHeadline = false;

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
            SvgPicture.asset(Assets.gridLines),
            Column(
              children: [
                const SizedBox(height: Constants.appBarHeight * 1.5),
                const ServicesBrowser(),
                const SizedBox(height: Constants.sectionSpacing),
                Image.asset(
                  Assets.ourServicesText_2,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                const Divider(),
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
/* VisibilityDetector(
                    onVisibilityChanged: (info){
                      if (info.visibleFraction == 1) {
                        setState(() {
                          showAnimatedHeadline!=showAnimatedHeadline;
                        });
                      }
                      if (info.visibleFraction <= 0.5)  {
                        setState(() {
                          showAnimatedHeadline!=showAnimatedHeadline;
                        });
                      }
                    },
                    key: ValueKey(runtimeType.toString()),*/
