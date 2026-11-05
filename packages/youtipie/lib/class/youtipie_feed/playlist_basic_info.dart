import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/src/unavailable.dart';

class PlaylistBasicInfo extends MapSerializable {
  final String id;
  final dynamic title;
  final dynamic videosCountText;
  final dynamic videosCount;
  final dynamic viewsCount;
  final dynamic viewsCountText;
  final List<dynamic> thumbnails;
  final dynamic subtitle;
  final dynamic description;
  final dynamic isMix;
  final dynamic uploader;
  final dynamic isInLibrary;
  const PlaylistBasicInfo({
    this.id = '',
    this.title,
    this.videosCountText,
    this.videosCount,
    this.viewsCount,
    this.viewsCountText,
    this.thumbnails = const [],
    this.subtitle,
    this.description,
    this.isMix = false,
    this.uploader,
    this.isInLibrary,
  });
  static PlaylistBasicInfo fromMap(dynamic map) => unavailable('PlaylistBasicInfo.fromMap');
  dynamic buildUrl() => unavailable('Remote playlist URL');
  Map<String, dynamic> toMap() => unavailable('PlaylistBasicInfo.toMap');
  dynamic getPopupMenuItems({
    dynamic queueSource,
    dynamic playlistToFetch,
    dynamic userPlaylist,
    bool displayOpenPlaylist = false,
    bool displayDownloadItem = true,
    bool displayShuffle = true,
    bool displayPlay = true,
    bool showProgressSheet = false,
    bool isInFullScreen = false,
  }) => unavailable('Playlist actions');
}
