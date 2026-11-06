import 'package:youtipie/src/unavailable.dart';

class AudioTrack {
  final String? id;
  final String? displayName;
  final String? label;
  final String? langCode;
  final bool? isDefault;
  const AudioTrack({this.id, this.displayName, this.label, this.langCode, this.isDefault});

  String get displayNameOrLangCode => unavailable('AudioTrack.displayNameOrLangCode');
}
