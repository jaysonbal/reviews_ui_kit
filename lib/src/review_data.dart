import 'package:flutter/foundation.dart';

/// A plain, app-agnostic representation of one review. Map whatever your
/// backend/model returns (e.g. a Firestore doc, a REST response) into one
/// of these to use [ReviewListItem] — nothing in this package ever assumes
/// a particular model class or data source.
@immutable
class ReviewData {
  final String customerName;
  final String? customerImage;
  final String? vendorName;
  final String? vendorAvatar;

  /// When the review was left. Used to render a relative "time ago" label
  /// via [ReviewListItem.dateLabelBuilder] (or the package's own built-in
  /// formatter if you don't override it).
  final DateTime? date;

  final String? reviewText;

  /// 0–5. Shown as a decorative big star row when [reviewText] is empty,
  /// and as a compact "★ x.x" next to the reviewer's name either way.
  final double rating;

  /// Attachment URLs (images, or anything else your own
  /// [ReviewListItem.attachmentBuilder] knows how to render).
  final List<String> attachments;

  /// The seller/vendor's reply to this review, if any. An empty or null
  /// value means [hasVendorReply] is false and no reply bubble renders.
  final String? vendorReply;

  /// Free-form country label (e.g. "Jamaica"). Shown as-is unless you pass
  /// [ReviewListItem.flagBuilder] to prefix a flag/emoji/code.
  final String? country;

  const ReviewData({
    required this.customerName,
    this.customerImage,
    this.vendorName,
    this.vendorAvatar,
    this.date,
    this.reviewText,
    this.rating = 0,
    this.attachments = const [],
    this.vendorReply,
    this.country,
  });

  bool get hasVendorReply => (vendorReply ?? '').trim().isNotEmpty;

  ReviewData copyWith({
    String? customerName,
    String? customerImage,
    String? vendorName,
    String? vendorAvatar,
    DateTime? date,
    String? reviewText,
    double? rating,
    List<String>? attachments,
    String? vendorReply,
    String? country,
  }) {
    return ReviewData(
      customerName: customerName ?? this.customerName,
      customerImage: customerImage ?? this.customerImage,
      vendorName: vendorName ?? this.vendorName,
      vendorAvatar: vendorAvatar ?? this.vendorAvatar,
      date: date ?? this.date,
      reviewText: reviewText ?? this.reviewText,
      rating: rating ?? this.rating,
      attachments: attachments ?? this.attachments,
      vendorReply: vendorReply ?? this.vendorReply,
      country: country ?? this.country,
    );
  }
}
