import 'dart:typed_data';

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

enum WaveformError { none, openInput }

class WaveformData {
  Float32List get values => _unavailable('WaveformData.values');
  WaveformError get error => _unavailable('WaveformData.error');
}

class RhythmData {
  double get bpm => _unavailable('RhythmData.bpm');
  double get beatOffsetMS => _unavailable('RhythmData.beatOffsetMS');
  double get beatConfidence => _unavailable('RhythmData.beatConfidence');
  int get key => _unavailable('RhythmData.key');
  double get keyConfidence => _unavailable('RhythmData.keyConfidence');
  int get audibleStartMS => _unavailable('RhythmData.audibleStartMS');
  int get audibleEndMS => _unavailable('RhythmData.audibleEndMS');
  int get fadeOutStartMS => _unavailable('RhythmData.fadeOutStartMS');
  WaveformError get error => _unavailable('RhythmData.error');
}

class LosslessCheck {
  bool get isLossless => _unavailable('LosslessCheck.isLossless');
  WaveformError get error => _unavailable('LosslessCheck.error');
  int get usedBits => _unavailable('LosslessCheck.usedBits');
  int get storedBits => _unavailable('LosslessCheck.storedBits');
  double get cutoffDropDB => _unavailable('LosslessCheck.cutoffDropDB');
  int get sampleRate => _unavailable('LosslessCheck.sampleRate');
  double get cutoffHz => _unavailable('LosslessCheck.cutoffHz');
}

class SpectrumData {
  Uint8List get rows => _unavailable('SpectrumData.rows');
  WaveformError get error => _unavailable('SpectrumData.error');
  int get bandCount => _unavailable('SpectrumData.bandCount');
  int get framesPerSecond => _unavailable('SpectrumData.framesPerSecond');
}

class PaletteData {
  Uint32List get colors => _unavailable('PaletteData.colors');
}

abstract final class NamidaWaveform {
  static WaveformData extract(String path, {required int samplesPerSecond}) => _unavailable('NamidaWaveform.extract');
  static int sampleRateForDuration({required Duration audioDuration, required int maxSampleRate, required double scaleFactor}) =>
      _unavailable('NamidaWaveform.sampleRateForDuration');
}

abstract final class NamidaRhythm {
  static int get nativeVersion => _unavailable('NamidaRhythm.nativeVersion');
  static RhythmData? analyze(String source, {required double bpmHint}) => _unavailable('NamidaRhythm.analyze');
}

abstract final class NamidaLossless {
  static int get nativeVersion => _unavailable('NamidaLossless.nativeVersion');
  static LosslessCheck check(String path) => _unavailable('NamidaLossless.check');
}

abstract final class NamidaSpectrum {
  static SpectrumData extract(String path, {required int framesPerSecond, required int bandCount}) => _unavailable('NamidaSpectrum.extract');
}

abstract final class NamidaPalette {
  static Future<PaletteData> extractAsync({String? path, Uint8List? bytes, required int maxColors, required int maxHeight}) =>
      _unavailable('NamidaPalette.extractAsync');
}
