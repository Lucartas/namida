import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/class/youtipie_feed/channel_info_item.dart' show ChannelInfoItem;

class MusicAlbumInfoItem {
  final String id;
  final String title;
  final String subtitle;
  final List<YoutiPieThumbnail> thumbnails;
  final List<ChannelInfoItem> artists;
  const MusicAlbumInfoItem({this.id = '', this.title = '', this.subtitle = '', this.thumbnails = const [], this.artists = const []});
}
