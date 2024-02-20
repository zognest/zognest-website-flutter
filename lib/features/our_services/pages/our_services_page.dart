import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/features/our_services/widgets/services_browser.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

import '../../../config/responsive.dart';
import '../models/purchasable_service.dart';

class OurServicesPage extends HookConsumerWidget {
   OurServicesPage({super.key});

  static const route = '/our-services';




  late final ScrollController _controller = ScrollController();
  late final PurchasableService purchasable;




  void dispose() {
    _controller.dispose();

  }

  @override
  Widget build(BuildContext context,ref) {
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
                const Divider(),
                Image.asset(
                  Responsive.isDesktop(context)
                      ? Assets.ourServicesText
                      : Assets.ourServicesText_2,
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
            // const CreateOrder(),
          ],
        ),
      ),
    );
  }
}
