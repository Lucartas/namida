import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/src/unavailable.dart';

typedef RelatedVideosResult = dynamic;

class YoutiPieRelatedVideosResult extends YoutiPieListWrapper<YoutubeFeed> {
  final dynamic cacheKey;
  final dynamic videoId;
  final dynamic isPersonalized;
  final dynamic shortsSection;
  const YoutiPieRelatedVideosResult({this.cacheKey, List<YoutubeFeed> items = const [], dynamic continuation, this.videoId, this.isPersonalized, this.shortsSection})
    : super(items: items, continuation: continuation);
  @override
  bool get canFetchNext => unavailable('YoutiPieRelatedVideosResult.canFetchNext');
  @override
  Future<bool> fetchNext() => unavailable('YoutiPieRelatedVideosResult.fetchNext');
}
