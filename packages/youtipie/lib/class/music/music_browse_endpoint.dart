import 'package:youtipie/src/unavailable.dart';

typedef MusicBrowseEndpoint = YoutiPieMusicBrowseEndpoint;

class YoutiPieMusicBrowseEndpoint {
  final String browseId;
  const YoutiPieMusicBrowseEndpoint(this.browseId);
  static const home = YoutiPieMusicBrowseEndpoint('home');
  static const explore = YoutiPieMusicBrowseEndpoint('explore');
  static const charts = YoutiPieMusicBrowseEndpoint('charts');
  static const moodsAndGenres = YoutiPieMusicBrowseEndpoint('moodsAndGenres');
  static const newReleases = YoutiPieMusicBrowseEndpoint('newReleases');
  String? extractPlaylistId() => unavailable('YoutiPieMusicBrowseEndpoint.extractPlaylistId');
  YoutiPieMusicBrowseEndpoint withFormValues(List<String> values) => unavailable('YoutiPieMusicBrowseEndpoint.withFormValues');
}
