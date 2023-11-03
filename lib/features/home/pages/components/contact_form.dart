import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/gradient_container.dart';
import 'package:zognest_website/shared/widgets/input_form_field.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

import '../../../../config/theme/text_theme.dart';

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: Constants.contactUsSectionHeight,
      child: Column(
        children: [
          const Divider(),
          Expanded(
            child: Stack(
              children: [
                GradientContainer(
                  color: theme.primaryColor,
                  alignment: const Alignment(-0.5, 0),
                  colorStartingOpacity: 0.3,
                  radius: 1,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SvgPicture.asset(Assets.impactLines),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.webHorizontalPadding,
                    vertical: Constants.webVerticalPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: Strings.get.toUpperCase(),
                                    style: theme.textTheme.displayMedium,
                                    children: [
                                      TextSpan(
                                        text:
                                            '${Strings.inText.toUpperCase()}\n',
                                        style: theme.textTheme.displayMedium
                                            ?.copyWith(
                                                foreground:
                                                    TextThemes.foreground),
                                      ),
                                      TextSpan(
                                          text: Strings.touch.toUpperCase()),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: Spacing.m20),
                                Text(
                                  Strings.contactDetails.toUpperCase(),
                                  style: theme.textTheme.headlineMedium
                                      ?.copyWith(color: theme.primaryColor),
                                ),
                                const SizedBox(height: Spacing.m20),
                                Text(
                                  Strings.address,
                                  style: theme.textTheme.bodyLarge,
                                ),
                                const SizedBox(height: Spacing.m20),
                                Text(
                                  Strings.contactInfo,
                                  style: theme.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: Spacing.l40),
                      SizedBox(
                        width: size.width * 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const InputFormField(hint: Strings.yourName),
                            const InputFormField(hint: Strings.yourEmail),
                            const InputFormField(hint: Strings.mobileNo),
                            const InputFormField(
                              hint: Strings.message,
                              required: false,
                              multiline: true,
                              keyboardType: TextInputType.multiline,
                            ),
                            const SizedBox(height: Spacing.l40),
                            Row(
                              children: [
                                Expanded(
                                  child: PrimaryButton(
                                    title: Strings.sendMessage.toUpperCase(),
                                    height: 75,
                                    textStyle:
                                        theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                                const SizedBox(width: Spacing.s12),
                                Expanded(
                                  child: PrimaryButton(
                                    title: Strings.requestCall.toUpperCase(),
                                    backgroundColor: Palette.white,
                                    height: 75,
                                    textStyle:
                                        theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
