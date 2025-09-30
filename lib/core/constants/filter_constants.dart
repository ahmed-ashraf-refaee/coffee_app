import 'package:coffee_app/generated/l10n.dart';

class FilterConstants {
  static List<String> get sortOptions => [
    S.current.sort_topRated,
    S.current.sort_oldest,
    S.current.sort_newest,
    S.current.sort_discount,
    S.current.sort_lowestPrice,
    S.current.sort_highestPrice,
  ];

  static List<String> get ratingOptions => [
    S.current.rating_5,
    S.current.rating_4up,
    S.current.rating_3up,
    S.current.rating_2up,
    S.current.rating_1up,
  ];
  static const double minPrice = 0;
  static const double maxPrice = 1000;
}
