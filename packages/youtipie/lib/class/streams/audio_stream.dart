import 'package:youtipie/src/unavailable.dart';

class AudioStream {
  final dynamic id;
  final dynamic url;
  final Duration? duration;
  final int bitrate;
  final dynamic codecInfo;
  final dynamic audioTrack;
  final dynamic itag;
  final dynamic isWebm;
  final dynamic sizeInBytes;
  final dynamic sampleRate;
  final dynamic channelCount;
  const AudioStream({
    this.id,
    this.url,
    this.duration,
    this.bitrate = 0,
    this.codecInfo,
    this.audioTrack,
    this.itag,
    this.isWebm = false,
    this.sizeInBytes = 0,
    this.sampleRate,
    this.channelCount,
  });
  static AudioStream fromMap(dynamic map) => unavailable('AudioStream.fromMap');
  dynamic bitrateText() => unavailable('Remote audio stream');
  dynamic buildUrl() => unavailable('Remote audio stream');
  Map<String, dynamic> toMap() => unavailable('AudioStream.toMap');
}
