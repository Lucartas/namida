import 'package:youtipie/class/result_wrapper/playlist_result_base.dart' show YoutiPiePlaylistResultBase;
import 'package:youtipie/class/result_wrapper/related_videos_result.dart' show YoutiPieRelatedVideosResult;
import 'package:youtipie/src/unavailable.dart';

typedef PlaylistMixResult = YoutiPieMixPlaylistResult;

class YoutiPieMixPlaylistResult extends YoutiPiePlaylistResultBase {
  final String? mixId;

  const YoutiPieMixPlaylistResult({required super.basicInfo, required super.items, super.cacheKey, super.continuation, this.mixId});

  YoutiPieRelatedVideosResult toRelatedVideosResult() => unavailable('YoutiPieMixPlaylistResult.toRelatedVideosResult');
}
