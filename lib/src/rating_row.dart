import 'package:flutter/material.dart';

/// One labeled row of 5 tappable stars — the building block for a
/// "rate your experience" form (communication, quality, value, etc. as
/// separate rows, or just one row for an overall rating).
class RatingRow extends StatelessWidget {
  const RatingRow({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.color = Colors.amber,
    this.labelStyle,
    this.size = 24,
  });

  final String label;
  final double? value;
  final ValueChanged<double> onChanged;
  final Color color;
  final TextStyle? labelStyle;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: labelStyle ??
                const TextStyle(
                  fontSize: 15,
                  letterSpacing: -0.25,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.w400,
                ),
          ),
        ),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                (value ?? 0) > index ? Icons.star : Icons.star_border,
                color: color,
                size: size,
              ),
              onPressed: () => onChanged(index + 1.0),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            );
          }),
        ),
      ],
    );
  }
}
