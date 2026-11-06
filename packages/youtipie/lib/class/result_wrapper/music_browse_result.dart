import 'package:youtipie/class/music/music_chip.dart' show YoutiPieMusicChip;
import 'package:youtipie/class/music/music_form_option.dart' show YoutiPieMusicFormOption;
import 'package:youtipie/class/music/music_shelf.dart' show YoutiPieMusicShelf;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/src/unavailable.dart';

typedef MusicBrowseResult = YoutiPieMusicBrowseResult;

class YoutiPieMusicBrowseResult extends YoutiPieListWrapper<YoutiPieMusicShelf> {
  final List<YoutiPieMusicFormOption> formOptions;
  final List<YoutiPieMusicChip> chips;
  final List<YoutiPieThumbnail> avatarThumbnails;
  final List<YoutiPieThumbnail> bannerThumbnails;
  final String? subtitle;
  final String title;
  final String? channelId;

  const YoutiPieMusicBrowseResult({
    List<YoutiPieMusicShelf> items = const [],
    String? continuation,
    this.formOptions = const [],
    this.chips = const [],
    this.avatarThumbnails = const [],
    this.bannerThumbnails = const [],
    this.subtitle,
    this.title = '',
    this.channelId,
  }) : super(items: items, continuation: continuation);
  String? findSongsPlaylistId() => unavailable('YoutiPieMusicBrowseResult.findSongsPlaylistId');
}
