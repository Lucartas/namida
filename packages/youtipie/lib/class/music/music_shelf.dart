import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/music/music_browse_endpoint.dart' show YoutiPieMusicBrowseEndpoint;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/core/enum.dart' show YoutiPieMusicShelfLayout;
import 'package:youtipie/src/unavailable.dart';

typedef MusicShelf = YoutiPieMusicShelf;

class YoutiPieMusicShelf extends MapSerializable {
  final YoutiPieMusicShelfLayout layout;
  final List<YoutubeFeed> items;
  final bool hasHeader;
  final String title;
  final String? strapline;
  final YoutiPieMusicBrowseEndpoint? moreEndpoint;
  final int rowsPerColumn;
  final List<YoutiPieThumbnail> thumbnails;
  const YoutiPieMusicShelf({
    this.layout = YoutiPieMusicShelfLayout.list,
    this.items = const [],
    this.hasHeader = false,
    this.title = '',
    this.strapline,
    this.moreEndpoint,
    this.rowsPerColumn = 1,
    this.thumbnails = const [],
  });

  double computeHeaderExtent() => unavailable('YoutiPieMusicShelf.computeHeaderExtent');
}
