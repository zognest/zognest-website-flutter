// ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';

enum SocialButtons {
  discord(Assets.discord, 'https://discord.com/invite/d67h3B2a'),
  dribble(Assets.dribble, 'https://dribbble.com/zognest'),
  facebook(Assets.facebook, 'https://www.facebook.com/zognest/'),
  figma(Assets.figma, 'https://www.figma.com/@zognest'),
  instagram(Assets.instagram, 'https://www.instagram.com/zognest/'),
  linkedin(Assets.linkedin, 'https://www.linkedin.com/company/83480728/'),
  pintrest(Assets.pintrest, 'https://pin.it/5TNhVve'),
  whatsapp(Assets.whatsapp, 'https://chat.whatsapp.com/CM2zNeZqZ7MEEreQXP8cMO'),
  youtube(Assets.youtube, 'https://www.youtube.com/@zognest');

  final String icon, url;

  const SocialButtons(this.icon, this.url);
}

class SocialButton extends StatefulWidget {
  const SocialButton({super.key, required this.button});

  final SocialButtons button;

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        js.context.callMethod('open', [widget.button.url]);
      },
      onHover: (_) => setState(() => hovering = !hovering),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        height: Responsive.isDesktop(context) ? 100 : 50,
        width: Responsive.isDesktop(context) ? 100 : 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Spacing.s12),
        decoration: BoxDecoration(
          color: hovering ? theme.primaryColor : null,
          borderRadius: BorderRadius.circular(Spacing.m16),
          border: Border.all(color: const Color(0xff43403A)),
        ),
        child: SvgPicture.asset(widget.button.icon),
      ),
    );
  }
}
