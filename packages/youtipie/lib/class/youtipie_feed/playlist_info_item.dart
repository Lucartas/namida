import 'package:flutter/material.dart' show Color;
import 'package:youtipie/class/music/music_browse_endpoint.dart' show YoutiPieMusicBrowseEndpoint;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/class/youtipie_feed/playlist_basic_info.dart' show PlaylistBasicInfo;
import 'package:youtipie/class/youtipie_feed/channel_info_item.dart' show ChannelInfoItem;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/src/unavailable.dart';

class PlaylistInfoItem extends PlaylistBasicInfo implements YoutubeFeed {
  final List<YoutubeFeed> initialVideos;
  const PlaylistInfoItem({
    super.id = '',
    super.title,
    super.videosCountText,
    super.videosCount,
    super.thumbnails = const [],
    super.subtitle,
    super.isMix = false,
    super.privacy,
    super.uploader,
    this.initialVideos = const [],
  });

  @override
  bool get isShortContent => unavailable('PlaylistInfoItem.isShortContent');
  @override
  List<YoutubeFeed> get items => unavailable('PlaylistInfoItem.items');
  @override
  String? get playlistId => unavailable('PlaylistInfoItem.playlistId');
  @override
  YoutiPieMusicBrowseEndpoint get endpoint => unavailable('PlaylistInfoItem.endpoint');
  @override
  String? get cacheKey => unavailable('PlaylistInfoItem.cacheKey');
  @override
  Color? get color => unavailable('PlaylistInfoItem.color');
  @override
  List<ChannelInfoItem> get artists => unavailable('PlaylistInfoItem.artists');
  @override
  String? get viewsText => unavailable('PlaylistInfoItem.viewsText');
  @override
  List<YoutiPieThumbnail> get liveThumbs => unavailable('PlaylistInfoItem.liveThumbs');
  static bool isMixPlaylist(String id) => unavailable('PlaylistInfoItem.isMixPlaylist');
}
