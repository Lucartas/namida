import 'package:youtipie/class/streams/codec_info.dart' show CodecInfo;
import 'package:youtipie/class/streams/stream_base.dart' show StreamBase;
import 'package:youtipie/src/unavailable.dart';

class VideoStream implements StreamBase {
  final String? id;
  final Uri? url;
  final Duration? duration;
  final int bitrate;
  @override
  final CodecInfo codecInfo;
  final int width;
  final int height;
  final double fps;
  final int? itag;
  final String qualityLabel;
  final bool isSelected;
  final String? displayName;
  final String? label;
  final String? mimeType;
  final int? sampleRate;
  final int? channelCount;
  final bool isWebm;
  @override
  final int sizeInBytes;
  const VideoStream({
    this.id,
    this.url,
    this.duration,
    this.bitrate = 0,
    this.codecInfo = const CodecInfo(),
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
  static VideoStream fromMap(Map<String, dynamic> map) => unavailable('VideoStream.fromMap');
  String bitrateText() => unavailable('Remote video stream');
  Uri? buildUrl() => unavailable('Remote video stream');
  Map<String, dynamic> toMap() => unavailable('VideoStream.toMap');
}
