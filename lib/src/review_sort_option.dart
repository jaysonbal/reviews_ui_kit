/// Standard ways to sort a review list. [ReviewFilterSheet] renders one
/// row per value in this order — sort the underlying data yourself when
/// [ReviewFilterSheet.onSelected] fires.
enum ReviewSortOption {
  newest,
  oldest,
  recommended,
  highest,
  lowest;

  String get label {
    switch (this) {
      case ReviewSortOption.newest:
        return 'Newest';
      case ReviewSortOption.oldest:
        return 'Oldest';
      case ReviewSortOption.recommended:
        return 'Recommended';
      case ReviewSortOption.highest:
        return 'Highest Rated';
      case ReviewSortOption.lowest:
        return 'Lowest Rated';
    }
  }
}
