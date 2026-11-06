import 'dart:typed_data';

import 'waveform_error.dart';

export 'waveform_error.dart' show WaveformError;

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

class SpectrumData {
  Uint8List get rows => _unavailable('SpectrumData.rows');
  WaveformError get error => _unavailable('SpectrumData.error');
  int get bandCount => _unavailable('SpectrumData.bandCount');
  int get framesPerSecond => _unavailable('SpectrumData.framesPerSecond');
}

abstract final class NamidaSpectrum {
  static SpectrumData extract(String path, {required int framesPerSecond, required int bandCount}) => _unavailable('NamidaSpectrum.extract');
}
