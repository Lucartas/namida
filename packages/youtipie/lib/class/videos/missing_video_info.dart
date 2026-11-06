import 'package:youtipie/class/publish_time.dart' show PublishTime;
import 'package:youtipie/class/videos/video_result.dart' show YoutiPieVideoPageResult;
import 'package:youtipie/src/unavailable.dart';

class MissingVideoInfo {
  final String videoId;
  final String? title;
  final String? channelId;
  final String? channelName;
  final String? description;
  final PublishTime date;
  final int? durSeconds;
  final YoutiPieVideoPageResult? videoPage;
  final List<Uri> sources;
  final String? subsource;
  const MissingVideoInfo({
    this.videoId = '',
    this.title,
    this.channelId,
    this.channelName,
    this.description,
    this.date = const PublishTime.unknown(),
    this.durSeconds,
    this.videoPage,
    this.sources = const [],
    this.subsource,
  });
  static MissingVideoInfo fromMap(Map<String, dynamic> map) => unavailable('MissingVideoInfo.fromMap');
}
