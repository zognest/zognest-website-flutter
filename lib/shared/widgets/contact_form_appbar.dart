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

class ContactFormAppBar extends HookWidget {
  ContactFormAppBar({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context){
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final budgetController = useTextEditingController();
    final messageController = useTextEditingController();
    return Column(
      children: [
        const Divider(),
        Responsive.isDesktop(context)
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 50),
          height:size.height*.9,
          child: Stack(
            children: [
              GradientContainer(
                color: theme.primaryColor,
                alignment: const Alignment(-0.5, 0),
                colorStartingOpacity: 0.3,
                radius: 1,
              ),
              Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(Assets.impactLines),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical:0,
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
                                  fontSize: Responsive.isDesktop(context)
                                      ? 10
                                      : 8,
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InputFormField(
                                controller: nameController,
                                hint: Strings.yourName),
                            InputFormField(
                                controller: emailController,
                                hint: Strings.yourEmail),
                            InputFormField(
                                controller: phoneController,
                                hint: Strings.mobileNo),
                            InputFormField(
                              controller: messageController,
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
                                    title:
                                    Strings.sendMessage.toUpperCase(),
                                    height: 75,
                                    textStyle: theme.textTheme.bodyLarge
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    onTap: () async {
                                      if (formKey.currentState!
                                          .validate()) {
                                        await FirestoreServices
                                            .sendMessages(
                                          message: messageController.text,
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
                                      // toast
                                    },
                                  ),
                                ),
                                const SizedBox(width: Spacing.s12),
                                Expanded(
                                  child: PrimaryButton(
                                    title:
                                    Strings.requestCall.toUpperCase(),
                                    backgroundColor: Palette.white,
                                    height: 75,
                                    textStyle: theme.textTheme.bodyLarge
                                        ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                    onTap: () async {
                                      if (formKey.currentState!
                                          .validate()) {
                                        await FirestoreServices
                                            .sendMessages(
                                          message: messageController.text,
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
                                      return 'some things went roung';
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
            ],
          ),
        )
            : ContactFormMobileAppBar(),
        const Divider(),
      ],
    );
  }
}

class ContactFormMobileAppBar extends HookWidget {
  ContactFormMobileAppBar({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final budgetController = useTextEditingController();
    final messageController = useTextEditingController();
    final theme = Theme.of(context);
    return Column(
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
                style: theme.textTheme.bodySmall,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 InputFormField(
                  controller:nameController,
                  hint: Strings.yourName,
                  required: false,
                  keyboardType: TextInputType.name,
                ),
                 InputFormField(
                  controller: emailController,
                  hint: Strings.yourEmail,
                  required: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                 InputFormField(
                   controller: phoneController,
                  hint: Strings.mobileNo,
                  required: false,
                  keyboardType: TextInputType.phone,
                ),
                 InputFormField(
                   controller: messageController,
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
                            budgetController.clear();
                            phoneController.clear();
                            nameController.clear();
                            nameController.clear();
                          }
                          return 'some things went roung';
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
                            budgetController.clear();
                            phoneController.clear();
                            nameController.clear();
                            emailController.clear();
                          }
                          return 'some things went roung';
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Spacing.m18),
      ],
    );
  }
}