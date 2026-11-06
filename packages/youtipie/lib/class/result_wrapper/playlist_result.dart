import 'package:youtipie/class/result_wrapper/playlist_result_base.dart' show YoutiPiePlaylistResultBase;

typedef PlaylistResult = YoutiPiePlaylistResult;

class YoutiPiePlaylistResult extends YoutiPiePlaylistResultBase {
  const YoutiPiePlaylistResult({required super.basicInfo, required super.items, super.cacheKey, super.continuation});
}
