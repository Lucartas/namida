import 'package:youtipie/src/unavailable.dart';

class VideoStreamInfo {
  final String id;
  final String title;
  final dynamic durSeconds;
  final dynamic keywords;
  final dynamic channelName;
  final dynamic channelId;
  final dynamic description;
  final dynamic thumbnails;
  final dynamic viewsCount;
  final dynamic isPrivate;
  final dynamic isUnlisted;
  final dynamic isLiveNow;
  final dynamic isLiveContent;
  final dynamic category;
  final dynamic publishDate;
  final dynamic uploadDate;
  const VideoStreamInfo({
    this.id = '',
    this.title = '',
    this.durSeconds,
    this.keywords,
    this.channelName,
    this.channelId,
    this.description,
    this.thumbnails,
    this.viewsCount,
    this.isPrivate,
    this.isUnlisted,
    this.isLiveNow,
    this.isLiveContent,
    this.category,
    this.publishDate,
    this.uploadDate,
  });
  dynamic get availableDescription => unavailable('VideoStreamInfo.availableDescription');
  dynamic get publishedAt => unavailable('VideoStreamInfo.publishedAt');
  Map<String, dynamic> toMap() => unavailable('VideoStreamInfo.toMap');
  static VideoStreamInfo merge(String id, VideoStreamInfo? oldInfo, VideoStreamInfo newInfo) => unavailable('VideoStreamInfo.merge');
  static VideoStreamInfo fromMap(dynamic map) => unavailable('VideoStreamInfo.fromMap');
}
