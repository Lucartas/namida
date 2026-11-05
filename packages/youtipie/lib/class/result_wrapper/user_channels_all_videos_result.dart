import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;

typedef UserChannelsAllVideosResult = YoutiPieUserChannelsAllVideosResult;

class YoutiPieUserChannelsAllVideosResult extends YoutiPieListWrapper<YoutubeFeed> {
  const YoutiPieUserChannelsAllVideosResult({List<YoutubeFeed> items = const [], dynamic continuation}) : super(items: items, continuation: continuation);
}
