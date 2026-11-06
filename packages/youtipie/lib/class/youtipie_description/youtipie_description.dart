class YoutipieDescription {
  final String? rawText;
  final List<StylesWrapper>? parts;

  const YoutipieDescription({this.rawText, this.parts});
}

class StylesWrapper {
  final String text;
  final String? attachementUrl;
  final String? hashtag;
  final String? hashtagParams;
  final String? videoId;
  final int? videoStartSeconds;
  final String? channelId;
  final String? playlistId;
  final String? link;
  final String? linkClean;
  final bool italic;
  final bool bold;
  final bool strikethrough;

  const StylesWrapper({
    this.text = '',
    this.attachementUrl,
    this.hashtag,
    this.hashtagParams,
    this.videoId,
    this.videoStartSeconds,
    this.channelId,
    this.playlistId,
    this.link,
    this.linkClean,
    this.italic = false,
    this.bold = false,
    this.strikethrough = false,
  });
}
