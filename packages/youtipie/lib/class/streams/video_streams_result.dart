import 'package:youtipie/class/streams/audio_stream.dart' show AudioStream;
import 'package:youtipie/class/streams/video_stream.dart' show VideoStream;
import 'package:youtipie/class/streams/video_stream_info.dart' show VideoStreamInfo;
import 'package:youtipie/src/unavailable.dart';

class VideoStreamsResult {
  final dynamic videoId;
  final VideoStreamInfo? info;
  final List<AudioStream> audioStreams;
  final List<VideoStream> videoStreams;
  final dynamic captions;
  final dynamic playability;
  final dynamic mixedStreams;
  final dynamic statsPlaybackUrl;
  final dynamic statsWatchtimeUrl;
  final dynamic overlay;
  final dynamic endscreens;
  final dynamic loudnessDBData;
  final String? hlsManifestUrl;
  final String? dashManifestUrl;
  final Map<String, AudioStream>? audioStreamsOrganizedByLanguage;
  const VideoStreamsResult({
    this.videoId,
    this.info,
    this.audioStreams = const [],
    this.videoStreams = const [],
    this.captions = const [],
    this.playability,
    this.mixedStreams = const [],
    this.statsPlaybackUrl,
    this.statsWatchtimeUrl,
    this.overlay,
    this.endscreens = const [],
    this.loudnessDBData,
    this.hlsManifestUrl,
    this.dashManifestUrl,
    this.audioStreamsOrganizedByLanguage,
  });
  bool hasExpired() => unavailable('VideoStreamsResult.hasExpired');
  Map<String, dynamic> toMap() => unavailable('VideoStreamsResult.toMap');
}
