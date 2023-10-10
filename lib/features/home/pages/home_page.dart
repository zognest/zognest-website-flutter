import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/home/widgets/beyond_space.dart';
import 'package:zognest_website/features/home/widgets/clients_list.dart';
import 'package:zognest_website/features/home/widgets/zognest_description.dart';
import 'package:zognest_website/features/home/widgets/zognest_offers.dart';
import 'package:zognest_website/features/home/widgets/zognest_video.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/appbar.dart';

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
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _controller,
            child: Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: _controller.hasClients
                          ? _controller.position.maxScrollExtent * 0.42
                          : size.height * 3,
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
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset(
                        Assets.mercuries,
                        // width: size.width * 0.3,
                      ),
                    ),
                  ],
                ),
                const Foreground(),
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
  const Foreground({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        BeyondSpace(),
        SizedBox(height: Constants.sectionSpacing),
        ClientsList(),
        SizedBox(height: Constants.sectionSpacing),
        ZognestVideo(),
        SizedBox(height: Constants.sectionSpacing),
        ZognestDescription(),
        SizedBox(height: Constants.sectionSpacing),
        ZognestOffers(),
        SizedBox(
          height: 3000,
          child: Placeholder(),
        ),
      ],
    );
  }
}
