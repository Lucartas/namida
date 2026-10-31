import 'namida_waveform.dart' show WaveformError;

export 'namida_waveform.dart' show WaveformError;

Never _unsupported() => throw UnsupportedError('Rhythm analysis is unavailable in this build.');

class RhythmData {
  final double bpm;
  final double beatOffsetMS;
  final double beatConfidence;
  final int key;
  final double keyConfidence;
  final int audibleStartMS;
  final int audibleEndMS;
  final int fadeOutStartMS;
  final Duration duration;
  final int sampleRate;
  final WaveformError error;

  const RhythmData({
    required this.bpm,
    required this.beatOffsetMS,
    required this.beatConfidence,
    required this.key,
    required this.keyConfidence,
    required this.audibleStartMS,
    required this.audibleEndMS,
    required this.fadeOutStartMS,
    required this.duration,
    required this.sampleRate,
    required this.error,
  });

  static const empty = RhythmData(
    bpm: 0,
    beatOffsetMS: 0,
    beatConfidence: 0,
    key: -1,
    keyConfidence: 0,
    audibleStartMS: 0,
    audibleEndMS: 0,
    fadeOutStartMS: 0,
    duration: Duration.zero,
    sampleRate: 0,
    error: WaveformError.unknown,
  );
}

abstract final class NamidaRhythm {
  static RhythmData analyze(String path, {double bpmHint = 0}) => _unsupported();

  static int get nativeVersion => _unsupported();
}
