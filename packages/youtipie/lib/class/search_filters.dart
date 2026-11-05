import 'package:youtipie/core/enum.dart' show YoutiPieMusicSearchType, YoutiPieSearchMatchMode, YoutiPieSearchSort, YoutiPieSearchType, YoutiPieSearchUploadDate;
import 'package:youtipie/src/unavailable.dart';

typedef SearchFilters = dynamic;

class YoutiPieSearchFilters {
  final YoutiPieSearchType type;
  final YoutiPieSearchSort sort;
  final YoutiPieSearchUploadDate uploadDate;
  final YoutiPieMusicSearchType? musicType;
  final YoutiPieSearchMatchMode? matchMode;
  final List<String> excluded;
  final dynamic after;
  final dynamic before;
  final bool clearAfter;
  final bool clearBefore;
  final List<String> exclude;
  const YoutiPieSearchFilters({
    this.type = YoutiPieSearchType.all,
    this.sort = YoutiPieSearchSort.relevance,
    this.uploadDate = YoutiPieSearchUploadDate.none,
    this.musicType,
    this.matchMode,
    this.excluded = const [],
    this.after,
    this.before,
    this.clearAfter = false,
    this.clearBefore = false,
    this.exclude = const [],
  });
  static const defaults = YoutiPieSearchFilters();
  bool get hasDateRange => unavailable('YoutiPieSearchFilters.hasDateRange');
  bool get isDefault => unavailable('YoutiPieSearchFilters.isDefault');
  static YoutiPieSearchParsedDateOperators? parseDateOperators(String text) => unavailable('YoutiPieSearchFilters.parseDateOperators');
  static String stripDateOperators(String text) => unavailable('YoutiPieSearchFilters.stripDateOperators');
  YoutiPieSearchFilters copyWith({
    YoutiPieSearchType? type,
    YoutiPieSearchSort? sort,
    YoutiPieSearchUploadDate? uploadDate,
    YoutiPieMusicSearchType? musicType,
    YoutiPieSearchMatchMode? matchMode,
    List<String>? excluded,
    dynamic after,
    dynamic before,
    bool? clearAfter,
    bool? clearBefore,
    List<String>? exclude,
  }) => unavailable('YoutiPieSearchFilters.copyWith');
}

class YoutiPieSearchParsedDateOperators {
  final YoutiPieSearchDate? after;
  final YoutiPieSearchDate? before;
  const YoutiPieSearchParsedDateOperators({this.after, this.before});
}

class YoutiPieSearchDate {
  final DateTime dateTime;
  const YoutiPieSearchDate(this.dateTime);
  static YoutiPieSearchDate fromDateTime(DateTime dateTime) => unavailable('YoutiPieSearchDate.fromDateTime');
  static YoutiPieSearchDate? parse(String text) => unavailable('YoutiPieSearchDate.parse');

  DateTime toDateTime() => unavailable('YoutiPieSearchDate.toDateTime');
  DateTime toDateTimeUtc() => unavailable('YoutiPieSearchDate.toDateTimeUtc');
  @override
  String toString() => unavailable('YoutiPieSearchDate.toString');
}

class YoutiPieSearchOperators {
  final String remainingText;
  final List<String> phrases;
  final List<String> titlePhrases;
  final List<String> excluded;
  final YoutiPieSearchMatchMode? matchMode;
  const YoutiPieSearchOperators({this.remainingText = '', this.phrases = const [], this.titlePhrases = const [], this.excluded = const [], this.matchMode});
  static String buildQuery(String query, {dynamic matchMode, Iterable<String> excluded = const []}) => unavailable('YoutiPieSearchOperators.buildQuery');
  static YoutiPieSearchOperators? parse(String text) => unavailable('YoutiPieSearchOperators.parse');
}
