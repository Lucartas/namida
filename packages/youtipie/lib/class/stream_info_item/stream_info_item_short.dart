import 'package:youtipie/class/map_serializable.dart' show MapSerializable;

class StreamInfoItemShort extends MapSerializable {
  final String id;
  final String title;
  final dynamic viewsText;
  final dynamic viewsCount;
  final dynamic liveThumbs;
  const StreamInfoItemShort({this.id = '', this.title = '', this.viewsText, this.viewsCount, this.liveThumbs});
}
