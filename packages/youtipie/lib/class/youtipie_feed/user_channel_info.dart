import 'package:youtipie/class/channels/channel_info.dart' show YoutiPieChannelInfo;

class UserChannelIdentity {
  final bool isOwner;
  final int authUser;
  final bool needsMigration;

  const UserChannelIdentity({this.isOwner = true, this.authUser = 0, this.needsMigration = false});
}

class UserChannelInfo extends YoutiPieChannelInfo {
  final UserChannelIdentity identity;

  const UserChannelInfo({
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
    this.identity = const UserChannelIdentity(),
  });
}
