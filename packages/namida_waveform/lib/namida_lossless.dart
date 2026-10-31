import 'namida_waveform.dart' show WaveformError;

export 'namida_waveform.dart' show WaveformError;

Never _unsupported() => throw UnsupportedError('Lossless analysis is unavailable in this build.');

class LosslessCheck {
  final bool isLossless;
  final double cutoffHz;
  final double cutoffDropDB;
  final int sampleRate;
  final int storedBits;
  final int usedBits;
  final Duration duration;
  final WaveformError error;

  const LosslessCheck({
    required this.isLossless,
    required this.cutoffHz,
    required this.cutoffDropDB,
    required this.sampleRate,
    required this.storedBits,
    required this.usedBits,
    required this.duration,
    required this.error,
  });

  static const empty = LosslessCheck(
    isLossless: false,
    cutoffHz: 0,
    cutoffDropDB: 0,
    sampleRate: 0,
    storedBits: 0,
    usedBits: 0,
    duration: Duration.zero,
    error: WaveformError.unknown,
  );
}

abstract final class NamidaLossless {
  static LosslessCheck check(String path) => _unsupported();

  static int get nativeVersion => _unsupported();
}
