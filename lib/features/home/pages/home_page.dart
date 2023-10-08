import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/home/widgets/beyond_space.dart';
import 'package:zognest_website/features/home/widgets/clients_list.dart';
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
    final theme = Theme.of(context);
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
                    Stack(
                      children: [
                        SizedBox(
                          height: _controller.hasClients
                              ? _controller.position.maxScrollExtent * 0.4
                              : size.height,
                          child: const Stack(
                            children: [
                              GradientContainer(
                                alignment: Alignment(-0.6, -0.3),
                                color: Palette.primaryGradient,
                                secondaryColor: Palette.secondaryGradient,
                              ),
                              GradientContainer(
                                alignment: Alignment(0.6, -0.3),
                                color: Palette.secondaryGradient,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: _controller.hasClients
                                ? _controller.position.maxScrollExtent * 0.2
                                : 0,
                          ),
                          child: SvgPicture.asset(
                            Assets.gridLines,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Column(
                  children: [
                    BeyondSpace(),
                    SizedBox(height: Constants.sectionSpacing),
                    ClientsList(),
                    SizedBox(height: Constants.sectionSpacing),
                    ZognestVideo(),
                    SizedBox(
                      height: 3000,
                      child: Placeholder(),
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
