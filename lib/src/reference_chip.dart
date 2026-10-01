import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// A small tappable card pointing at whatever the review is about — the
/// service, listing, or product it was left on. Shown above a review (e.g.
/// on a vendor's combined review feed) so the reviewed item has context.
class ReferenceChip extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final double? rating;
  final int? reviewCount;
  final VoidCallback? onTap;
  final IconData placeholderIcon;
  final EdgeInsetsGeometry margin;

  const ReferenceChip({
    super.key,
    required this.title,
    this.imageUrl,
    this.rating,
    this.reviewCount,
    this.onTap,
    this.placeholderIcon = Icons.inventory_2_outlined,
    this.margin = const EdgeInsets.only(bottom: 10),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl != null
                  ? CachedNetworkImage(
                      imageUrl: imageUrl!,
                      width: 44,
                      height: 44,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => _Placeholder(placeholderIcon),
                    )
                  : _Placeholder(placeholderIcon),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (rating != null)
                    Text(
                      '★ ${rating!.toStringAsFixed(1)} (${reviewCount ?? 0} reviews)',
                      style: const TextStyle(
                        fontSize: 13,
                        letterSpacing: -0.25,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right_rounded, color: Colors.black54, size: 18),
          ],
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  final IconData icon;
  const _Placeholder(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      color: const Color(0xFFE0E0E0),
      child: Icon(icon, size: 20, color: Colors.black26),
    );
  }
}
