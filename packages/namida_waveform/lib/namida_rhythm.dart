import 'waveform_error.dart';

export 'waveform_error.dart' show WaveformError;

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

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

abstract final class NamidaRhythm {
  static int get nativeVersion => _unavailable('NamidaRhythm.nativeVersion');
  static RhythmData? analyze(String source, {required double bpmHint}) => _unavailable('NamidaRhythm.analyze');
}
