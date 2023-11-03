import 'package:flutter/material.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/our_services/models/purchasable_service.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/data.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

class ServicesBrowser extends StatelessWidget {
  const ServicesBrowser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.webHorizontalPadding),
          child: Wrap(
            spacing: Spacing.l24,
            runSpacing: Spacing.l24,
            children: Data.purchasableServices.map((service) {
              return SizedBox(
                height: Constants.servicesBrowserItemHeight,
                width: Constants.servicesBrowserItemWidth,
                child: ServiceItem(service: service),
              );
            }).toList(),
          ),
        ),
        const Divider(),
      ],
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
          Padding(
            padding: const EdgeInsets.all(Spacing.l32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.title,
                  style: theme.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: Spacing.s8),
                Text(
                  service.description,
                  style: theme.textTheme.bodySmall,
                ),
                const Spacer(),
                PrimaryButton(
                  title: Strings.add,
                  textStyle: theme.textTheme.labelLarge,
                  width: Constants.servicesBrowserItemWidth * 0.2,
                  padding: const EdgeInsets.symmetric(vertical: Spacing.m20),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(
              service.image,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
