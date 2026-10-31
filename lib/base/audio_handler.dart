import 'package:basic_audio_handler/basic_audio_handler.dart';

Never _offlinePlaybackUnavailable(String operation) => throw UnsupportedError(
  '$operation is unavailable in Milestone 1; local playback support is implemented in Milestone 2.',
);

/// Compile-time adapter for the upstream audio handler.
///
/// Keeping the API boundary local lets the Android target build while the real
/// offline playback implementation is developed in Milestone 2.
class NamidaAudioVideoHandler<Q> extends BasicAudioHandler<Q> {
  NamidaAudioVideoHandler();

  static bool supportsSkipSilence(dynamic _) => false;

  static dynamic createPlayer({
    bool disableVideo = true,
    dynamic Function()? exoplayerCreator,
    dynamic Function()? exoplayerSWCreator,
  }) => _offlinePlaybackUnavailable('Audio player creation');
}
