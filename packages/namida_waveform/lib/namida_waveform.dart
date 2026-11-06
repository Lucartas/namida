import 'dart:typed_data';

import 'waveform_error.dart';

export 'namida_lossless.dart' show LosslessCheck, NamidaLossless;
export 'namida_palette.dart';
export 'namida_rhythm.dart' show NamidaRhythm, RhythmData;
export 'namida_spectrum.dart' show NamidaSpectrum, SpectrumData;
export 'waveform_error.dart';

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

class WaveformData {
  Float32List get values => _unavailable('WaveformData.values');
  WaveformError get error => _unavailable('WaveformData.error');
}

abstract final class NamidaWaveform {
  static WaveformData extract(String path, {required int samplesPerSecond}) => _unavailable('NamidaWaveform.extract');
  static int sampleRateForDuration({required Duration audioDuration, required int maxSampleRate, required double scaleFactor}) =>
      _unavailable('NamidaWaveform.sampleRateForDuration');
}
