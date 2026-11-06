import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/map_serializable.dart' show YoutiPieFeedItem;
import 'package:flutter/material.dart' show Color;
import 'package:youtipie/class/music/music_browse_endpoint.dart' show YoutiPieMusicBrowseEndpoint;
import 'package:youtipie/class/youtipie_feed/music_album_info_item.dart' show MusicAlbumInfoItem;
import 'package:youtipie/class/youtipie_feed/music_navigation_item.dart' show MusicNavigationItem;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/class/youtipie_feed/channel_info_item.dart' show ChannelInfoItem;
import 'package:youtipie/src/unavailable.dart';

typedef YtFeedBase = YoutubeFeed;

abstract class YoutubeFeed extends MapSerializable implements MusicAlbumInfoItem, MusicNavigationItem, YoutiPieFeedItem {
  String get id => unavailable('YoutubeFeed.id');
  String get title => unavailable('YoutubeFeed.title');
  String get subtitle => unavailable('YoutubeFeed.subtitle');
  List<YoutiPieThumbnail> get thumbnails => unavailable('YoutubeFeed.thumbnails');
  bool get isMix => unavailable('YoutubeFeed.isMix');
  bool get isShortContent => unavailable('YoutubeFeed.isShortContent');
  List<YoutubeFeed> get initialVideos => unavailable('YoutubeFeed.initialVideos');
  List<MapSerializable> get items => unavailable('YoutubeFeed.items');
  String? get viewsText => unavailable('YoutubeFeed.viewsText');
  int? get viewsCount => unavailable('YoutubeFeed.viewsCount');
  List<YoutiPieThumbnail> get liveThumbs => unavailable('YoutubeFeed.liveThumbs');
  String? get playlistId => unavailable('YoutubeFeed.playlistId');
  YoutiPieMusicBrowseEndpoint get endpoint => unavailable('YoutubeFeed.endpoint');
  String? get cacheKey => unavailable('YoutubeFeed.cacheKey');
  Color? get color => unavailable('YoutubeFeed.color');
  List<ChannelInfoItem> get artists => unavailable('YoutubeFeed.artists');

  const YoutubeFeed();
}
