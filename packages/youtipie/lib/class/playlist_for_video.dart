import 'package:youtipie/class/result_wrapper/playlist_result_base.dart' show YoutiPiePlaylistResultBase;
import 'package:youtipie/core/enum.dart' show PlaylistPrivacy;

class PlaylistForVideoItem {
  final String playlistId;
  final String? playlistTitle;
  final PlaylistPrivacy? privacy;
  final bool containsVideo;
  const PlaylistForVideoItem({this.playlistId = '', this.playlistTitle, this.privacy, this.containsVideo = false});
}

class YoutiPiePlaylistEditInfo {
  final String title;
  final String? description;
  final PlaylistPrivacy? privacy;

  const YoutiPiePlaylistEditInfo({this.title = '', this.description, this.privacy});
}

class YoutiPiePlaylistEditCallbacks {
  final YoutiPiePlaylistResultBase Function() oldPlaylist;
  final void Function(YoutiPiePlaylistResultBase newPlaylist) newPlaylistCallback;
  const YoutiPiePlaylistEditCallbacks({required this.oldPlaylist, required this.newPlaylistCallback});
}
