import 'package:youtipie/class/channels/channel_info.dart' show YoutiPieChannelInfo;
import 'package:youtipie/class/result_wrapper/comment_result.dart' show YoutiPieCommentResult;
import 'package:youtipie/class/result_wrapper/related_videos_result.dart' show YoutiPieRelatedVideosResult;
import 'package:youtipie/class/streams/stream_segments.dart' show StreamSegment;
import 'package:youtipie/class/videos/video_heat_map.dart' show YoutiPieVideoHeatMap;
import 'package:youtipie/class/videos/video_info.dart' show YoutiPieVideoInfo;
import 'package:youtipie/src/unavailable.dart';

typedef VideoResult = YoutiPieVideoPageResult;

class YoutiPieVideoPageResult {
  final String videoId;
  final DateTime? timestamp;
  final YoutiPieVideoInfo? videoInfo;
  final YoutiPieChannelInfo? channelInfo;
  final List<StreamSegment> streamSegments;
  final List<YoutiPieVideoHeatMap> heatMap;
  final YoutiPieCommentResult commentResult;
  final YoutiPieRelatedVideosResult? relatedVideosResult;

  const YoutiPieVideoPageResult({
    this.videoId = '',
    this.timestamp,
    this.videoInfo,
    this.channelInfo,
    this.streamSegments = const [],
    this.heatMap = const [],
    this.commentResult = const YoutiPieCommentResult(),
    this.relatedVideosResult,
  });

  Map<String, dynamic> toMap() => unavailable('YoutiPieVideoPageResult.toMap');
}
