import 'package:youtipie/class/map_serializable.dart' show MapSerializable, YoutiPieFeedItem;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/core/enum.dart' show ChannelNotifications;
import 'package:youtipie/src/unavailable.dart';

class ChannelInfoItem extends MapSerializable implements YoutiPieFeedItem {
  final String id;
  final String handler;
  final String? title;
  final List<YoutiPieThumbnail> thumbnails;
  final int? subscribersCount;
  final String? subscribersCountText;
  final bool? subscribed;
  final ChannelNotifications? notifications;
  final Object? notificationParameters;
  final Object? channelEngagement;
  final List<YoutiPieThumbnail> banners;
  final List<YoutiPieThumbnail> tvbanners;
  final List<YoutiPieThumbnail> mobileBanners;
  final bool? isVerified;
  const ChannelInfoItem({
    this.id = '',
    this.handler = '',
    this.title,
    this.thumbnails = const [],
    this.subscribersCount,
    this.subscribersCountText,
    this.subscribed,
    this.notifications,
    this.notificationParameters,
    this.channelEngagement,
    this.banners = const [],
    this.tvbanners = const [],
    this.mobileBanners = const [],
    this.isVerified,
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
      banners = const [],
      tvbanners = const [],
      mobileBanners = const [],
      isVerified = null;

  @override
  bool get isShortContent => unavailable('ChannelInfoItem.isShortContent');
}
