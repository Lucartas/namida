import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/class/youtipie_feed/playlist_basic_info.dart' show PlaylistBasicInfo;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/src/unavailable.dart';

extension YoutubeFeedMixPlaylist on YoutubeFeed {
  bool get isMixPlaylist => unavailable('YoutubeFeed.isMixPlaylist');
}

class StreamInfoItem extends YoutubeFeed implements PlaylistBasicInfo {
  final String id;
  final String title;
  final dynamic shortDescription;
  final dynamic channel;
  final dynamic channelName;
  final dynamic channelId;
  final List<YoutiPieThumbnail> thumbnails;
  final dynamic subtitle;
  final dynamic isMix;
  final dynamic isShortContent;
  final dynamic isMixPlaylist;
  final List<dynamic> initialVideos;
  final dynamic thumbnailGifUrl;
  final dynamic publishedFromText;
  final dynamic publishedAt;
  final dynamic indexInPlaylist;
  final dynamic durSeconds;
  final dynamic durText;
  final dynamic viewsText;
  final dynamic viewsCount;
  final dynamic percentageWatched;
  final dynamic liveThumbs;
  final dynamic isUploaderVerified;
  final dynamic badges;
  final dynamic isActuallyShortContent;
  const StreamInfoItem({
    this.id = '',
    this.title = '',
    this.shortDescription,
    this.channel,
    this.channelName,
    this.channelId,
    this.thumbnails = const [],
    this.subtitle,
    this.isMix = false,
    this.isShortContent = false,
    this.isMixPlaylist = false,
    this.initialVideos = const [],
    this.thumbnailGifUrl,
    this.publishedFromText,
    this.publishedAt,
    this.indexInPlaylist,
    this.durSeconds,
    this.durText,
    this.viewsText,
    this.viewsCount,
    this.percentageWatched,
    this.liveThumbs,
    this.isUploaderVerified,
    this.badges,
    this.isActuallyShortContent,
  });
  dynamic get videosCountText => unavailable('StreamInfoItem.videosCountText');
  dynamic get videosCount => unavailable('StreamInfoItem.videosCount');
  dynamic get viewsCountText => unavailable('StreamInfoItem.viewsCountText');
  dynamic get description => unavailable('StreamInfoItem.description');
  dynamic get uploader => unavailable('StreamInfoItem.uploader');
  dynamic get isInLibrary => unavailable('StreamInfoItem.isInLibrary');
  dynamic get items => unavailable('StreamInfoItem.items');
  dynamic get playlistId => unavailable('StreamInfoItem.playlistId');
  dynamic get endpoint => unavailable('StreamInfoItem.endpoint');
  dynamic get cacheKey => unavailable('StreamInfoItem.cacheKey');
  dynamic get color => unavailable('StreamInfoItem.color');
  dynamic get artists => unavailable('StreamInfoItem.artists');
  dynamic getPopupMenuItems({
    dynamic queueSource,
    dynamic playlistToFetch,
    dynamic userPlaylist,
    bool displayOpenPlaylist = false,
    bool displayDownloadItem = true,
    bool displayShuffle = true,
    bool displayPlay = true,
    bool showProgressSheet = false,
    bool isInFullScreen = false,
  }) => unavailable('StreamInfoItem.getPopupMenuItems');
  dynamic get availableDescription => unavailable('StreamInfoItem.availableDescription');
  dynamic buildUrl() => unavailable('Remote video URL');
  Map<String, dynamic> toMap() => unavailable('StreamInfoItem.toMap');
  static StreamInfoItem fromMap(dynamic map) => unavailable('StreamInfoItem.fromMap');
}
