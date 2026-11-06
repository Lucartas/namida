import 'package:youtipie/class/youtipie_feed/playlist_basic_info.dart' show PlaylistBasicInfo;

class PlaylistInfoItemUser extends PlaylistBasicInfo {
  final String? handler;
  final List<String>? infoTexts;
  const PlaylistInfoItemUser({
    super.id,
    super.title,
    this.handler,
    super.description,
    super.thumbnails,
    super.privacy,
    super.videosCount,
    super.videosCountText,
    super.isMix,
    this.infoTexts,
  });
}
