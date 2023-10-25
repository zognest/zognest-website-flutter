import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/features/our_services/pages/components/create_order.dart';
import 'package:zognest_website/features/our_services/pages/components/services_browser.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/home_footer.dart';

class OurServicesPage extends StatefulWidget {
  const OurServicesPage({super.key});

  static const route = '/our-services';

  @override
  State<OurServicesPage> createState() => _OurServicesPageState();
}

class _OurServicesPageState extends State<OurServicesPage> {
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
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _controller,
            child: Stack(
              children: [
                SvgPicture.asset(Assets.gridLines),
                Column(
                  children: [
                    const SizedBox(height: Constants.appBarHeight * 1.5),
                    const SizedBox(height: Constants.sectionSpacing),
                    const ServicesBrowser(),
                    const SizedBox(height: Constants.sectionSpacing),
                    const CreateOrder(),
                    WebFooter(
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
