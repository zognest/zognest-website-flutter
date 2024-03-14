import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';

class ZognestLogo extends StatelessWidget {
  const ZognestLogo({
    super.key,
    this.iconOnly = false,
    this.size,
  });

  final bool iconOnly;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.zognestLogoPng,
          fit: BoxFit.cover,
          height: size,
          width: size,
        ),
        if (!iconOnly) ...[
          const SizedBox(width: Spacing.s4),
          const ZognestText(),
        ],
      ],
    );
  }
}
// DODO https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Fdodo.png?alt=media&token=1a34674c-effd-4c5a-bcfb-719ea3463566
//Owl https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Fowl.png?alt=media&token=81d95aee-e8de-425c-9c72-96530803f12b
// Osprey https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Fosprey.png?alt=media&token=a58a8aac-0253-42a8-b306-fb623662d682
// PHOENIX https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Fphoenix.png?alt=media&token=8a8b067b-7145-4521-8c99-97a04f53c6bc
// Goldfinch https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Fgoldfinch.png?alt=media&token=c00780b0-507c-4fae-a8b2-3d1294506d9b
// Ostrich https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Fostrich.png?alt=media&token=350df941-51a4-4bd4-add7-07aa6d3f1adb
// Eagle https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Feagle.png?alt=media&token=f34963aa-ee72-455a-a605-82daacefc75d
// Red Lory https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Fred_lory.png?alt=media&token=59968736-e628-4f01-91b8-2f01228da478
// Rio https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Frio.png?alt=media&token=070db1f3-1179-4b9c-ae79-11f9856671aa
//Sparrow https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Fsparrow.png?alt=media&token=a6468141-80fd-44ef-96ba-e48553b7bed8
// Shikra https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/staff%2Fshikra.png?alt=media&token=215c0393-2700-457a-a9e4-4ca21462d7bf
class ZognestText extends StatelessWidget {
  const ZognestText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      Strings.textZognest,
      style: theme.textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.w900,
        fontSize: 44,
        color: Palette.primary,
        fontFamily: 'SF Pro Rounded',
      ),
    );
  }
}
