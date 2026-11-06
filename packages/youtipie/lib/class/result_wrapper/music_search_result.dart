import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/music/music_top_result.dart' show YoutiPieMusicTopResult;
import 'package:youtipie/class/music/music_search_chip.dart' show YoutiPieMusicSearchChip;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;

typedef MusicSearchResult = YoutiPieMusicSearchResult;

class YoutiPieMusicSearchResult extends YoutiPieListWrapper<MapSerializable> {
  final String query;
  @override
  final List<YoutubeFeed> items;
  final List<YoutiPieMusicSearchChip> chips;
  final YoutiPieMusicTopResult? topResult;

  const YoutiPieMusicSearchResult({this.query = '', this.items = const [], this.chips = const [], this.topResult, String? continuation})
    : super(items: items, continuation: continuation);
}
