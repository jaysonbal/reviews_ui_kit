import 'package:flutter/material.dart';

/// A small icon + text banner — e.g. "Reviews can only be edited within
/// 48 hours" above a review form, or any other inline notice.
class InfoMessage extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color iconColor;
  final Color cardColor;

  const InfoMessage({
    super.key,
    required this.message,
    this.icon = Icons.info_outline,
    this.iconColor = Colors.blueGrey,
    this.cardColor = const Color(0xFFF0F2F5),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
            ),
          ),
        ],
      ),
    );
  }
}
