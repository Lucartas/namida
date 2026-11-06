import 'package:youtipie/src/unavailable.dart';

class CodecInfo {
  final String container;
  final EmbeddedAudioInfo? embeddedAudioInfo;

  const CodecInfo({this.container = '', this.embeddedAudioInfo});

  String codecCleaned() => unavailable('CodecInfo.codecCleaned');
  String? codecIdentifierIfCustom() => unavailable('CodecInfo.codecIdentifierIfCustom');
  bool isExperimentalCodec() => unavailable('CodecInfo.isExperimentalCodec');
}

class EmbeddedAudioInfo {
  final int? audioSampleRate;

  const EmbeddedAudioInfo({this.audioSampleRate});
}
