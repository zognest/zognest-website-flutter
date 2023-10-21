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
      onTap: () {},
      onHover: (_) => setState(() => hovering = !hovering),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Container(
        height: 100,
        width: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(Spacing.s12),
        decoration: BoxDecoration(
          color: hovering ? theme.primaryColor : null,
          borderRadius: BorderRadius.circular(Spacing.m20),
          border: Border.all(color: const Color(0xff43403A)),
        ),
        child: SvgPicture.asset(widget.button.icon),
      ),
    );
  }
}
