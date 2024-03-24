import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/theme/palette.dart';
import '../../../firebase_services/firestore_services.dart';
import '../../../resources/spacing.dart';
import '../../../resources/strings.dart';
import '../../../riverpod/controller.dart';
import '../../../shared/widgets/input_form_field.dart';
import '../../../shared/widgets/primary_button.dart';

class ServicesCartMobile extends HookWidget {
  ServicesCartMobile({super.key});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final emailController = useTextEditingController();
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final budgetController = useTextEditingController();
    final messageController = useTextEditingController();

    return SizedBox(
      height: 840,
      child: Column(
        children: [
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Expanded(
                    child: Consumer(
                      builder: (context, ref, child) {
                        final cartServices =
                            ref.watch(appControllerProvider).cartServices;
                        return Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xffAEB2BA)),
                          ),
                          child: ListView.separated(
                            padding: const EdgeInsets.all(10),
                            itemBuilder: (context, index) {
                              final service = cartServices[index];
                              return Card(
                                clipBehavior: Clip.hardEdge,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)),
                                ),
                                child: Container(
                                  width: double.infinity,
                                  color: Palette.cardBackgroundColor,
                                  child: Row(
                                    children: [
                                      Image.network(
                                        service.image,
                                        height: 130,
                                        width: 75,
                                        fit: BoxFit.cover,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          service.title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: theme.textTheme.bodyLarge
                                              ?.copyWith(
                                            fontFamily: 'SF Pro Rounded',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Palette.transparent,
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
                                              .read(appControllerProvider
                                                  .notifier)
                                              .removeService(service);
                                        },
                                      ),
                                      const SizedBox(width: 4),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 2);
                            },
                            itemCount: cartServices.length,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              prefix: true,
                              required: true,
                              keyboardType: TextInputType.text,
                            ),
                            InputFormField(
                              hint: Strings.message,
                              controller: messageController,
                              required: true,
                              multiline: true,
                              keyboardType: TextInputType.multiline,
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: PrimaryButton(
                                    title: Strings.sendMessage.toUpperCase(),
                                    height: 45,
                                    textStyle:
                                        theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        await FirestoreServices.sendMessages(
                                          message: messageController.text,
                                          context: context,
                                          budget: budgetController.text,
                                          phone: phoneController.text,
                                          name: nameController.text,
                                          email: emailController.text,
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
                                const SizedBox(width: Spacing.s8),
                                Expanded(
                                  child: PrimaryButton(
                                    title: Strings.requestCall.toUpperCase(),
                                    height: 45,
                                    textStyle:
                                        theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    onTap: () async {
                                      if (formKey.currentState!.validate()) {
                                        await FirestoreServices.sendMessages(
                                            message: messageController.text,
                                            budget: budgetController.text,
                                            context: context,
                                            phone: phoneController.text,
                                            name: nameController.text,
                                            email: emailController.text,

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
                  ),
                ],
              ),
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
