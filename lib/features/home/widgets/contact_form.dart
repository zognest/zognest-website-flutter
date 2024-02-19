// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zognest_website/config/constants.dart';
import 'package:zognest_website/config/responsive.dart';
import 'package:zognest_website/config/theme/palette.dart';
import 'package:zognest_website/resources/assets.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/resources/strings.dart';
import 'package:zognest_website/shared/widgets/gradient_container.dart';
import 'package:zognest_website/shared/widgets/input_form_field.dart';
import 'package:zognest_website/shared/widgets/primary_button.dart';

import '../../../config/theme/text_theme.dart';
import '../../../firebase_services/firestore_services.dart';

class ContactForm extends HookWidget {
  ContactForm({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final messageController = useTextEditingController();
    return Column(
      children: [
        const Divider(),
        if (Responsive.isDesktop(context)) SizedBox(
                height: Constants.contactUsSectionHeight,
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
                        horizontal: 60,
                        vertical: Constants.webVerticalPadding,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                              text:
                                                  Strings.touch.toUpperCase()),
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
                                      style:
                                          theme.textTheme.bodyLarge!.copyWith(
                                        fontSize: 20,
                                      ),
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
                          SizedBox(
                            width: size.width * 0.4,
                            child: Form(
                              key: formKey,
                              child: Material(
                                color: Palette.transparent,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InputFormField(
                                      required: true,
                                        controller: nameController,
                                        hint: Strings.yourName),
                                    InputFormField(
                                        required: true,
                                        controller: emailController,
                                        hint: Strings.yourEmail),
                                    InputFormField(
                                        required: true,
                                        controller: phoneController,
                                        hint: Strings.mobileNo),
                                    InputFormField(
                                      controller: messageController,
                                      hint: Strings.message,
                                      required: true,
                                      multiline: true,
                                      keyboardType: TextInputType.multiline,
                                    ),
                                    const SizedBox(height: Spacing.l40),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: PrimaryButton(
                                              title: Strings.sendMessage
                                                  .toUpperCase(),
                                              height: 75,
                                              textStyle: theme.textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                              onTap: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  await FirestoreServices
                                                      .sendMessages(
                                                    message:
                                                    messageController.text,
                                                    phone: phoneController.text,
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    context: context,
                                                  );
                                                  messageController.clear();
                                                  phoneController.clear();
                                                  nameController.clear();
                                                  emailController.clear();
                                                }
                                              }),
                                        ),
                                        const SizedBox(width: Spacing.s12),
                                        Expanded(
                                          child: PrimaryButton(
                                              title: Strings.requestCall
                                                  .toUpperCase(),
                                              backgroundColor: Palette.white,
                                              height: 75,
                                              textStyle: theme.textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                              onTap: () async {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  await FirestoreServices
                                                      .sendMessages(
                                                    message:
                                                    messageController.text,
                                                    phone: phoneController.text,
                                                    name: nameController.text,
                                                    email: emailController.text,
                                                    call: true,
                                                    context: context,
                                                  );
                                                  messageController.clear();
                                                  phoneController.clear();
                                                  nameController.clear();
                                                  emailController.clear();
                                                }
                                              }),

                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ) else ContactFormMobile(),
        const Divider(),
      ],
    );
  }
}

class ContactFormMobile extends HookWidget {
  ContactFormMobile({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final messageController = useTextEditingController();
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [
                    theme.primaryColor.withOpacity(0.5),
                    theme.primaryColor.withOpacity(0),
                  ],
                ),
                image: const DecorationImage(
                  image: AssetImage(Assets.impactLinesPng),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.mobileHorizontalPadding,
                vertical: Constants.mobileVerticalPadding,
              ),
              child: Column(
                children: [
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      text: Strings.get.toUpperCase(),
                      style: theme.textTheme.displaySmall,
                      children: [
                        TextSpan(
                          text: '${Strings.inText.toUpperCase()}\n',
                          style: theme.textTheme.displaySmall
                              ?.copyWith(foreground: TextThemes.foreground),
                        ),
                        TextSpan(text: Strings.touch.toUpperCase()),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spacing.s12),
                  Text(
                    Strings.contactDetails.toUpperCase(),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: theme.primaryColor,
                      fontVariations: TextThemes.fontVariation(7),
                    ),
                  ),
                  const SizedBox(height: Spacing.s12),
                  Text(
                    textAlign: TextAlign.center,
                    Strings.address,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: Spacing.s4),
                  Text(
                    Strings.contactInfo,
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.m16),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.mobileHorizontalPadding),
              child: Form(
                key: formKey,
                child: Material(
                  color: Palette.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InputFormField(
                        controller: nameController,
                        hint: Strings.yourName,
                        required: true,
                        keyboardType: TextInputType.name,
                      ),
                      InputFormField(
                        controller: emailController,
                        hint: Strings.yourEmail,
                        required: true,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      InputFormField(
                        controller: phoneController,
                        hint: Strings.mobileNo,
                        required: true,
                        keyboardType: TextInputType.phone,
                      ),
                      InputFormField(
                        hint: Strings.message,
                        controller: messageController,
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
                              height: 40,
                              textStyle: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await FirestoreServices.sendMessages(
                                    message: messageController.text,
                                    phone: phoneController.text,
                                    name: nameController.text,
                                    context: context,
                                    email: emailController.text,
                                  );
                                  messageController.clear();
                                  phoneController.clear();
                                  nameController.clear();
                                  emailController.clear();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: Spacing.s12),
                          Expanded(
                            child: PrimaryButton(
                              title: Strings.requestCall.toUpperCase(),
                              backgroundColor: Palette.white,
                              height: 40,
                              textStyle: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              onTap: () async {
                                if (formKey.currentState!.validate()) {
                                  await FirestoreServices.sendMessages(
                                    message: messageController.text,
                                    phone: phoneController.text,
                                    name: nameController.text,
                                    email: emailController.text,
                                    context: context,
                                    call: true,
                                  );
                                  messageController.clear();
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
            ),
            const SizedBox(height: Spacing.m18),
        
          ],
        ),
      ),
    );
  }
}
