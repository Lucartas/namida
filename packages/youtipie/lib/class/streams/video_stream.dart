import 'package:youtipie/src/unavailable.dart';

class VideoStream {
  final dynamic id;
  final dynamic url;
  final Duration? duration;
  final int bitrate;
  final dynamic codecInfo;
  final int width;
  final int height;
  final dynamic fps;
  final dynamic itag;
  final String qualityLabel;
  final dynamic isSelected;
  final dynamic displayName;
  final dynamic label;
  final dynamic mimeType;
  final dynamic sampleRate;
  final dynamic channelCount;
  final dynamic isWebm;
  final dynamic sizeInBytes;
  const VideoStream({
    this.id,
    this.url,
    this.duration,
    this.bitrate = 0,
    this.codecInfo,
    this.width = 0,
    this.height = 0,
    this.fps = 0,
    this.itag,
    this.qualityLabel = '',
    this.isSelected = false,
    this.displayName,
    this.label,
    this.mimeType,
    this.sampleRate,
    this.channelCount,
    this.isWebm = false,
    this.sizeInBytes = 0,
  });
  static VideoStream fromMap(dynamic map) => unavailable('VideoStream.fromMap');
  dynamic bitrateText() => unavailable('Remote video stream');
  dynamic buildUrl() => unavailable('Remote video stream');
  Map<String, dynamic> toMap() => unavailable('VideoStream.toMap');
}
