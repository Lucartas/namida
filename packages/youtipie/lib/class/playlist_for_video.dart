class PlaylistForVideoItem {
  final dynamic playlistId;
  final dynamic playlistTitle;
  final dynamic privacy;
  final bool containsVideo;
  const PlaylistForVideoItem({this.playlistId, this.playlistTitle, this.privacy, this.containsVideo = false});
}

class YoutiPiePlaylistEditCallbacks {
  final dynamic Function() oldPlaylist;
  final dynamic Function(dynamic newPlaylist) newPlaylistCallback;
  const YoutiPiePlaylistEditCallbacks({required this.oldPlaylist, required this.newPlaylistCallback});
}
