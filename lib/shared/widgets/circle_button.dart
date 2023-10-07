import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zognest_website/config/theme/palette.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.asset,
    this.onTap,
  });

  final String asset;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () {},
      overlayColor: MaterialStateProperty.all(Palette.transparent),
      child: CircleAvatar(
        backgroundColor: Palette.white,
        child: SvgPicture.asset(asset),
      ),
    );
  }
}
