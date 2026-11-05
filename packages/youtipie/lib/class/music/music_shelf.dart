import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/core/enum.dart' show YoutiPieMusicShelfLayout;

typedef MusicShelf = dynamic;

class YoutiPieMusicShelf extends MapSerializable {
  final YoutiPieMusicShelfLayout layout;
  final List<YoutubeFeed> items;
  final bool hasHeader;
  final dynamic title;
  final dynamic strapline;
  final dynamic moreEndpoint;
  final int rowsPerColumn;
  final dynamic thumbnails;
  const YoutiPieMusicShelf({
    this.layout = YoutiPieMusicShelfLayout.list,
    this.items = const [],
    this.hasHeader = false,
    this.title,
    this.strapline,
    this.moreEndpoint,
    this.rowsPerColumn = 1,
    this.thumbnails,
  });
}
