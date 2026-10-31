import 'dart:typed_data';

import 'namida_waveform.dart' show WaveformError;

export 'namida_waveform.dart' show WaveformError;

Never _unsupported() => throw UnsupportedError('Spectrum analysis is unavailable in this build.');

class SpectrumData {
  final Uint8List rows;
  final int frameCount;
  final int bandCount;
  final int framesPerSecond;
  final Duration duration;
  final int sampleRate;
  final WaveformError error;

  const SpectrumData({
    required this.rows,
    required this.frameCount,
    required this.bandCount,
    required this.framesPerSecond,
    required this.duration,
    required this.sampleRate,
    required this.error,
  });

  static final empty = SpectrumData(
    rows: Uint8List(0),
    frameCount: 0,
    bandCount: 0,
    framesPerSecond: 0,
    duration: Duration.zero,
    sampleRate: 0,
    error: WaveformError.unknown,
  );

  int get stride => bandCount + 1;
  bool get isEmpty => frameCount == 0;
  bool get isNotEmpty => frameCount != 0;
}

abstract final class NamidaSpectrum {
  static SpectrumData extract(String path, {int framesPerSecond = 30, int bandCount = 16}) => _unsupported();

  static int get nativeVersion => _unsupported();
}
