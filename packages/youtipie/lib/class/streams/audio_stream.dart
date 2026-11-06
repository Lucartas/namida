import 'package:youtipie/class/streams/audio_track.dart' show AudioTrack;
import 'package:youtipie/class/streams/codec_info.dart' show CodecInfo;
import 'package:youtipie/class/streams/stream_base.dart' show StreamBase;
import 'package:youtipie/src/unavailable.dart';

class AudioStream implements StreamBase {
  final String? id;
  final Uri? url;
  final Duration? duration;
  final int bitrate;
  @override
  final CodecInfo codecInfo;
  final AudioTrack? audioTrack;
  final int? itag;
  final bool isWebm;
  @override
  final int sizeInBytes;
  final int? sampleRate;
  final int? channelCount;
  const AudioStream({
    this.id,
    this.url,
    this.duration,
    this.bitrate = 0,
    this.codecInfo = const CodecInfo(),
    this.audioTrack,
    this.itag,
    this.isWebm = false,
    this.sizeInBytes = 0,
    this.sampleRate,
    this.channelCount,
  });
  static AudioStream fromMap(Map<String, dynamic> map) => unavailable('AudioStream.fromMap');
  String bitrateText() => unavailable('Remote audio stream');
  Uri? buildUrl() => unavailable('Remote audio stream');
  Map<String, dynamic> toMap() => unavailable('AudioStream.toMap');
}
