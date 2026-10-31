import 'dart:math' as math;
import 'dart:typed_data';

Never _unsupported(String operation) => throw UnsupportedError(
  '$operation is unavailable in this build; native media analysis has not been added yet.',
);

enum WaveformError {
  none,
  allocation,
  openInput,
  streamInfo,
  noAudioStream,
  noDecoder,
  decoderOpen,
  unsupportedFormat,
  noOutput,
  unknown,
}

class WaveformData {
  final Float32List values;
  final Duration duration;
  final int sampleRate;
  final int channels;
  final WaveformError error;

  const WaveformData({
    required this.values,
    required this.duration,
    required this.sampleRate,
    required this.channels,
    required this.error,
  });

  static final empty = WaveformData(
    values: Float32List(0),
    duration: Duration.zero,
    sampleRate: 0,
    channels: 0,
    error: WaveformError.unknown,
  );

  bool get isEmpty => values.isEmpty;
  bool get isNotEmpty => values.isNotEmpty;
}

abstract final class NamidaWaveform {
  static WaveformData extract(String path, {int samplesPerSecond = 100}) => _unsupported('Waveform extraction');

  static Future<WaveformData> extractInIsolate(String path, {int samplesPerSecond = 100}) async => _unsupported('Waveform extraction');

  static int get nativeVersion => _unsupported('Waveform analysis');

  static int sampleRateForDuration({required Duration audioDuration, int maxSampleRate = 400, double scaleFactor = 0.4}) {
    final scaledDuration = scaleFactor * audioDuration.inSeconds;
    final scaledSampleRate = maxSampleRate * math.exp(-scaledDuration / 100);
    return scaledSampleRate.clamp(1, maxSampleRate).round();
  }
}
