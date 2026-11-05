import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/stream_info_item/stream_info_item_short.dart' show StreamInfoItemShort;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/src/unavailable.dart';

typedef FeedResult = YoutiPieFeedResult;

class _YoutiPieShortsSection {
  const _YoutiPieShortsSection();
  Map<int, List<int>?> get relatedItemsShortsData => unavailable('_YoutiPieShortsSection.relatedItemsShortsData');
  Map<int, bool> get shortsIndicesLookup => unavailable('_YoutiPieShortsSection.shortsIndicesLookup');
  StreamInfoItemShort getAsShort(dynamic _) => unavailable('_YoutiPieShortsSection.getAsShort');
}

class YoutiPieFeedResult extends YoutiPieListWrapper<YoutubeFeed> {
  final _YoutiPieShortsSection shortsSection;
  const YoutiPieFeedResult({List<YoutubeFeed> items = const [], dynamic continuation, this.shortsSection = const _YoutiPieShortsSection()})
    : super(items: items, continuation: continuation);
}
