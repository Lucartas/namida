import 'package:youtipie/class/channels/channel_about_link.dart' show ChannelAboutLink;

class ChannelPageAbout {
  final String? description;
  final List<ChannelAboutLink> aboutLinks;
  final String? canonicalChannelUrl;
  final int? subscriberCount;
  final String? subscriberCountText;
  final int? videoCount;
  final String? videoCountText;
  final int? viewCount;
  final String? viewCountText;
  final String? joinedText;
  final String? country;

  const ChannelPageAbout({
    this.description,
    this.aboutLinks = const [],
    this.canonicalChannelUrl,
    this.subscriberCount,
    this.subscriberCountText,
    this.videoCount,
    this.videoCountText,
    this.viewCount,
    this.viewCountText,
    this.joinedText,
    this.country,
  });
}
