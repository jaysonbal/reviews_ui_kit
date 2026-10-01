import 'package:flutter/material.dart';

/// A multi-line text field styled for writing or replying to a review —
/// plain Material styling plus a disabled-while-submitting state, with
/// spell-check underlines on by default.
class ReviewInputField extends StatelessWidget {
  const ReviewInputField({
    super.key,
    required this.controller,
    this.hintText = 'Write your review...',
    this.isSubmitting = false,
    this.maxLines = 7,
    this.cursorColor,
    this.borderColor = Colors.grey,
    this.focusedBorderColor,
  });

  final TextEditingController controller;
  final String hintText;
  final bool isSubmitting;
  final int maxLines;
  final Color? cursorColor;
  final Color borderColor;
  final Color? focusedBorderColor;

  @override
  Widget build(BuildContext context) {
    final focusColor =
        focusedBorderColor ?? Theme.of(context).colorScheme.primary;

    return TextField(
      controller: controller,
      maxLines: maxLines,
      cursorColor: cursorColor ?? focusColor,
      enabled: !isSubmitting,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      spellCheckConfiguration: SpellCheckConfiguration(
        misspelledSelectionColor: Colors.red,
        misspelledTextStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.red,
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationStyle: TextDecorationStyle.wavy,
        ),
      ),
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: focusColor),
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }
}
