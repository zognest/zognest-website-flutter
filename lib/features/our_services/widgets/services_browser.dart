import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/our_services/models/purchasable_service.dart';
import 'package:zognest_website/features/our_services/widgets/service_card_mobile.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

import '../../../riverpod/controller.dart';
import '../../../shared/widgets/input_form_field.dart';
import '../../../shared/widgets/network_fading_image.dart';
 //todo ask him about this
class ServicesBrowser extends ConsumerStatefulWidget {
  const ServicesBrowser({super.key});

  @override
  ConsumerState<ServicesBrowser> createState() => _ServicesBrowserState();
}

late  PurchasableService service;

class _ServicesBrowserState extends ConsumerState<ServicesBrowser> {
  @override
  Widget build(BuildContext context) {
    final purchasableService =
        ref.watch(appControllerProvider).purchasableServices;
    final servicesCart = ref.watch(appControllerProvider).cartServices;
    final theme = Theme.of(context);
    return purchasableService.when(
      data: (purchasableServices) {
        return Column(
          children: [
            if (servicesCart.isNotEmpty) ...[
              Responsive.isDesktop(context) ? const ServicesCart() :const ServicesCartMobile(),
              const SizedBox(height: Constants.sectionSpacing),
            ],
            if (Responsive.isDesktop(context)) const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.horizontalPadding),
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
    final cartServices = ref.watch(appControllerProvider).cartServices;
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
                  AutoSizeText(
                    widget.service.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.primaryColor,
                        fontFamily: 'SF Pro Rounded',
                    ),
                  ),
                  const SizedBox(height: Spacing.s8),
                  AutoSizeText(
                    widget.service.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                        fontFamily: 'SF Pro Rounded',
                        fontSize: Responsive.isDesktop(context) ? 20 : 16
                    ),
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
                    enabled: !cartServices.contains(widget.service),
                    onTap: () {
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
    return Column(
      children: [
        const Divider(),
        Consumer(
          builder: (context, ref, _) {
            final cartServices = ref.watch(appControllerProvider).cartServices;
            return SizedBox(
              height: 600,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.horizontalPadding,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xffAEB2BA)),
                        ),
                        height: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: SingleChildScrollView(
                          child: Wrap(
                            runSpacing: Spacing.m20,
                            spacing: Spacing.m20,
                            children: cartServices.map((service) {
                              return Container(
                                width: width * 0.28,
                                height: 140,
                                color: Palette.cardBackgroundColor,
                                child: Row(
                                  children: [
                                    Image.network(
                                      service.image,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Text(
                                        service.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: theme.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w600,
                                            fontFamily: 'SF Pro Rounded',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Palette.transparent,
                                        shape: const CircleBorder(
                                          side: BorderSide(color: Palette.white),
                                        ),
                                        minimumSize: const Size.fromRadius(28),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 14,
                                      ),
                                      onPressed: () {
                                        ref
                                            .read(appControllerProvider.notifier)
                                            .removeService(service);
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                    Expanded(
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
              ),
            );
          }
        ),
        const Divider(),
      ],
    );
  }
}
