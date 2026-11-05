import 'package:youtipie/class/map_serializable.dart' show MapSerializable;

typedef Thumbnail = YoutiPieThumbnail;

class YoutiPieThumbnail extends MapSerializable {
  final dynamic url;
  final dynamic width;
  final dynamic height;

  const YoutiPieThumbnail({this.url, this.width, this.height});
}
