import 'package:nampack/reactive/class/rx.dart';

import '../playlist_manager.dart' show GeneralPlaylist;

class FavouritePlaylist<T, I, S> extends Rx<GeneralPlaylist<T, S>> {
  FavouritePlaylist(String name) : super(_unavailable('FavouritePlaylist'));

  List<T> get tracks => _unavailable('FavouritePlaylist.tracks');
  bool isSubItemFavourite(I item) => _unavailable('FavouritePlaylist.isSubItemFavourite');
  bool isItemFavourite(T item) => _unavailable('FavouritePlaylist.isItemFavourite');
  T? firstItemForSubItem(I item) => _unavailable('FavouritePlaylist.firstItemForSubItem');
}

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');
