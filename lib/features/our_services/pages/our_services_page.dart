import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/features/our_services/widgets/services_browser.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/riverpod/controller.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';
import 'package:zognest_website/shared/widgets/drawer.dart';
import 'package:zognest_website/shared/widgets/footer.dart';

import '../../../config/theme/palette.dart';
import '../models/purchasable_service.dart';

class OurServicesPage extends ConsumerStatefulWidget {
  const OurServicesPage({super.key});

  static const route = '/our-services';


  @override
  ConsumerState<OurServicesPage> createState() => _OurServicesPageState();
}

class _OurServicesPageState extends ConsumerState<OurServicesPage> {
  late final ScrollController _controller;
   late final PurchasableService purchasable;

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
    final purchasableService =
        ref.watch(appControllerProvider).purchasableService;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PrimaryAppBar(scrollController: _controller),
      drawer: const PrimaryDrawer(),
      body: SingleChildScrollView(
        controller: _controller,
        child: Stack(
          children: [
            SvgPicture.asset(Assets.gridLines),
            purchasableService.when(
              data: (purchasableService) {
                return  Column(
                  children: [
                    const SizedBox(height: Constants.appBarHeight * 1.5),
                    const ServicesBrowser(),
                    const SizedBox(height: Constants.sectionSpacing),
                    const Divider(),
                    Image.asset(Assets.ourServicesText),
                    Footer(
                      onTabUp: () => _controller.animateTo(
                        _controller.position.minScrollExtent,
                        duration: const Duration(
                            milliseconds: Constants.scrollToDuration),
                        curve: Curves.ease,
                      ),
                    ),
                  ],
                );
              },
              error: (_, __) => const Text('error'),
              // todo if i make theme.primaryColor ; display error so i make this
              loading: () =>
                  const CircularProgressIndicator(color: Palette.primary),
            ),
            // const CreateOrder(),

          ],
        ),
      ),
    );
  }
}
