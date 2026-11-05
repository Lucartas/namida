import 'package:youtipie/class/youtipie_feed/playlist_basic_info.dart' show PlaylistBasicInfo;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/src/unavailable.dart';

class PlaylistInfoItem extends PlaylistBasicInfo implements YoutubeFeed {
  final List<dynamic> initialVideos;
  const PlaylistInfoItem({
    super.id = '',
    super.title,
    super.videosCountText,
    super.videosCount,
    super.thumbnails = const [],
    super.subtitle,
    super.isMix = false,
    super.uploader,
    this.initialVideos = const [],
  });

  @override
  dynamic get isShortContent => unavailable('PlaylistInfoItem.isShortContent');
  @override
  dynamic get items => unavailable('PlaylistInfoItem.items');
  @override
  dynamic get playlistId => unavailable('PlaylistInfoItem.playlistId');
  @override
  dynamic get endpoint => unavailable('PlaylistInfoItem.endpoint');
  @override
  dynamic get cacheKey => unavailable('PlaylistInfoItem.cacheKey');
  @override
  dynamic get color => unavailable('PlaylistInfoItem.color');
  @override
  dynamic get artists => unavailable('PlaylistInfoItem.artists');
  static bool isMixPlaylist(String id) => unavailable('PlaylistInfoItem.isMixPlaylist');
}
