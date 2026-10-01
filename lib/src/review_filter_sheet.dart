import 'package:flutter/material.dart';

import 'review_sort_option.dart';

/// A bottom sheet listing every [ReviewSortOption], with a checkmark next
/// to [current]. Call [ReviewFilterSheet.show] rather than building this
/// widget directly.
class ReviewFilterSheet extends StatelessWidget {
  final ReviewSortOption current;
  final ValueChanged<ReviewSortOption> onSelected;
  final String title;
  final Color activeColor;

  const ReviewFilterSheet({
    super.key,
    required this.current,
    required this.onSelected,
    this.title = 'Sort Reviews By',
    this.activeColor = Colors.blue,
  });

  static Future<void> show(
    BuildContext context, {
    required ReviewSortOption current,
    required ValueChanged<ReviewSortOption> onSelected,
    String title = 'Sort Reviews By',
    Color activeColor = Colors.blue,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ReviewFilterSheet(
        current: current,
        onSelected: onSelected,
        title: title,
        activeColor: activeColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            for (final opt in ReviewSortOption.values)
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  onSelected(opt);
                },
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                title: Text(
                  opt.label,
                  style: TextStyle(
                    color: current == opt ? activeColor : Colors.black,
                    fontWeight:
                        current == opt ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
                trailing: current == opt
                    ? Icon(Icons.check_rounded, color: activeColor, size: 18)
                    : null,
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
