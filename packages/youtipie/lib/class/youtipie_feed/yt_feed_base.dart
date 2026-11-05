import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/youtipie_feed/music_album_info_item.dart' show MusicAlbumInfoItem;
import 'package:youtipie/class/youtipie_feed/music_navigation_item.dart' show MusicNavigationItem;
import 'package:youtipie/src/unavailable.dart';

typedef YtFeedBase = dynamic;

abstract class YoutubeFeed extends MapSerializable implements MusicAlbumInfoItem, MusicNavigationItem {
  dynamic get id => unavailable('YoutubeFeed.id');
  dynamic get title => unavailable('YoutubeFeed.title');
  dynamic get subtitle => unavailable('YoutubeFeed.subtitle');
  List<dynamic> get thumbnails => unavailable('YoutubeFeed.thumbnails');
  dynamic get isMix => unavailable('YoutubeFeed.isMix');
  dynamic get isShortContent => unavailable('YoutubeFeed.isShortContent');
  dynamic get initialVideos => unavailable('YoutubeFeed.initialVideos');
  dynamic get items => unavailable('YoutubeFeed.items');
  dynamic get playlistId => unavailable('YoutubeFeed.playlistId');
  dynamic get endpoint => unavailable('YoutubeFeed.endpoint');
  dynamic get cacheKey => unavailable('YoutubeFeed.cacheKey');
  dynamic get color => unavailable('YoutubeFeed.color');
  dynamic get artists => unavailable('YoutubeFeed.artists');

  const YoutubeFeed();
}
