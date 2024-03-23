import 'package:animated_list_item/animated_list_item.dart';
import 'package:collection/collection.dart';
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
import '../../../shared/widgets/greyscale_filter.dart';
import '../../../shared/widgets/input_form_field.dart';
import '../../../shared/widgets/network_fading_image.dart';

class ServicesBrowser extends HookConsumerWidget {
  const ServicesBrowser({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final purchasableService =
        ref.watch(appControllerProvider).purchasableServices;
    final servicesCart = ref.watch(appControllerProvider).cartServices;
    final animationController =
        useAnimationController(duration: const Duration(seconds: 2));
    final theme = Theme.of(context);
    useEffect(
      () {
        animationController.forward();
        return null;
      },
      [],
    );
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                runSpacing: 10,
                spacing: 10,
                children: purchasableServices.mapIndexed((index, service) {
                  return AnimatedListItem(
                    aniController: animationController,
                    length: purchasableServices.length,
                    index: index,
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

  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartServices = ref.watch(appControllerProvider).cartServices;
    return GreyscaleFilter(
      isHovered: isHovering,
      child: InkWell(
        onTap: () {},
        onHover: (isHovering) {
          setState(() {
            this.isHovering = isHovering;
          });
        },
        overlayColor: const MaterialStatePropertyAll(Palette.transparent),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            constraints: BoxConstraints.tight(
              const Size(
                Constants.servicesCardWidth,
                Constants.servicesCardHeight,
              ),
            ),
            color: isHovering ? Palette.transparent : Palette.black,
            child: Stack(
              children: [
                Stack(
                  children: [
                    NetworkFadingImage(
                      path: widget.service.image,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: isHovering
                          ? const Color(0xff0A0A0A).withOpacity(0.3)
                          : const Color(0xff0A0A0A).withOpacity(0.7),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.l24,
                    vertical: Spacing.l32,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 64),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              widget.service.title.toUpperCase(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontFamily: 'SF Pro Rounded',
                                fontWeight: FontWeight.bold,
                                letterSpacing: -1,
                                fontSize:
                                    Responsive.isMobile(context) ? 26 : 36,
                                color: Palette.white,
                                height: 1,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Spacing.m20),
                                child: SingleChildScrollView(
                                  child: Text(
                                    widget.service.description * 3,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: Palette.white,
                                        fontFamily: 'SF Pro Rounded',
                                        fontSize: Responsive.isDesktop(context)
                                            ? 20
                                            : 16,
                                        height: 1.3),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      PrimaryButton(
                        backgroundColor: Palette.primary,
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
              ],
            ),
            /* Row(
              children: [
                Expanded(
                  flex: Responsive.isDesktop(context) ? 1 : 2,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 45),
                        AutoSizeText(
                          widget.service.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            letterSpacing: -1,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color:
                            isHovering ? Palette.black : theme.primaryColor,
                            fontFamily: 'SF Pro Rounded',
                            height: 1,
                          ),
                        ),
                        const SizedBox(height: Spacing.s8),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              widget.service.description,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isHovering ? Palette.black : Palette.white,
                                fontFamily: 'SF Pro Rounded',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                letterSpacing:-1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Spacing.s8),
                        PrimaryButton(
                          backgroundColor:
                          isHovering ? Palette.black : Palette.primary,
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
                    isHovered: isHovering,
                    child: NetworkFadingImage(
                      path: widget.service.image,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )*/
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
                              clipBehavior: Clip.hardEdge,
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
