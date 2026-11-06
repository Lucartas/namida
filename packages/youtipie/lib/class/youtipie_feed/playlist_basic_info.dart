import 'dart:async';

import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/class/youtipie_feed/channel_info_item.dart' show ChannelInfoItem;
import 'package:youtipie/class/youtipie_feed/playlist_info_item_user.dart' show PlaylistInfoItemUser;
import 'package:youtipie/class/result_wrapper/playlist_result_base.dart' show YoutiPiePlaylistResultBase;
import 'package:nampack/reactive/reactive.dart' show Rxn;
import 'package:youtipie/core/enum.dart' show PlaylistPrivacy;
import 'package:youtipie/src/unavailable.dart';

class PlaylistBasicInfo extends MapSerializable {
  final String id;
  final String title;
  final String? videosCountText;
  final int? videosCount;
  final int? viewsCount;
  final String? viewsCountText;
  final List<YoutiPieThumbnail> thumbnails;
  final String subtitle;
  final String? description;
  final bool isMix;
  final PlaylistPrivacy? privacy;
  final ChannelInfoItem? uploader;
  final YoutiPieHostedPlaylistParams hostedParams;
  const PlaylistBasicInfo({
    this.id = '',
    this.title = '',
    this.videosCountText,
    this.videosCount,
    this.viewsCount,
    this.viewsCountText,
    this.thumbnails = const [],
    this.subtitle = '',
    this.description,
    this.isMix = false,
    this.privacy,
    this.uploader,
    this.hostedParams = const YoutiPieHostedPlaylistParams(),
  });
  Rxn<bool> get isInLibrary => unavailable('PlaylistBasicInfo.isInLibrary');
  static PlaylistBasicInfo fromMap(Map<String, dynamic> map) => unavailable('PlaylistBasicInfo.fromMap');
  String buildUrl() => unavailable('Remote playlist URL');
  Map<String, dynamic> toMap() => unavailable('PlaylistBasicInfo.toMap');
  // Popup entries are app-owned, so this package cannot name their element type.
  FutureOr<List<T>> getPopupMenuItems<T>({
    Object? queueSource,
    YoutiPiePlaylistResultBase? playlistToFetch,
    PlaylistInfoItemUser? userPlaylist,
    bool displayOpenPlaylist = false,
    bool displayDownloadItem = true,
    bool displayShuffle = true,
    bool displayPlay = true,
    bool showProgressSheet = false,
    bool isInFullScreen = false,
  }) => unavailable('Playlist actions');
}

class YoutiPieHostedPlaylistParams {
  const YoutiPieHostedPlaylistParams();

  Rxn<bool> get addNewVideosToTop => unavailable('YoutiPieHostedPlaylistParams.addNewVideosToTop');
}
