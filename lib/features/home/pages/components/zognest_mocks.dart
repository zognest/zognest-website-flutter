import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/text_theme.dart';
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
      begin: const Offset(1, 0),
      end: const Offset(-0.6, 0),
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
    return VisibilityDetector(
      key: ValueKey(runtimeType.toString()),
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 0.8) _animationController.forward();
      },
      child: SizedBox(
        height: Constants.mocksSectionHeight,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            SlideTransition(
              position: _offsetAnimation,
              child: Image.asset(
                Assets.screens,
                height: Constants.mocksSectionHeight * 0.9,
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(),
                SizedBox(height: Constants.mocksSectionHeight * 0.9),
                Divider(),
              ],
            ),
            Image.asset(
              Assets.mercury,
              alignment: Alignment.centerRight,
              height: Constants.mocksSectionHeight,
              width: size.width * 0.4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.pageHorizontalPadding),
              child: SizedBox(
                width: size.width * 0.5,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FittedBox(
                    child: Text.rich(
                      textAlign: TextAlign.right,
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                      TextSpan(
                        text: '\t${Strings.weGiveWingz.toUpperCase()}',
                        style: theme.textTheme.displayMedium,
                        children: [
                          TextSpan(
                            text: Strings.to.toUpperCase(),
                            style: theme.textTheme.displayMedium
                                ?.copyWith(foreground: TextThemes.foreground),
                          ),
                          TextSpan(text: Strings.yourBusiness.toUpperCase()),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
