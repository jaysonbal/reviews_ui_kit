## 0.1.0

- Initial release.
- `ReviewData` - a plain, model-agnostic representation of one review.
- `ReviewListItem` - a full review card: avatar, name, country, rating,
  relative date, review text (or a big decorative star row when there's no
  text), attachment thumbnails, and an optional seller-reply bubble.
  Attachment rendering and date/country formatting are all overridable via
  builder callbacks, so the package makes no assumption about where your
  media lives or how you format dates.
- `OverallRatingSummary` - the big average-rating number plus an optional
  breakdown of named sub-ratings (communication, quality, value, or
  whatever your own reviews track).
- `BigStarRating` - a standalone full/half/outline star row with an "x/5"
  label.
- `RatingRow` - one labeled row of 5 tappable stars, for a "rate your
  experience" form.
- `ReviewInputField` - a styled multi-line text field for writing or
  replying to a review, with a disabled-while-submitting state.
- `InfoMessage` - a small icon + text banner for inline notices.
- `ReviewSortOption` / `ReviewFilterSheet` - a 5-option sort enum and the
  bottom sheet that picks one.
- `ReferenceChip` - a small tappable card pointing at whatever the review
  is about (a listing, a service, a product).
- `ReviewListItemShimmer` / `ReviewLoadMoreShimmer` / `ReviewListShimmer` -
  loading-state skeletons matching `ReviewListItem`'s layout.
