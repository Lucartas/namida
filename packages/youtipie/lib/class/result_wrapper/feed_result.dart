import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/map_serializable.dart' show YoutiPieFeedItem;
import 'package:youtipie/class/stream_info_item/stream_info_item_short.dart' show StreamInfoItemShort;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/src/unavailable.dart';

typedef FeedResult = YoutiPieFeedResult;

class YoutiPieShortsSection {
  const YoutiPieShortsSection();
  Map<int, List<int>?> get relatedItemsShortsData => unavailable('_YoutiPieShortsSection.relatedItemsShortsData');
  Map<int, bool> get shortsIndicesLookup => unavailable('_YoutiPieShortsSection.shortsIndicesLookup');
  StreamInfoItemShort getAsShort(YoutiPieFeedItem _) => unavailable('YoutiPieShortsSection.getAsShort');
}

class YoutiPieFeedResult extends YoutiPieListWrapper<YoutubeFeed> {
  final YoutiPieShortsSection shortsSection;
  const YoutiPieFeedResult({List<YoutubeFeed> items = const [], String? continuation, this.shortsSection = const YoutiPieShortsSection()})
    : super(items: items, continuation: continuation);
}
