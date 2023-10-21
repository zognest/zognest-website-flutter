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
    return Container(
      decoration: const ShapeDecoration(
        shape: StadiumBorder(),
        color: Palette.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.s12,
        vertical: Spacing.s8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xffF5F5F5)),
            ),
            padding: const EdgeInsets.all(Spacing.s4),
            child: Image.asset(
              image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: Spacing.s8),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelMedium?.copyWith(
              fontFamily: 'SF Pro Rounded',
              color: const Color(0xff0A0A0A),
            ),
          ),
        ],
      ),
    );
  }
}
