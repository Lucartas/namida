import 'package:youtipie/class/youtipie_feed/playlist_basic_info.dart' show PlaylistBasicInfo;

enum VideoEndScreenItemType { video, playlist, channel, unknown }

class EndScreenDisplay {
  final double aspectRatio;
  final dynamic left;
  final dynamic top;
  final dynamic width;
  const EndScreenDisplay({this.aspectRatio = 1, this.left = 0, this.top = 0, this.width = 0});
}

sealed class EndScreenItemBase {
  final VideoEndScreenItemType type;
  final EndScreenDisplay display;
  final dynamic startMs;
  final dynamic endMs;
  final dynamic thumbnails;
  const EndScreenItemBase({this.type = VideoEndScreenItemType.unknown, this.display = const EndScreenDisplay(), this.startMs, this.endMs, this.thumbnails});
}

final class EndScreenItemVideo extends EndScreenItemBase {
  final dynamic videoId;
  final dynamic title;
  final dynamic viewsCount;
  final dynamic viewsCountText;
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
  final dynamic channelId;
  final dynamic title;
  const EndScreenItemChannel({this.channelId, this.title, super.type = VideoEndScreenItemType.channel, super.display});
}

final class EndScreenItemPlaylist extends EndScreenItemBase {
  final PlaylistBasicInfo basicInfo;
  const EndScreenItemPlaylist({required this.basicInfo, super.type = VideoEndScreenItemType.playlist, super.display});
}
