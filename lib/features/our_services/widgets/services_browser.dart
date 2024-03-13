import 'dart:js_interop';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/features/our_services/models/purchasable_service.dart';
import 'package:zognest_website/features/our_services/widgets/service_card_mobile.dart';
import 'package:zognest_website/firebase_services/firestore_services.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

import '../../../riverpod/controller.dart';
import '../../../shared/widgets/frosted_container.dart';
import '../../../shared/widgets/greyscale_filter.dart';
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
    final servicesCart = ref.watch(appControllerProvider).cartServices;
    final theme = Theme.of(context);
    return purchasableService.when(
      data: (purchasableServices) {
        return Column(
          children: [
            if (servicesCart.isNotEmpty) ...[
              Responsive.isDesktop(context)
                  ? ServicesCart()
                  : ServicesCartMobile(),
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
  late bool added = true;

  bool isHovering=false ;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartServices = ref.watch(appControllerProvider).cartServices;
    return InkWell(
      onTap: (){},
      onHover: (isHovering){
        setState(() {
          this.isHovering = isHovering;
        });
      },
      child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            color: isHovering ?Palette.primary : Palette.cardBackgroundColor,
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
                            fontWeight: FontWeight.w800,
                            color:isHovering?Palette.black: theme.primaryColor,
                            fontFamily: 'SF Pro Rounded',
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: Spacing.s8),
                        AutoSizeText(
                          widget.service.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color:isHovering?Palette.black:Palette.white ,
                              fontFamily: 'SF Pro Rounded',
                              fontWeight: FontWeight.w500,
                              fontSize: Responsive.isDesktop(context) ? 20 : 16),
                        ),
                        const Expanded(child: SizedBox()),
                        PrimaryButton(
                          backgroundColor:isHovering? Palette.black: Palette.primary,
                          title: !cartServices.contains(widget.service)
                              ? Strings.add
                              : Strings.added,
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
                  child: GreyscaleFilter(
                    isHovered:isHovering ,
                    child: NetworkFadingImage(
                      path: widget.service.image,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}

class ServicesCart extends HookConsumerWidget {
  ServicesCart({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final budgetController = useTextEditingController();
    final messageController = useTextEditingController();

    final width = MediaQuery.sizeOf(context).width;
    return Column(
      children: [
        const Divider(),
        Consumer(builder: (context, ref, _) {
          final cartServices = ref.watch(appControllerProvider).cartServices;
          return SizedBox(
            height: 750,
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
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Container(
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
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
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
                                          side:
                                              BorderSide(color: Palette.white),
                                        ),
                                        minimumSize: const Size.fromRadius(28),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 14,
                                      ),
                                      onPressed: () {
                                        ref
                                            .read(
                                                appControllerProvider.notifier)
                                            .removeService(service);
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InputFormField(
                            controller: nameController,
                            hint: Strings.yourName,
                            required: true,
                            keyboardType: TextInputType.name,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: InputFormField(
                                  controller: emailController,
                                  hint: Strings.yourEmail,
                                  required: true,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: InputFormField(
                                  controller: phoneController,
                                  hint: Strings.mobileNo,
                                  required: true,
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                            ],
                          ),
                          InputFormField(
                            controller: budgetController,
                            hint: Strings.budget,
                            required: true,
                            keyboardType: TextInputType.text,
                          ),
                          InputFormField(
                            controller: messageController,
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
                                    textStyle:
                                        theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        final services = ref
                                            .read(appControllerProvider)
                                            .cartServices
                                            .map((service) => service.title)
                                            .toList();
                                        await FirestoreServices.sendMessages(
                                          message: messageController.text,
                                          context: context,
                                          budget: budgetController.text,
                                          phone: phoneController.text,
                                          name: nameController.text,
                                          email: emailController.text,
                                          services: services,
                                        );
                                        messageController.clear();
                                        budgetController.clear();
                                        phoneController.clear();
                                        nameController.clear();
                                        emailController.clear();
                                      }
                                    }),
                              ),
                              const SizedBox(width: Spacing.s8),
                              Expanded(
                                child: PrimaryButton(
                                  title: Strings.requestCall.toUpperCase(),
                                  height: 70,
                                  textStyle:
                                      theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      final services = ref
                                          .read(appControllerProvider)
                                          .cartServices
                                          .map((service) => service.title)
                                          .toList();
                                      await FirestoreServices.sendMessages(
                                          message: messageController.text,
                                          budget: budgetController.text,
                                          context: context,
                                          phone: phoneController.text,
                                          name: nameController.text,
                                          email: emailController.text,
                                          services: services,
                                          call: true);
                                      messageController.clear();
                                      budgetController.clear();
                                      phoneController.clear();
                                      nameController.clear();
                                      emailController.clear();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        const Divider(),
      ],
    );
  }
}

// branding https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/services%2FBranding.png?alt=media&token=1cf566c9-30b6-4ccd-aee1-d694bc1cf9bf
// strage https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/services%2FStrategy%26brainstorming.png?alt=media&token=722b18cb-cb64-4535-9bf3-35bca528fa93
//backend https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/services%2Fbackend.png?alt=media&token=4b2b54b2-4bd1-4856-a8aa-90f36ee21aa7
//mobile app https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/services%2Fmobile_app.png?alt=media&token=4ce7f246-969f-41e5-b97a-3ed5caaf2109
//our https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/services%2Four_dedicatedTeams.png?alt=media&token=863861e2-e4b8-49f9-b46e-01be3a874eaf
//sass https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/services%2Fsaas.png.png?alt=media&token=dde89205-ef69-439a-accd-d24561b46390
// social media https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/services%2Fsocial_media.png?alt=media&token=dd8d1d28-eb53-49b6-a763-1b27c4308d6a
//ui https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/services%2Fui_ux.png?alt=media&token=d373fbcc-87e6-43b1-bd3d-87c7375941e6
// web https://firebasestorage.googleapis.com/v0/b/zognest-website.appspot.com/o/services%2Fweb_pwa.png?alt=media&token=31331897-2eee-4ce1-a930-273d94c79729