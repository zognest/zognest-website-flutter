import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
import 'package:zognest_website/features/home/widgets/zognest_animation.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/strings.dart';
class ZognestMocks extends StatefulWidget {
  const ZognestMocks({super.key});

  @override
  State<ZognestMocks> createState() => _ZognestMocksState();
}

class _ZognestMocksState extends State<ZognestMocks>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    final curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.ease,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-2, 0),
      end: const Offset(-0.45, 0),
    ).animate(curvedAnimation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Divider(),
            VisibilityDetector(
              key: ValueKey(runtimeType.toString()),
              onVisibilityChanged: (info) {
                if (info.visibleFraction >= 0.8) {
                  _animationController.forward();
                }
              },
              child: SlideTransition(
                position: _offsetAnimation,
                child: Image.asset(
                  Assets.screens_2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
          ],
        ),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            FloatingIcon(
              isHorizontal: false,
              assets: Assets.mercury,
              alignment: Alignment.centerRight,
              width: size.width * 0.45,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding),
              child: SizedBox(
                width:
                    size.width * (Responsive.isDesktop(context) ? 0.45 : 0.4),
                child: FittedBox(
                  child: Text.rich(
                    textAlign: TextAlign.right,
                    maxLines: 4,
                    TextSpan(
                      text: '\t${Strings.weGiveWingz.toUpperCase()}',
                      style: theme.textTheme.displayMedium,
                      children: [
                        TextSpan(
                          text: '${Strings.to.toUpperCase()}\n',
                          style: theme.textTheme.displayMedium?.copyWith(
                            foreground: TextThemes.foreground,
                          ),
                        ),
                        TextSpan(text: Strings.yourBusiness.toUpperCase()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
