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
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.all(Spacing.s12),
            decoration: BoxDecoration(
              color: Palette.white,
              borderRadius: BorderRadius.circular(Spacing.s12),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: Spacing.s8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              fontFamily: 'SF Pro Rounded',
              letterSpacing: 0,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
