import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reviews_ui_kit/reviews_ui_kit.dart';

void main() {
  group('ReviewSortOption', () {
    test('labels are human-readable', () {
      expect(ReviewSortOption.newest.label, 'Newest');
      expect(ReviewSortOption.oldest.label, 'Oldest');
      expect(ReviewSortOption.recommended.label, 'Recommended');
      expect(ReviewSortOption.highest.label, 'Highest Rated');
      expect(ReviewSortOption.lowest.label, 'Lowest Rated');
    });
  });

  group('ReviewData', () {
    test('hasVendorReply is false for null/empty/whitespace replies', () {
      expect(const ReviewData(customerName: 'A').hasVendorReply, isFalse);
      expect(
        const ReviewData(customerName: 'A', vendorReply: '').hasVendorReply,
        isFalse,
      );
      expect(
        const ReviewData(customerName: 'A', vendorReply: '   ').hasVendorReply,
        isFalse,
      );
      expect(
        const ReviewData(customerName: 'A', vendorReply: 'Thanks!')
            .hasVendorReply,
        isTrue,
      );
    });

    test('copyWith overrides only the given fields', () {
      const original = ReviewData(customerName: 'Alicia', rating: 4);
      final copy = original.copyWith(rating: 5);
      expect(copy.customerName, 'Alicia');
      expect(copy.rating, 5);
    });
  });

  group('OverallRatingSummary', () {
    testWidgets('shows the average rating and review count', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OverallRatingSummary(averageRating: 4.9, totalReviews: 128),
        ),
      );
      expect(find.text('4.9'), findsOneWidget);
      expect(find.text('(128 reviews)'), findsOneWidget);
    });

    testWidgets('singular review count has no trailing s', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OverallRatingSummary(averageRating: 5, totalReviews: 1),
        ),
      );
      expect(find.text('(1 review)'), findsOneWidget);
    });

    testWidgets('renders one row per sub-rating', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: OverallRatingSummary(
            averageRating: 4.5,
            totalReviews: 10,
            subRatings: {'Communication': 4.9, 'Value': 4.2},
          ),
        ),
      );
      expect(find.text('Communication'), findsOneWidget);
      expect(find.text('Value'), findsOneWidget);
    });
  });

  group('BigStarRating', () {
    testWidgets('renders 5 star icons total and the x/5 label',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: BigStarRating(rating: 3))),
      );
      final filled = tester.widgetList<Icon>(find.byIcon(Icons.star_rounded));
      final outline =
          tester.widgetList<Icon>(find.byIcon(Icons.star_outline_rounded));
      expect(filled.length, 3);
      expect(outline.length, 2);
      expect(find.text('3/5'), findsOneWidget);
    });
  });

  group('RatingRow', () {
    testWidgets('tapping the 4th star reports 4.0', (tester) async {
      double? reported;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: RatingRow(
              label: 'Overall',
              value: null,
              onChanged: (v) => reported = v,
            ),
          ),
        ),
      );
      final stars = find.byIcon(Icons.star_border);
      await tester.tap(stars.at(3));
      expect(reported, 4.0);
    });
  });

  group('ReviewListItem', () {
    testWidgets('shows customer name and rating', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ReviewListItem(
              review: ReviewData(
                customerName: 'Priya S.',
                rating: 4.5,
                reviewText: 'Great experience overall.',
              ),
            ),
          ),
        ),
      );
      expect(find.text('Priya S.'), findsOneWidget);
      expect(find.text('★ 4.5'), findsOneWidget);
      expect(find.text('Great experience overall.'), findsOneWidget);
    });

    testWidgets('falls back to BigStarRating when there is no text',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ReviewListItem(
              review: ReviewData(customerName: 'Marcus T.', rating: 5),
            ),
          ),
        ),
      );
      expect(find.byType(BigStarRating), findsOneWidget);
    });

    testWidgets('renders the seller-reply bubble only when there is one',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ReviewListItem(
              review: ReviewData(
                customerName: 'Alicia M.',
                rating: 5,
                reviewText: 'Loved it.',
                vendorReply: 'Thank you!',
              ),
            ),
          ),
        ),
      );
      expect(find.text("Seller's Response"), findsOneWidget);
      expect(find.text('Thank you!'), findsOneWidget);
    });
  });

  group('ReferenceChip', () {
    testWidgets('shows the title and formatted rating', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ReferenceChip(
              title: 'Cliffside Cabin',
              rating: 4.9,
              reviewCount: 128,
            ),
          ),
        ),
      );
      expect(find.text('Cliffside Cabin'), findsOneWidget);
      expect(find.text('★ 4.9 (128 reviews)'), findsOneWidget);
    });
  });
}
