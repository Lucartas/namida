import 'package:youtipie/class/youtipie_feed/playlist_basic_info.dart' show PlaylistBasicInfo;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;

enum VideoEndScreenItemType { video, playlist, channel, unknown }

class EndScreenDisplay {
  final double aspectRatio;
  final double left;
  final double top;
  final double width;
  const EndScreenDisplay({this.aspectRatio = 1, this.left = 0, this.top = 0, this.width = 0});
}

sealed class EndScreenItemBase {
  final VideoEndScreenItemType type;
  final EndScreenDisplay display;
  final int startMs;
  final int endMs;
  final List<YoutiPieThumbnail> thumbnails;
  const EndScreenItemBase({
    this.type = VideoEndScreenItemType.unknown,
    this.display = const EndScreenDisplay(),
    this.startMs = 0,
    this.endMs = 0,
    this.thumbnails = const [],
  });
}

final class EndScreenItemVideo extends EndScreenItemBase {
  final String? videoId;
  final String? title;
  final int? viewsCount;
  final String? viewsCountText;
  const EndScreenItemVideo({
    this.videoId,
    this.title,
    this.viewsCount,
    this.viewsCountText,
    super.type = VideoEndScreenItemType.video,
    super.display,
    super.startMs,
    super.endMs,
    super.thumbnails,
  });
}

final class EndScreenItemChannel extends EndScreenItemBase {
  final String? channelId;
  final String? title;
  const EndScreenItemChannel({this.channelId, this.title, super.type = VideoEndScreenItemType.channel, super.display});
}

final class EndScreenItemPlaylist extends EndScreenItemBase {
  final PlaylistBasicInfo basicInfo;
  const EndScreenItemPlaylist({required this.basicInfo, super.type = VideoEndScreenItemType.playlist, super.display});
}
