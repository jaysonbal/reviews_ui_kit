/// Ready-made ratings & reviews UI: an overall-rating summary, a star
/// picker and text field for writing one, a sortable/filterable review
/// list, review cards, loading skeletons, and a "which item is this about"
/// reference chip — all driven by a plain [ReviewData], never a particular
/// model class or backend.
library reviews_ui_kit;

export 'src/review_data.dart';
export 'src/review_list_item.dart';
export 'src/overall_rating_summary.dart';
export 'src/big_star_rating.dart';
export 'src/rating_row.dart';
export 'src/review_input_field.dart';
export 'src/info_message.dart';
export 'src/review_sort_option.dart';
export 'src/review_filter_sheet.dart';
export 'src/reference_chip.dart';
export 'src/review_shimmers.dart';
export 'src/time_ago.dart' show defaultTimeAgo;
