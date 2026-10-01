import 'package:flutter/material.dart';

/// A row of 5 stars (full/half/outline) plus an "x/5" label — the large,
/// decorative rating display used as a fallback when a review has no text,
/// and reusable anywhere else you want a big at-a-glance rating.
class BigStarRating extends StatelessWidget {
  final double rating;
  final double iconSize;
  final Color textColor;
  final Color starColor;

  const BigStarRating({
    super.key,
    required this.rating,
    this.iconSize = 45,
    this.textColor = Colors.black,
    this.starColor = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...List.generate(
          full,
          (_) => Icon(Icons.star_rounded, color: starColor, size: iconSize),
        ),
        if (half) Icon(Icons.star_half_rounded, color: starColor, size: 20),
        ...List.generate(
          5 - full - (half ? 1 : 0),
          (_) =>
              Icon(Icons.star_outline_rounded, color: starColor, size: iconSize),
        ),
        const SizedBox(width: 4),
        Text(
          '${rating.toStringAsFixed(0)}/5',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}
