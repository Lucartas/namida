import 'package:youtipie/class/map_serializable.dart' show MapSerializable;

typedef HistoryChunk = YoutiPieHistoryChunk;

class _MockValue<T> {
  final T value;
  const _MockValue(this.value);
}

class YoutiPieHistoryChunk extends MapSerializable {
  final String title;
  final List<dynamic> items;
  final _MockValue<int> shortsItemsCount;
  final _MockValue<int> mixesPlaylistCount;

  const YoutiPieHistoryChunk({this.title = '', this.items = const [], _MockValue<int>? shortsItemsCount, _MockValue<int>? mixesPlaylistCount})
    : shortsItemsCount = shortsItemsCount ?? const _MockValue<int>(0),
      mixesPlaylistCount = mixesPlaylistCount ?? const _MockValue<int>(0);
}
