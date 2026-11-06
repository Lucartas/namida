import 'package:youtipie/class/publish_time.dart' show PublishTime;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/src/unavailable.dart';

class VideoStreamInfo {
  final String id;
  final String title;
  final int? durSeconds;
  final List<String>? keywords;
  final String? channelName;
  final String? channelId;
  final String? description;
  final List<YoutiPieThumbnail> thumbnails;
  final int? viewsCount;
  final String? viewsText;
  final bool? isPrivate;
  final bool? isUnlisted;
  final bool? isLiveNow;
  final bool? isLiveContent;
  final String? category;
  final PublishTime publishDate;
  final PublishTime uploadDate;
  const VideoStreamInfo({
    this.id = '',
    this.title = '',
    this.durSeconds,
    this.keywords,
    this.channelName,
    this.channelId,
    this.description,
    this.thumbnails = const [],
    this.viewsCount,
    this.viewsText,
    this.isPrivate,
    this.isUnlisted,
    this.isLiveNow,
    this.isLiveContent,
    this.category,
    this.publishDate = const PublishTime.unknown(),
    this.uploadDate = const PublishTime.unknown(),
  });
  String? get availableDescription => unavailable('VideoStreamInfo.availableDescription');
  PublishTime get publishedAt => unavailable('VideoStreamInfo.publishedAt');
  Map<String, dynamic> toMap() => unavailable('VideoStreamInfo.toMap');
  static VideoStreamInfo merge(String id, VideoStreamInfo? oldInfo, VideoStreamInfo newInfo) => unavailable('VideoStreamInfo.merge');
  static VideoStreamInfo fromMap(Map<Object?, Object?> map) => unavailable('VideoStreamInfo.fromMap');
}
