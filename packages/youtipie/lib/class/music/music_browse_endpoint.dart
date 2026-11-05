import 'package:youtipie/src/unavailable.dart';

typedef MusicBrowseEndpoint = dynamic;

class YoutiPieMusicBrowseEndpoint {
  final String browseId;
  const YoutiPieMusicBrowseEndpoint(this.browseId);
  static const home = YoutiPieMusicBrowseEndpoint('home');
  static const explore = YoutiPieMusicBrowseEndpoint('explore');
  static const charts = YoutiPieMusicBrowseEndpoint('charts');
  static const moodsAndGenres = YoutiPieMusicBrowseEndpoint('moodsAndGenres');
  static const newReleases = YoutiPieMusicBrowseEndpoint('newReleases');
  String? extractPlaylistId() => unavailable('YoutiPieMusicBrowseEndpoint.extractPlaylistId');
  YoutiPieMusicBrowseEndpoint withFormValues(dynamic values) => unavailable('YoutiPieMusicBrowseEndpoint.withFormValues');
}
