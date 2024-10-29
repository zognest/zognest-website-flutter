// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:animated_list_item/animated_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';

enum SocialButtons {
  medium(
    Assets.medium,
    'https://medium.com/',
  ),
  dribble(Assets.dribble, 'https://dribbble.com/zognest'),
  facebook(Assets.facebook, 'https://www.facebook.com/zognest/'),
  figma(Assets.figma, 'https://www.figma.com/@zognest'),
  instagram(Assets.instagram, 'https://www.instagram.com/zognest/'),
  linkedin(Assets.linkedin, 'https://www.linkedin.com/company/83480728/'),
  whatsapp(Assets.whatsapp, 'https://chat.whatsapp.com/CM2zNeZqZ7MEEreQXP8cMO'),
  youtube(Assets.youtube, 'https://www.youtube.com/@zognest');

  final String icon, url;

  const SocialButtons(
    this.icon,
    this.url,
  );
}

class SocialButton extends HookWidget {
  const SocialButton({super.key, required this.button});

  final SocialButtons button;

  @override
  Widget build(BuildContext context) {
    final hovering = useState(false);
    final animationController =
        useAnimationController(duration: const Duration(milliseconds: 500));
    final theme = Theme.of(context);
    useEffect(() {
      animationController.value = animationController.upperBound;
      return null;
    }, []);
    return InkWell(
      onTap: () {
        js.context.callMethod('open', [button.url]);
      },
      onHover: (_) async {
        hovering.value = !hovering.value;
        if (hovering.value) {
          await animationController.forward(
              from: animationController.lowerBound);
        }
      },
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        height: Responsive.isDesktop(context) ? 100 : 38,
        width: Responsive.isDesktop(context) ? 100 : 38,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Spacing.s12),
        decoration: BoxDecoration(
          color: hovering.value ? theme.primaryColor : null,
          borderRadius: BorderRadius.circular(Spacing.m16),
          border: Border.all(color: const Color(0xff43403A)),
        ),
        child: AnimatedListItem(
          aniController: animationController,
          length: 1,
          index: 0,
          animationType: AnimationType.slide,
          startY: -10,
          startX: 0,
          child: SvgPicture.asset(button.icon),
        ),
      ),
    );
  }
}
