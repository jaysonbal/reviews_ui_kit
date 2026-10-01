import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'big_star_rating.dart';
import 'review_data.dart';
import 'time_ago.dart';

/// Builds the widget for one attachment thumbnail. Called with the tapped
/// url, the full attachment list (for a gallery/lightbox), and this url's
/// index in that list.
typedef ReviewAttachmentBuilder = Widget Function(
  BuildContext context,
  String url,
  List<String> allUrls,
  int index,
);

/// One review, laid out exactly like a typical review-list row: avatar,
/// name, country, star rating, relative date, review text (or a big
/// decorative star row when there's no text), attachment thumbnails, and
/// an optional seller-reply bubble.
///
/// Nothing here assumes a particular model class — feed it a [ReviewData].
class ReviewListItem extends StatelessWidget {
  final ReviewData review;
  final bool isHighlighted;
  final Color highlightColor;

  /// Formats [ReviewData.date] into the small relative-time label (e.g.
  /// "3 days ago"). Defaults to a small built-in formatter — pass your own
  /// (e.g. backed by `intl`) to localize it.
  final String Function(DateTime date)? dateLabelBuilder;

  /// Prefixes [ReviewData.country] with a flag/emoji/code, e.g.
  /// `(country) => countryFlagEmoji(country)`. Left unset, the country
  /// renders as plain text with no prefix.
  final String Function(String country)? flagBuilder;

  /// Renders one attachment thumbnail. The default shows a plain
  /// 90x90 network-image tile with no tap action — pass your own to add a
  /// full-screen viewer (video/audio/PDF-aware or otherwise).
  final ReviewAttachmentBuilder? attachmentBuilder;

  final String replyLabel;
  final Color replyBubbleColor;
  final Color replyBubbleBorderColor;
  final Color starColor;

  const ReviewListItem({
    super.key,
    required this.review,
    this.isHighlighted = false,
    this.highlightColor = const Color(0x0FFFC107),
    this.dateLabelBuilder,
    this.flagBuilder,
    this.attachmentBuilder,
    this.replyLabel = "Seller's Response",
    this.replyBubbleColor = const Color(0xFFF7F7F7),
    this.replyBubbleBorderColor = const Color(0xFFE8E8E8),
    this.starColor = Colors.amber,
  });

  @override
  Widget build(BuildContext context) {
    final customerName = review.customerName.isEmpty
        ? 'Anonymous'
        : review.customerName;
    final vendorName =
        (review.vendorName ?? '').isEmpty ? 'Seller' : review.vendorName!;
    final hasText = (review.reviewText ?? '').trim().isNotEmpty;
    final country = review.country;
    final flagPrefix =
        country != null && flagBuilder != null ? '${flagBuilder!(country)} ' : '';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      color: isHighlighted ? highlightColor : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header — avatar + name/country + rating
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 23,
                      backgroundColor: Colors.grey.shade300,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage: review.customerImage != null
                            ? CachedNetworkImageProvider(review.customerImage!)
                            : null,
                        child: review.customerImage == null
                            ? Text(
                                customerName[0].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customerName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.25,
                              fontSize: 15,
                            ),
                          ),
                          if (country != null)
                            Row(
                              children: [
                                Text(
                                  '$flagPrefix$country',
                                  style: const TextStyle(
                                    color: Color(0xFF888888),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Text(
                      '★ ${review.rating.toStringAsFixed(1)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.25,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Padding(
                  padding: const EdgeInsets.fromLTRB(55, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (review.date != null) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            (dateLabelBuilder ?? defaultTimeAgo)(review.date!),
                            style: const TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 12,
                              letterSpacing: -0.25,
                            ),
                          ),
                        ),
                      ],

                      /// Review text, or a big decorative star row when
                      /// there's no text to show.
                      if (hasText) ...[
                        Text(
                          review.reviewText!,
                          style: const TextStyle(
                            color: Color(0xFF222222),
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ] else ...[
                        BigStarRating(rating: review.rating, starColor: starColor),
                      ],

                      /// Attachments
                      if (review.attachments.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 90,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: review.attachments.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (ctx, i) => SizedBox(
                              width: 90,
                              height: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: (attachmentBuilder ?? _defaultAttachment)(
                                  ctx,
                                  review.attachments[i],
                                  review.attachments,
                                  i,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],

                      /// Seller reply bubble
                      if (review.hasVendorReply) ...[
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 2,
                              height: 16,
                              margin: const EdgeInsets.only(top: 3, right: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(1),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: replyBubbleColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border:
                                      Border.all(color: replyBubbleBorderColor, width: 1),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 14,
                                          backgroundColor: Colors.grey.shade300,
                                          child: CircleAvatar(
                                            radius: 13,
                                            backgroundColor: Colors.grey.shade800,
                                            backgroundImage: review.vendorAvatar != null
                                                ? CachedNetworkImageProvider(
                                                    review.vendorAvatar!)
                                                : null,
                                            child: review.vendorAvatar == null
                                                ? Text(
                                                    vendorName[0].toUpperCase(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                : null,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          replyLabel,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      review.vendorReply ?? '',
                                      style: const TextStyle(
                                        color: Color(0xFF555555),
                                        fontSize: 13,
                                        height: 1.45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _defaultAttachment(
    BuildContext context,
    String url,
    List<String> allUrls,
    int index,
  ) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: double.infinity,
      errorWidget: (_, __, ___) => Container(
        color: const Color(0xFFE0E0E0),
        child: const Icon(Icons.insert_drive_file_outlined, color: Colors.black26),
      ),
      progressIndicatorBuilder: (context, url, progress) => Container(
        color: Colors.grey.shade200,
      ),
    );
  }
}
