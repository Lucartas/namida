import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;

typedef ChannelHomeSection = YoutiPieChannelHomeSection;

class YoutiPieChannelHomeSection extends YoutubeFeed {
  @override
  final String title;
  @override
  final List<YoutiPieThumbnail> thumbnails;
  @override
  final List<MapSerializable> items;
  @override
  final String? playlistId;
  const YoutiPieChannelHomeSection({this.title = '', this.thumbnails = const [], this.items = const [], this.playlistId});
}
