import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;

typedef ChannelTabResult = YoutiPieChannelTabResult;

class YoutiPieChannelTabResult extends YoutiPieListWrapper<YoutubeFeed> {
  final String? channelId;
  const YoutiPieChannelTabResult({List<YoutubeFeed> items = const [], super.continuation, this.channelId}) : super(items: items);
}
