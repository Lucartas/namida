import 'waveform_error.dart';

export 'waveform_error.dart' show WaveformError;

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

class LosslessCheck {
  bool get isLossless => _unavailable('LosslessCheck.isLossless');
  WaveformError get error => _unavailable('LosslessCheck.error');
  int get usedBits => _unavailable('LosslessCheck.usedBits');
  int get storedBits => _unavailable('LosslessCheck.storedBits');
  double get cutoffDropDB => _unavailable('LosslessCheck.cutoffDropDB');
  int get sampleRate => _unavailable('LosslessCheck.sampleRate');
  double get cutoffHz => _unavailable('LosslessCheck.cutoffHz');
}

abstract final class NamidaLossless {
  static int get nativeVersion => _unavailable('NamidaLossless.nativeVersion');
  static LosslessCheck check(String path) => _unavailable('NamidaLossless.check');
}
