import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/resources/assets.dart';

class OurWorkText extends StatelessWidget {
  const OurWorkText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context)
                ? Constants.webHorizontalPadding
                : Constants.mobileHorizontalPadding,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                Assets.venusMercury,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Image.asset(Assets.textGroup),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
