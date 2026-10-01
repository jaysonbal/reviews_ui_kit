import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

// ── Shared bone primitive ───────────────────────────────────────────────

class _Bone extends StatelessWidget {
  final double width;
  final double height;
  final double radius;

  const _Bone({required this.width, required this.height, this.radius = 6});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}

/// Mimics [ReviewListItem]'s layout — avatar, name/country, rating, date,
/// and a few text lines. Use while the real review data is loading.
class ReviewListItemShimmer extends StatelessWidget {
  const ReviewListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const _Bone(width: 44, height: 44, radius: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _Bone(width: 120, height: 13),
                          const SizedBox(height: 6),
                          _Bone(width: 70, height: 11, radius: 5),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    const _Bone(width: 48, height: 13),
                  ],
                ),
                const SizedBox(height: 12),
                _Bone(width: 80, height: 11, radius: 5),
                const SizedBox(height: 8),
                const _Bone(width: double.infinity, height: 13),
                const SizedBox(height: 6),
                const _Bone(width: double.infinity, height: 13),
                const SizedBox(height: 6),
                const _Bone(width: 180, height: 13),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 0.5,
            color: Color(0xFFEEEEEE),
            indent: 16,
            endIndent: 16,
          ),
        ],
      ),
    );
  }
}

/// Two [ReviewListItemShimmer] rows — a pagination/"load more" footer.
class ReviewLoadMoreShimmer extends StatelessWidget {
  const ReviewLoadMoreShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [ReviewListItemShimmer(), ReviewListItemShimmer()],
    );
  }
}

/// [count] stacked [ReviewListItemShimmer] rows — the initial-load state
/// for a whole review list screen.
class ReviewListShimmer extends StatelessWidget {
  final int count;
  const ReviewListShimmer({super.key, this.count = 5});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(count, (_) => const ReviewListItemShimmer()),
    );
  }
}
