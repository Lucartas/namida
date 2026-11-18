import 'package:youtipie/src/unavailable.dart';

class MapSerializable {
  const MapSerializable();

  String? get cacheKey => unavailable('MapSerializable.cacheKey');

  static const String dummyKey = '_dummy';
  static const String timestampKey = '_timestamp';
}

abstract interface class YoutiPieFeedItem {
  bool get isShortContent;
}

extension YoutiPieFeedItemMixPlaylist on YoutiPieFeedItem {
  bool get isMixPlaylist => unavailable('YoutiPieFeedItem.isMixPlaylist');
}
