import 'package:nampack/reactive/class/rx.dart';

import '../playlist_manager.dart' show GeneralPlaylist;

class FavouritePlaylist<T, I, S> extends Rx<GeneralPlaylist<T, S>> {
  FavouritePlaylist(String name) : super(GeneralPlaylist<T, S>(name: name, tracks: <T>[]));

  List<T> get tracks => value.tracks;
  bool isSubItemFavourite(I item) => false;
  bool isItemFavourite(T item) => false;
  T? firstItemForSubItem(I item) => null;

}
