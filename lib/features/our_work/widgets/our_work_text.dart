import 'package:flutter/material.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/shared/widgets/animation_image.dart';

class OurWorkText extends StatelessWidget {
  const OurWorkText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10),
          child: Stack(
            children: [
              Image.asset(Responsive.isDesktop(context)?
                Assets.venusMercury:Assets.ourProjectMobile,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
              // venus_mercury
            ],
          ),
        ),
      ],
    );
  }
}
