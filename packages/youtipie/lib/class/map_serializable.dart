import 'package:youtipie/src/unavailable.dart';

class MapSerializable {
  const MapSerializable();

  static const String dummyKey = '_dummy';
  static const String timestampKey = '_timestamp';
}

abstract interface class YoutiPieFeedItem {
  bool get isShortContent;
}

extension YoutiPieFeedItemMixPlaylist on YoutiPieFeedItem {
  bool get isMixPlaylist => unavailable('YoutiPieFeedItem.isMixPlaylist');
}
