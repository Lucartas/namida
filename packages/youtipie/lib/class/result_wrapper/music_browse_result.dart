import 'package:youtipie/class/music/music_shelf.dart' show YoutiPieMusicShelf;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/src/unavailable.dart';

typedef MusicBrowseResult = YoutiPieMusicBrowseResult;

class YoutiPieMusicBrowseResult extends YoutiPieListWrapper<YoutiPieMusicShelf> {
  final dynamic formOptions;
  final dynamic chips;
  final dynamic avatarThumbnails;
  final dynamic bannerThumbnails;
  final dynamic subtitle;
  final dynamic title;
  final dynamic channelId;

  const YoutiPieMusicBrowseResult({
    List<YoutiPieMusicShelf> items = const [],
    dynamic continuation,
    this.formOptions,
    this.chips,
    this.avatarThumbnails,
    this.bannerThumbnails,
    this.subtitle,
    this.title,
    this.channelId,
  }) : super(items: items, continuation: continuation);
  dynamic findSongsPlaylistId() => unavailable('YoutiPieMusicBrowseResult.findSongsPlaylistId');
}
