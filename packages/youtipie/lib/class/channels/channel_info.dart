import 'package:youtipie/class/youtipie_feed/channel_info_item.dart' show ChannelInfoItem;
import 'package:youtipie/core/enum.dart' show ChannelNotifications;
import 'package:youtipie/src/unavailable.dart';

typedef ChannelInfo = YoutiPieChannelInfo;

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
    super.isVerified,
  });
  void rebuild({bool? newSubscribed, ChannelNotifications? newNotifications, Object? newNotificationParameters}) => unavailable('YoutiPieChannelInfo.rebuild');
}

class YoutiPieChannelSubscriptionResult {
  final bool isNowSubbed;
  final ChannelNotifications? newNotificationStatus;

  const YoutiPieChannelSubscriptionResult({required this.isNowSubbed, this.newNotificationStatus});
}
