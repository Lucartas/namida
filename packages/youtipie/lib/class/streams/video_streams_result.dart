import 'package:youtipie/class/streams/audio_stream.dart' show AudioStream;
import 'package:youtipie/class/streams/caption.dart' show Caption;
import 'package:youtipie/class/streams/endscreens/endscreen_item_base.dart' show EndScreenItemBase;
import 'package:youtipie/class/streams/video_stream.dart' show VideoStream;
import 'package:youtipie/class/streams/video_stream_info.dart' show VideoStreamInfo;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/class/videos/video_playability.dart' show VideoPlayability;
import 'package:youtipie/core/enum.dart' show InnertubeClients;
import 'package:youtipie/src/unavailable.dart';

class VideoOverlay {
  final List<YoutiPieThumbnail> overlays;

  const VideoOverlay({this.overlays = const []});
}

class LoudnessDBData {
  final num? loudnessDb;

  const LoudnessDBData({this.loudnessDb});
}

class VideoStreamsResult {
  final String videoId;
  final VideoStreamInfo? info;
  final List<AudioStream> audioStreams;
  final List<VideoStream> videoStreams;
  final List<Caption> captions;
  final VideoPlayability playability;
  final List<VideoStream> mixedStreams;
  final String? statsPlaybackUrl;
  final String? statsWatchtimeUrl;
  final VideoOverlay? overlay;
  final List<EndScreenItemBase> endscreens;
  final LoudnessDBData? loudnessDBData;
  final InnertubeClients? client;
  final String? hlsManifestUrl;
  final String? dashManifestUrl;
  final Map<String, AudioStream>? audioStreamsOrganizedByLanguage;
  const VideoStreamsResult({
    this.videoId = '',
    this.info,
    this.audioStreams = const [],
    this.videoStreams = const [],
    this.captions = const [],
    this.playability = const VideoPlayability(),
    this.mixedStreams = const [],
    this.statsPlaybackUrl,
    this.statsWatchtimeUrl,
    this.overlay,
    this.endscreens = const [],
    this.loudnessDBData,
    this.client,
    this.hlsManifestUrl,
    this.dashManifestUrl,
    this.audioStreamsOrganizedByLanguage,
  });
  bool hasExpired() => unavailable('VideoStreamsResult.hasExpired');
  Map<String, dynamic> toMap() => unavailable('VideoStreamsResult.toMap');
}
