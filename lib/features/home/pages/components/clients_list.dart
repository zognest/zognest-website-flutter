import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/data.dart';

class ClientsList extends StatefulWidget {
  const ClientsList({super.key});

  @override
  State<ClientsList> createState() => _ClientsListState();
}

class _ClientsListState extends State<ClientsList>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _animationController;

  double offset = 0.0;
  int hoveredIndex = -1;

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(animationListener);
    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.removeListener(animationListener);
    _animationController.dispose();
    super.dispose();
  }

  void animationListener() {
    if (_animationController.isCompleted) _animationController.repeat();
    offset += 1.0;
    _scrollController.jumpTo(offset);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        SizedBox(
          height: Spacing.xl72,
          child: Center(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: Spacing.s8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final i = index % Data.clientsImageAssets.length;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.l40),
                  child: InkWell(
                    onTap: () {},
                    onHover: (over) {
                      if (over) {
                        setState(() => hoveredIndex = i);
                        _animationController.stop(canceled: false);
                      }
                      if (!over) {
                        setState(() => hoveredIndex = -1);
                        _animationController.repeat();
                      }
                    },
                    overlayColor:
                        MaterialStateProperty.all(Palette.transparent),
                    child: Image.asset(
                      Data.clientsImageAssets[i],
                      color: hoveredIndex == i ? Palette.primary : null,
                      colorBlendMode: BlendMode.srcIn,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
