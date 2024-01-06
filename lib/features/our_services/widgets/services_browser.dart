import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/our_services/models/purchasable_service.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';
import '../../../riverpod/controller.dart';
import '../../../shared/widgets/circle_button.dart';
import '../../../shared/widgets/input_form_field.dart';
import '../../../shared/widgets/network_fading_image.dart';

class ServicesBrowser extends ConsumerStatefulWidget {
  const ServicesBrowser({super.key});

  @override
  ConsumerState<ServicesBrowser> createState() => _ServicesBrowserState();
}

class _ServicesBrowserState extends ConsumerState<ServicesBrowser> {
  @override
  Widget build(BuildContext context) {
    final purchasableService =
        ref.watch(appControllerProvider).purchasableServices;
    final theme = Theme.of(context);
    return purchasableService.when(
      data: (purchasableServices) {
        return Column(
          children: [
            if (Responsive.isDesktop(context)) const Divider(),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.isDesktop(context)
                    ? Constants.webHorizontalPadding
                    : Constants.mobileHorizontalPadding,
              ),
              child: Wrap(
                runSpacing: Constants.listCardSeparatorWidth,
                spacing: Constants.listCardSeparatorWidth,
                children: purchasableServices.map((service) {
                  return SizedBox(
                    height: Responsive.isDesktop(context)
                        ? Constants.servicesBrowserItemHeight
                        : Constants.mobileServicesBrowserItemHeight,
                    width: Constants.servicesBrowserItemWidth,
                    child: ServiceItem(service: service),
                  );
                }).toList(),
              ),
            ),
            const Divider(),
          ],
        );
      },
      error: (_, __) => const Text('error'),
      loading: () => CircularProgressIndicator(color: theme.primaryColor),
    );
  }
}

class ServiceItem extends StatelessWidget {
  const ServiceItem({super.key, required this.service});

  final PurchasableService service;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: Palette.cardBackgroundColor,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Spacing.m20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //title
                  AutoSizeText(
                    service.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.primaryColor,
                    ),
                  ),
                  // between title and description
                  const SizedBox(height: Spacing.s8),
                  // description
                  AutoSizeText(
                    service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall,
                  ),
                  const Spacer(),
                  PrimaryButton(
                    title: Strings.add,
                    textStyle: theme.textTheme.labelLarge,
                    width: Constants.servicesBrowserItemWidth * 0.2,
                    padding: const EdgeInsets.symmetric(
                      vertical: Constants.listButtonVerticalPadding,
                      horizontal: Constants.listButtonHorizontalPadding,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: NetworkFadingImage(
              path: service.image,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionGetInTouch extends StatelessWidget {
  const _SectionGetInTouch({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
        children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const InputFormField(
                hint: Strings.yourName,
                required: false,
                keyboardType: TextInputType.name,
              ),
              const Row(
                children: [
                  InputFormField(
                    hint: Strings.yourEmail,
                    required: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  InputFormField(
                    hint: Strings.mobileNo,
                    required: false,
                    keyboardType: TextInputType.phone,
                  ),
                ],
              ),
              const InputFormField(
                hint: Strings.Budget,
                required: true,
                multiline: true,
                // i cant know what is budget ? but i choose multiline,because is not number is name
                keyboardType: TextInputType.multiline,
              ),
              const InputFormField(
                hint: Strings.message,
                required: true,
                multiline: true,
                keyboardType: TextInputType.multiline,
              ),
              const SizedBox(height: Spacing.m20),
              Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      title: Strings.sendMessage.toUpperCase(),
                      height: 50,
                      textStyle: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        /*color: Palette.primary*/
                      ),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: Spacing.s12),
                  Expanded(
                    child: PrimaryButton(
                      title: Strings.requestCall.toUpperCase(),
                      backgroundColor: Palette.white,
                      height: 50,
                      textStyle: theme.textTheme.bodyLarge?.copyWith(
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
      ),
      Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
        children: [
            Expanded(
              child: Image.asset(
                'assets/images/screens.png',
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: Spacing.m20),
            AutoSizeText(
              'service.title',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: Spacing.m20),
            Expanded(
              child: CircleButton(
                radius: Spacing.l32,
                child: IconButton(
                  color: Palette.black,
                  icon: const Icon(Icons.close,color: Palette.white,),
                  onPressed: () {},
                ),
              ),
            ),
        ],
      ),
          ))
    ]
    );
  }
}
