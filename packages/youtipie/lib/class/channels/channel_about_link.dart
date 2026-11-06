import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;

class ChannelAboutLink {
  final String title;
  final String linkText;
  final String? link;
  final List<YoutiPieThumbnail> icons;

  const ChannelAboutLink({this.title = '', this.linkText = '', this.link, this.icons = const []});
}
