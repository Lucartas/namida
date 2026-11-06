import 'package:youtipie/class/music/music_browse_endpoint.dart' show YoutiPieMusicBrowseEndpoint;

typedef MusicChip = YoutiPieMusicChip;

class YoutiPieMusicChip {
  final String title;
  final YoutiPieMusicBrowseEndpoint endpoint;
  final bool isSelected;

  const YoutiPieMusicChip({this.title = '', required this.endpoint, this.isSelected = false});
}
