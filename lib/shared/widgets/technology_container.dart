import 'package:flutter/material.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/spacing.dart';

class TechnologyContainer extends StatelessWidget {
  const TechnologyContainer({
    super.key,
    required this.image,
    required this.title,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(Spacing.m14),
          decoration: BoxDecoration(
            color: Palette.white,
            borderRadius: BorderRadius.circular(Spacing.s12),
          ),
          child: Image.asset(
            image,
            fit: BoxFit.contain,
            width: 25,
            height: 25,
          ),
        ),
        const SizedBox(height: Spacing.s8),
        Text(
          title.toUpperCase(),
          style: theme.textTheme.labelSmall,
        ),
      ],
    );
  }
}
