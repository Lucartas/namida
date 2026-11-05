import 'package:youtipie/class/channels/channel_info.dart' show YoutiPieChannelInfo;
import 'package:youtipie/src/unavailable.dart';

typedef ChannelPageResult = YoutiPieChannelPageResult;

class YoutiPieChannelPageResult extends YoutiPieChannelInfo {
  final List<dynamic> tabs;
  final dynamic videosCount;
  final dynamic videosCountText;

  const YoutiPieChannelPageResult({
    super.id,
    super.handler,
    super.title,
    super.thumbnails,
    super.subscribersCount,
    super.subscribersCountText,
    super.subscribed,
    super.notifications,
    super.notificationParameters,
    super.channelEngagement,
    super.banners,
    super.tvbanners,
    super.mobileBanners,
    this.tabs = const [],
    this.videosCount,
    this.videosCountText,
  });

  String buildUrl() => unavailable('Remote channel URL');
}
