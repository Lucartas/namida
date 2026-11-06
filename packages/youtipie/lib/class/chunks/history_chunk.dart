import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/map_serializable.dart' show YoutiPieFeedItem;

typedef HistoryChunk = YoutiPieHistoryChunk;

class _MockValue<T> {
  final T value;
  const _MockValue(this.value);
}

class YoutiPieHistoryChunk extends MapSerializable {
  final String title;
  // Search and history rows are a heterogeneous feed union. The app switches
  // on runtimeType and then uses each concrete row shape directly.
  final List<YoutiPieFeedItem> items;
  final _MockValue<int> shortsItemsCount;
  final _MockValue<int> mixesPlaylistCount;

  const YoutiPieHistoryChunk({this.title = '', this.items = const [], _MockValue<int>? shortsItemsCount, _MockValue<int>? mixesPlaylistCount})
    : shortsItemsCount = shortsItemsCount ?? const _MockValue<int>(0),
      mixesPlaylistCount = mixesPlaylistCount ?? const _MockValue<int>(0);
}
