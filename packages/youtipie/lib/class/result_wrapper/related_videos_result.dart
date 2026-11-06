import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/result_wrapper/feed_result.dart' show YoutiPieShortsSection;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/src/unavailable.dart';

typedef RelatedVideosResult = YoutiPieRelatedVideosResult;

class YoutiPieRelatedVideosResult extends YoutiPieListWrapper<YoutubeFeed> {
  final String? cacheKey;
  final String? videoId;
  final bool? isPersonalized;
  final YoutiPieShortsSection shortsSection;
  const YoutiPieRelatedVideosResult({
    this.cacheKey,
    List<YoutubeFeed> items = const [],
    String? continuation,
    this.videoId,
    this.isPersonalized,
    this.shortsSection = const YoutiPieShortsSection(),
  }) : super(items: items, continuation: continuation);
  @override
  bool get canFetchNext => unavailable('YoutiPieRelatedVideosResult.canFetchNext');
  @override
  Future<bool> fetchNext() => unavailable('YoutiPieRelatedVideosResult.fetchNext');
}
