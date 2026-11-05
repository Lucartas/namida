import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;

class ChannelInfoItem extends MapSerializable {
  final dynamic id;
  final String handler;
  final dynamic title;
  final List<YoutiPieThumbnail> thumbnails;
  final dynamic subscribersCount;
  final dynamic subscribersCountText;
  final dynamic subscribed;
  final dynamic notifications;
  final dynamic notificationParameters;
  final dynamic channelEngagement;
  final dynamic banners;
  final dynamic tvbanners;
  final dynamic mobileBanners;
  const ChannelInfoItem({
    this.id,
    this.handler = '',
    this.title,
    this.thumbnails = const [],
    this.subscribersCount,
    this.subscribersCountText,
    this.subscribed,
    this.notifications,
    this.notificationParameters,
    this.channelEngagement,
    this.banners,
    this.tvbanners,
    this.mobileBanners,
  });
  const ChannelInfoItem.anonymous()
    : id = '',
      handler = '',
      title = '',
      thumbnails = const [],
      subscribersCount = null,
      subscribersCountText = null,
      subscribed = null,
      notifications = null,
      notificationParameters = null,
      channelEngagement = null,
      banners = null,
      tvbanners = null,
      mobileBanners = null;
}
