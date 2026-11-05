import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;

typedef MusicTopResult = dynamic;

class YoutiPieMusicTopResult extends MapSerializable {
  final YoutubeFeed item;
  final List<YoutubeFeed> items;
  final dynamic subtitle;

  const YoutiPieMusicTopResult({required this.item, this.items = const [], this.subtitle});
}
