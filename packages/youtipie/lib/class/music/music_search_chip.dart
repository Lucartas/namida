import 'package:youtipie/core/enum.dart' show YoutiPieMusicSearchType;

typedef MusicSearchChip = YoutiPieMusicSearchChip;

class YoutiPieMusicSearchChip {
  final String title;
  final bool isSelected;
  final YoutiPieMusicSearchType? type;
  final String? params;

  const YoutiPieMusicSearchChip({this.title = '', this.isSelected = false, this.type, this.params});
}
