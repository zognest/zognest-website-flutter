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
            const ServicesCart(),
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

class ServiceItem extends ConsumerStatefulWidget {
  const ServiceItem({super.key, required this.service});

  final PurchasableService service;

  @override
  ConsumerState<ServiceItem> createState() => _ServiceItemState();
}

class _ServiceItemState extends ConsumerState<ServiceItem> {
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
                    widget.service.title,
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
                    widget.service.description,
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
                    onTap: () {
                      ref.watch(appControllerProvider).cartServices.isEmpty
                          ? const ServicesCart()
                          : const SizedBox();
                      ref
                          .read(appControllerProvider.notifier)
                          .addService(widget.service);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: NetworkFadingImage(
              path: widget.service.image,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesCart extends StatelessWidget {
  const ServicesCart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.webHorizontalPadding),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Wrap(
              runSpacing: Spacing.s8,
              spacing: Spacing.s8,
              children: [
                SizedBox(
                  width: width * 0.25,
                  height: 120,
                  child: Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          'assets/images/office.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: Spacing.m20),
                      AutoSizeText(
                        'service.title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Palette.white,
                        ),
                      ),
                      const SizedBox(height: Spacing.m20),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.black,
                            shape: const CircleBorder(
                                side: BorderSide(color: Palette.white)),
                          ),
                          child: const Icon(
                            Icons.close,
                            weight: 100,
                            size: 25,
                            color: Palette.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: Column(
              children: [
                const InputFormField(
                  hint: Strings.yourName,
                  required: false,
                  keyboardType: TextInputType.name,
                ),
                const InputFormField(
                  hint: Strings.yourEmail,
                  required: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                const InputFormField(
                  hint: Strings.mobileNo,
                  required: false,
                  keyboardType: TextInputType.phone,
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
                        height: 70,
                        textStyle: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        onTap: () {},
                      ),
                    ),
                    const SizedBox(width: Spacing.s8),
                    Expanded(
                      child: PrimaryButton(
                        title: Strings.requestCall.toUpperCase(),
                        height: 70,
                        textStyle: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
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
    );
  }
}
