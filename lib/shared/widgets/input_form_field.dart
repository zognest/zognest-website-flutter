import 'package:flutter/material.dart';
import 'package:zognest_website/resources/spacing.dart';
import 'package:zognest_website/shared/widgets/frosted_container.dart';

class InputFormField extends StatelessWidget {
  const InputFormField({
    super.key,
    required this.hint,
    this.required = true,
    this.multiline = false,
    this.keyboardType,
  });

  final String hint;
  final bool required;
  final bool multiline;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Spacing.s4),
      child: FrostedContainer(
        backgroundColor: const Color(0xff121212).withOpacity(0.6),
        borderRadius: Spacing.s12,
        child: TextFormField(
          keyboardType: keyboardType,
          maxLines: multiline ? null : 1,
          minLines: multiline ? 5 : 1,
          validator: (string) {
            if (!required) return null;
            if (string == null || string.isEmpty) {
              return 'This field is required!';
            }
            return null;
          },
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Spacing.m20,
              vertical: 32,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Spacing.s12),
              borderSide: BorderSide(color: theme.primaryColor, width: 1.50),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Spacing.s12),
              borderSide:
                  const BorderSide(color: Color(0xffAEB2BA), width: 1.50),
            ),
            fillColor: const Color(0xff121212),
            hintText: '$hint${required ? '*' : ''}',
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: const Color(0xffAEB2BA),
            ),
          ),
        ),
      ),
    );
  }
}
