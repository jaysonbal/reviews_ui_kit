import 'package:flutter/material.dart';
import 'package:reviews_ui_kit/reviews_ui_kit.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reviews_ui_kit example',
      home: const ExampleHome(),
    );
  }
}

final _reviews = [
  ReviewData(
    customerName: 'Alicia M.',
    rating: 5,
    reviewText:
        'Absolutely fantastic work, delivered early and communicated the '
        'whole way through.',
    date: DateTime.now().subtract(const Duration(days: 2)),
    country: 'Jamaica',
    vendorName: 'Marcus T.',
    vendorReply: 'Thank you so much, Alicia! Looking forward to next time.',
  ),
  ReviewData(
    customerName: 'Priya S.',
    rating: 4,
    reviewText: 'Really solid quality, minor delay but worth the wait.',
    date: DateTime.now().subtract(const Duration(days: 9)),
    country: 'Canada',
  ),
  const ReviewData(
    customerName: 'Marcus T.',
    rating: 5,
    // No reviewText - falls back to a big decorative star row.
  ),
];

class ExampleHome extends StatefulWidget {
  const ExampleHome({super.key});

  @override
  State<ExampleHome> createState() => _ExampleHomeState();
}

class _ExampleHomeState extends State<ExampleHome> {
  ReviewSortOption _sort = ReviewSortOption.newest;
  final _reviewController = TextEditingController();
  double? _rating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('reviews_ui_kit'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => ReviewFilterSheet.show(
              context,
              current: _sort,
              onSelected: (opt) => setState(() => _sort = opt),
              activeColor: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          const ReferenceChip(
            title: 'Cliffside Cabin, Big Sur',
            rating: 4.9,
            reviewCount: 128,
          ),
          const OverallRatingSummary(
            averageRating: 4.8,
            totalReviews: 128,
            subRatings: {
              'Communication': 4.9,
              'Quality': 4.8,
              'Value': 4.6,
            },
          ),
          const Divider(height: 1),
          for (final review in _reviews) ReviewListItem(review: review),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Write a review',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                RatingRow(
                  label: 'Overall rating',
                  value: _rating,
                  onChanged: (v) => setState(() => _rating = v),
                ),
                const SizedBox(height: 12),
                ReviewInputField(controller: _reviewController),
                const SizedBox(height: 12),
                const InfoMessage(
                  message: 'Reviews can be edited for 48 hours after posting.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
