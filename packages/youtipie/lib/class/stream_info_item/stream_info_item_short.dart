import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/src/unavailable.dart';

class StreamInfoItemShort extends YoutubeFeed {
  final String id;
  final String title;
  final String viewsText;
  final int? viewsCount;
  final List<YoutiPieThumbnail> liveThumbs;
  const StreamInfoItemShort({this.id = '', this.title = '', this.viewsText = '', this.viewsCount, this.liveThumbs = const []});

  @override
  bool get isShortContent => unavailable('StreamInfoItemShort.isShortContent');
}
