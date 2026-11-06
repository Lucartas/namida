import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/src/unavailable.dart';

typedef Thumbnail = YoutiPieThumbnail;

class YoutiPieThumbnail extends MapSerializable {
  final dynamic url;
  final dynamic width;
  final dynamic height;

  const YoutiPieThumbnail({this.url, this.width, this.height});
}

abstract final class YoutiPieVideoThumbnail {
  static List<String> mix(String id) => unavailable('YoutiPieVideoThumbnail.mix');
  static List<String> mixLow(String id) => unavailable('YoutiPieVideoThumbnail.mixLow');
}
