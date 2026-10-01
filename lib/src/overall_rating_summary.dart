import 'package:flutter/material.dart';

/// The top-of-screen rating breakdown: a big average-rating number plus
/// review count, and up to three optional sub-rating rows (communication,
/// quality, value — or whatever categories your own reviews track).
class OverallRatingSummary extends StatelessWidget {
  final double averageRating;
  final int totalReviews;

  /// Sub-rating rows, in display order, e.g.
  /// `{'Communication': 4.9, 'Quality': 4.8, 'Value': 4.6}`. Omit or leave
  /// empty to show just the headline rating with no breakdown.
  final Map<String, double> subRatings;

  final Color starColor;
  final Color backgroundColor;

  const OverallRatingSummary({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    this.subRatings = const {},
    this.starColor = Colors.amber,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(Icons.star_rounded, color: starColor, size: 32),
              const SizedBox(width: 6),
              Text(
                averageRating.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  '($totalReviews review${totalReviews != 1 ? 's' : ''})',
                  style: const TextStyle(fontSize: 14, color: Color(0xFF888888)),
                ),
              ),
            ],
          ),
          if (subRatings.isNotEmpty) ...[
            const SizedBox(height: 14),
            for (final entry in subRatings.entries)
              _DetailRatingRow(entry.key, entry.value, starColor),
          ],
        ],
      ),
    );
  }
}

class _DetailRatingRow extends StatelessWidget {
  final String label;
  final double value;
  final Color starColor;
  const _DetailRatingRow(this.label, this.value, this.starColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Color(0xFF666666))),
          Row(
            children: [
              Icon(Icons.star, size: 13, color: starColor),
              const SizedBox(width: 4),
              Text(
                value.toStringAsFixed(1),
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
