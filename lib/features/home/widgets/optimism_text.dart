import 'package:flutter/material.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/resources/assets.dart';

class OptimismText extends StatelessWidget {
  const OptimismText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Responsive.isDesktop(context)
            ? Image.asset(Assets.optimismTextWeb, fit: BoxFit.cover)
            : Image.asset(Assets.optimismTextMobile, fit: BoxFit.cover),

      ],
    );
  }
}
