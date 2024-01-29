import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/theme/palette.dart';
import '../../../resources/spacing.dart';
import '../../../resources/strings.dart';
import '../../../riverpod/controller.dart';
import '../../../shared/widgets/input_form_field.dart';
import '../../../shared/widgets/primary_button.dart';

class ServicesCartMobile extends StatelessWidget {
  const ServicesCartMobile({super.key});

  // todo ask him about this
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        const Divider(),
        // all section
        SizedBox(
          height: 1100, // height all section
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              // Constants.mobileHorizontalPadding
            ),
            child: Column(
              children: [
                // section 1 card
                Consumer(builder: (context, ref, child) {
                  final cartServices =
                      ref.watch(appControllerProvider).cartServices;
                  return Expanded(
                    flex: 1,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: const Color(0xffAEB2BA)),
                                ),
                                padding: const EdgeInsets.all(12),
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    runSpacing: Spacing.m20,
                                    spacing: Spacing.m20,
                                    // what is this ? what do it this ?
                                    children: cartServices.map((service) {
                                      return Container(
                                        width: double.infinity,
                                        color: Palette.cardBackgroundColor,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Image.network(
                                                service.image,
                                                height: 140,
                                                width: 75,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                children: [
                                                  const SizedBox(width: 10),
                                                  AutoSizeText(
                                                    service.title,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: theme
                                                        .textTheme.bodyLarge
                                                        ?.copyWith(
                                                      fontFamily: 'SF Pro Rounded',
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Palette.transparent,
                                                  shape: const CircleBorder(
                                                    side: BorderSide(
                                                        color: Palette.white),
                                                  ),
                                                  minimumSize:
                                                      const Size.fromRadius(28),
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  size: 14,
                                                ),
                                                onPressed: () {
                                                  ref
                                                      .read(
                                                          appControllerProvider
                                                              .notifier)
                                                      .removeService(service);
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],),
                  );
                }),
                // between 1 and2
                const SizedBox(height: 50),
                // section 2
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const InputFormField(
                        hint: Strings.yourName,
                        required: false,
                        keyboardType: TextInputType.name,
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: InputFormField(
                              hint: Strings.yourEmail,
                              required: false,
                              keyboardType: TextInputType.emailAddress,
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: InputFormField(
                              hint: Strings.mobileNo,
                              required: false,
                              keyboardType: TextInputType.phone,
                            ),
                          ),
                        ],
                      ),
                      const InputFormField(
                        hint: Strings.budget,
                        required: false,
                        keyboardType: TextInputType.text,
                      ),
                      const InputFormField(
                        hint: Strings.message,
                        required: true,
                        multiline: true,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: [
                          Expanded(
                            child: PrimaryButton(
                              title: Strings.sendMessage.toUpperCase(),
                              height: 45,
                              textStyle: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              onTap: () {},
                            ),
                          ),
                          const SizedBox(width: Spacing.s8),
                          Expanded(
                            child: PrimaryButton(
                              title: Strings.requestCall.toUpperCase(),
                              height: 45,
                              textStyle: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
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
        ),

        const Divider(),
      ],
    );
  }
}
