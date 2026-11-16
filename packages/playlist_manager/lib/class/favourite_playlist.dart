import 'package:nampack/reactive/class/rx.dart';

import '../playlist_manager.dart' show GeneralPlaylist;

class FavouritePlaylist<T, I, S> extends Rx<GeneralPlaylist<T, S>> {
  FavouritePlaylist(String name) : super(GeneralPlaylist<T, S>(name: name, tracks: <T>[], isFav: true));

  List<T> get tracks => value.tracks;

  bool isSubItemFavourite(I item) => tracks.any((track) => _matchesSubItem(track, item));

  bool isItemFavourite(T item) => tracks.contains(item);

  T? firstItemForSubItem(I item) {
    for (final track in tracks) {
      if (_matchesSubItem(track, item)) return track;
    }
    return null;
  }

  bool _matchesSubItem(T track, I item) {
    if (track == item) return true;
    try {
      final dynamic candidate = track;
      if (candidate.item == item) return true;
    } catch (_) {}
    try {
      final dynamic candidate = track;
      if (candidate.track == item) return true;
    } catch (_) {}
    try {
      final dynamic candidate = track;
      if (candidate.id == item) return true;
    } catch (_) {}
    return false;
  }
}
