import 'package:youtipie/class/youtipie_feed/channel_info_item.dart' show ChannelInfoItem;
import 'package:youtipie/src/unavailable.dart';

typedef ChannelInfo = dynamic;

class YoutiPieChannelInfo extends ChannelInfoItem {
  const YoutiPieChannelInfo({
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
  });
  void rebuild({dynamic newSubscribed, dynamic newNotifications, dynamic newNotificationParameters}) => unavailable('YoutiPieChannelInfo.rebuild');
}
