import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';

enum SocialButtons {
  discord(Assets.discord, ''),
  dribble(Assets.dribble, ''),
  facebook(Assets.facebook, ''),
  figma(Assets.figma, ''),
  instagram(Assets.instagram, ''),
  linkedin(Assets.linkedin, ''),
  pintrest(Assets.pintrest, ''),
  whatsapp(Assets.whatsapp, ''),
  youtube(Assets.youtube, '');

  final String icon, url;

  const SocialButtons(this.icon, this.url);
}

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.button});

  final SocialButtons button;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(Spacing.l24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Spacing.m20),
        border: Border.all(color: const Color(0xff43403A)),
      ),
      child: SvgPicture.asset(button.icon),
    );
  }
}
