import 'package:flutter/material.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/resources/assets.dart';

class OptimismText extends StatelessWidget {
  const OptimismText({super.key});

  @override
  Widget build(BuildContext context) {
    /*final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);*/
    return Column(
      children: [
        const Divider(),
        Responsive.isDesktop(context)
            ? Image.asset(Assets.optimismTextWeb, fit: BoxFit.cover)
            : Image.asset(Assets.optimismTextMobile, fit: BoxFit.cover),
        const Divider(),
      ],
    );
  }
}
