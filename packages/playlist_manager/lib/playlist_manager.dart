import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:nampack/reactive/class/rx.dart';
import 'package:nampack/reactive/types/rxmap/rx_map.dart';

import 'class/favourite_playlist.dart';
import 'core/enum.dart';
import 'module/playlist_id.dart';

export 'class/favourite_playlist.dart';
export 'core/enum.dart';
export 'module/playlist_id.dart';

Never _offlinePlaylistUnavailable(String operation) => throw UnsupportedError(
  '$operation is unavailable in this build.',
);

mixin PlaylistItemWithDate {
  // The item is supplied by the app (for example a local watch-history row).
  // playlist_manager cannot name that app-specific model without a dependency cycle.
  // The mixin is shared by app models with different item types, so consumers narrow at runtime.
  dynamic get item => _offlinePlaylistUnavailable('PlaylistItemWithDate.item');
}

class GeneralPlaylist<T, S> {
  String name;
  List<T> tracks;
  int creationDate;
  int modifiedDate;
  String comment;
  List<String> moods;
  List<String> tags;
  bool isPinned;
  bool isFav;
  PlaylistRemoteSource? remoteSource;
  String? m3uPath;
  List<S>? sortsType;
  bool sortReverse;
  List<T>? customOrder;

  GeneralPlaylist({
    required this.name,
    required this.tracks,
    this.creationDate = 0,
    this.modifiedDate = 0,
    this.comment = '',
    this.moods = const [],
    this.tags = const [],
    this.isPinned = false,
    this.isFav = false,
    this.remoteSource,
    this.m3uPath,
    this.sortsType,
    this.sortReverse = false,
    this.customOrder,
  });

  bool get isReadOnly => _offlinePlaylistUnavailable('GeneralPlaylist.isReadOnly');
  PlaylistID? get playlistID => _offlinePlaylistUnavailable('GeneralPlaylist.playlistID');

  GeneralPlaylist<T, S> copyWith({
    String? name,
    List<T>? tracks,
    int? creationDate,
    int? modifiedDate,
    String? comment,
    List<String>? moods,
    List<String>? tags,
    bool? isPinned,
    bool? isFav,
    String? m3uPath,
    List<S>? sortsType,
    bool? sortReverse,
    PlaylistRemoteSource? remoteSource,
    List<T>? customOrder,
  }) => _offlinePlaylistUnavailable('GeneralPlaylist.copyWith');

  GeneralPlaylist<E, S> copyWithConvertedTracks<E>(E Function(T track) convert) => _offlinePlaylistUnavailable('GeneralPlaylist.copyWithConvertedTracks');

  factory GeneralPlaylist.fromJson(
    Map<String, dynamic> value, [
    T Function(Map<String, dynamic>)? itemFromJson,
    List<S> Function(Object?)? sortFromJson,
  ]) => _offlinePlaylistUnavailable('GeneralPlaylist.fromJson');

  Map<String, dynamic> toJson(
    Object? Function(T)? itemToJson,
    Object? Function(List<S>)? sortToJson, {
    bool includeTracks = true,
  }) => _offlinePlaylistUnavailable('GeneralPlaylist.toJson');

  String toTagsAndMoodsText() => _offlinePlaylistUnavailable('GeneralPlaylist.toTagsAndMoodsText');
}

class PlaylistManager<T, I, S> {
  PlaylistManager() {
    _offlinePlaylistUnavailable('PlaylistManager');
  }

  late final RxMap<String, GeneralPlaylist<T, S>> playlistsMap;
  late final FavouritePlaylist<T, I, S> favouritesPlaylist;
  late final PlaylistTagsFilter tagsFilter;
  late final Rx<List<String>?> customIndicesOrderRx;
  late final Rx<bool> canReorderItems;
  int get currentTimeMS => _offlinePlaylistUnavailable('PlaylistManager.currentTimeMS');
  Future<void> get waitForPlaylistsLoad => _offlinePlaylistUnavailable('PlaylistManager.waitForPlaylistsLoad');
  Future<void> get waitForFavouritePlaylistLoad => _offlinePlaylistUnavailable('PlaylistManager.waitForFavouritePlaylistLoad');

  RegExp get cleanupFilenameRegex => _offlinePlaylistUnavailable('PlaylistManager.cleanupFilenameRegex');
  I identifyBy(T item) => _offlinePlaylistUnavailable('Playlist item lookup');
  int? getMetadataEditDate(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Playlist metadata');
  GeneralPlaylist<T, S>? getPlaylist(String name) => _offlinePlaylistUnavailable('PlaylistManager.getPlaylist');
  File getArtworkFileForPlaylist(String name) => _offlinePlaylistUnavailable('Playlist artwork');
  bool isOneOfDefaultPlaylists(String name) => _offlinePlaylistUnavailable('Default playlist lookup');
  String? validatePlaylistName(String? name) => _offlinePlaylistUnavailable('Playlist name validation');
  void resetCanReorder() => _offlinePlaylistUnavailable('Playlist reordering');
  Future<void> updatePropertyInPlaylist(
    String playlist, {
    List<T>? tracks,
    List<I>? tracksRaw,
    T Function(I item, int dateAdded)? convertItem,
    bool? tracksFromNewSource,
    int? modifiedDate,
    int? creationDate,
    bool? itemsSortReverse,
    List<S>? itemsSortType,
    bool? restoreCustomOrder,
    String? comment,
    List<String>? tags,
    List<String>? moods,
    bool? isPinned,
    bool? isFav,
    String? m3uPath,
    PlaylistRemoteSource? remoteSource,
    List<S>? sortsType,
    bool? sortReverse,
  }) => _offlinePlaylistUnavailable('Playlist metadata');
  Future<int> importTracksToPlaylist(GeneralPlaylist<T, S> playlist, Iterable<T> tracks, {int? index, Object? source}) => _offlinePlaylistUnavailable('Import tracks to playlist');
  Future<void> removeTracksFromPlaylist(GeneralPlaylist<T, S> playlist, List<int> indices) => _offlinePlaylistUnavailable('Remove tracks from playlist');
  void reorderTrack(GeneralPlaylist<T, S> playlist, int oldIndex, int newIndex) => _offlinePlaylistUnavailable('Reorder playlist tracks');
  Future<void> replaceTheseTracksInPlaylists(bool Function(T item) test, T Function(T oldItem) replace) => _offlinePlaylistUnavailable('Update playlist tracks');
  Future<void> replaceTheseTracksInPlaylistsBulk(List<MapEntry<bool Function(T item), T Function(T oldItem)>> replacements) =>
      _offlinePlaylistUnavailable('Update playlist tracks');
  List<T>? computeCustomOrder(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Playlist order');
  Future<int> importPlaylistsIfNewer(Iterable<GeneralPlaylist<T, S>> playlists) => _offlinePlaylistUnavailable('Import playlists');
  Future<void> importPlaylistForce(GeneralPlaylist<T, S> playlist, {bool sortPlaylists = true, bool tracksFromNewSource = false}) => _offlinePlaylistUnavailable('Import playlist');
  GeneralPlaylist<T, S> ensureNewSourceItemsSorted(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Playlist order');
  Future<void> reAddPlaylist(GeneralPlaylist<T, S> playlist, int modifiedDate, {Uint8List? artworkBytes}) => _offlinePlaylistUnavailable('Restore playlist');
  Future<void> updatePlaylistMetadata(String playlist, {bool? isPinned, String? comment, List<String>? tags, List<String>? moods, int? modifiedDate, bool? isFav}) =>
      _offlinePlaylistUnavailable('Playlist metadata');
  Future<void> mergeMetadataFrom(String directoryPath) => _offlinePlaylistUnavailable('Playlist metadata');
  void renameTag(String oldPath, String newPath) => _offlinePlaylistUnavailable('Playlist tags');
  void removeTag(String path) => _offlinePlaylistUnavailable('Playlist tags');
  Map<String, int> computeTagsCounts() => _offlinePlaylistUnavailable('Playlist tag counts');
  Map<String, int> computeMoodsCounts() => _offlinePlaylistUnavailable('Playlist mood counts');
  Future<void> insertTracksInPlaylist(GeneralPlaylist<T, S> playlist, List<T> tracks, int index) => _offlinePlaylistUnavailable('Insert playlist tracks');
  Future<void> insertTracksInPlaylistWithEachIndex(GeneralPlaylist<T, S> playlist, Map<T, int> tracksWithIndices) => _offlinePlaylistUnavailable('Insert playlist tracks');
  void ensureCustomOrderValid({bool removeNonExistent = false}) => _offlinePlaylistUnavailable('PlaylistManager.ensureCustomOrderValid');
  Rx<List<String>?> getCustomIndicesOrderListRx() => _offlinePlaylistUnavailable('PlaylistManager.getCustomIndicesOrderListRx');
  void onPlaylistReorder(int oldIndex, int newIndex) => _offlinePlaylistUnavailable('Playlist order');

  Future<GeneralPlaylist<T, S>?> addNewPlaylistRaw(
    String name, {
    Iterable<I>? tracks,
    Iterable<T>? tracksRaw,
    T Function(I item, int dateAdded, PlaylistID? playlistID)? convertItem,
    bool tracksFromNewSource = false,
    int? creationDate,
    int? modifiedDate,
    String comment = '',
    List<String> moods = const [],
    List<String> tags = const [],
    bool isPinned = false,
    String? m3uPath,
    FutureOr<PlaylistAddDuplicateAction?> Function()? actionIfAlreadyExists,
  }) => _offlinePlaylistUnavailable('Create playlist');

  Future<int?> addTracksToPlaylistRaw(
    GeneralPlaylist<T, S> playlist,
    Iterable<I> tracks,
    FutureOr<PlaylistAddDuplicateAction?> Function()? duplicateAction,
    T Function(I item, int dateAdded) convertItem,
  ) => _offlinePlaylistUnavailable('Add tracks to playlist');
  bool toggleTrackFavourite(T item) => _offlinePlaylistUnavailable('Favourites playlist');
  Future<bool> setArtworkForPlaylist(String name, {required File? artworkFile, required Uint8List? artworkBytes}) => _offlinePlaylistUnavailable('Playlist artwork');
  Future<bool> renamePlaylist(String playlistName, String newName) => _offlinePlaylistUnavailable('Rename playlist');
  Future<void> prepareAllPlaylistsFile() => _offlinePlaylistUnavailable('PlaylistManager.prepareAllPlaylistsFile');
  Future<void> removePlaylists(List<String> names) => _offlinePlaylistUnavailable('Remove playlists');
  Future<void> updatePlaylistsMetadata(Map<String, PlaylistMetadataEdit> edits) => _offlinePlaylistUnavailable('Playlist metadata');
  Future<bool> writePlaylistToStorage(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Playlist storage');
  Future<void> removePlaylist(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Remove playlist');
  Future<void> prepareDefaultPlaylistsFileAsync() => _offlinePlaylistUnavailable('Playlist storage');
}

extension PinnedPlaylistEntries<T, S> on List<MapEntry<String, GeneralPlaylist<T, S>>> {
  void movePinnedFirst() => _offlinePlaylistUnavailable('PinnedPlaylistEntries.movePinnedFirst');
}

class PlaylistTagsFilter {
  static const String separator = '/';
  Rx<int> get revision => _offlinePlaylistUnavailable('PlaylistTagsFilter.revision');
  PlaylistTagsSelection get selection => _offlinePlaylistUnavailable('PlaylistTagsFilter.selection');
  set selection(PlaylistTagsSelection value) => _offlinePlaylistUnavailable('PlaylistTagsFilter.selection');
  List<String> get allPaths => _offlinePlaylistUnavailable('PlaylistTagsFilter.allPaths');
  Set<int> get usedColors => _offlinePlaylistUnavailable('PlaylistTagsFilter.usedColors');
  static List<String> normalizeTags(Iterable<String> tags) => _offlinePlaylistUnavailable('PlaylistTagsFilter.normalizeTags');
  static List<String> expandTags(Iterable<String> tags) => _offlinePlaylistUnavailable('PlaylistTagsFilter.expandTags');

  PlaylistTagsFilter() {
    _offlinePlaylistUnavailable('PlaylistTagsFilter');
  }
  List<PlaylistTagsSelection> get savedSelections => _offlinePlaylistUnavailable('PlaylistTagsFilter.savedSelections');
  bool get isActive => _offlinePlaylistUnavailable('PlaylistTagsFilter.isActive');
  List<int> colorsOf(Iterable<String> tags) => _offlinePlaylistUnavailable('PlaylistTagsFilter.colorsOf');
  int? colorOf(String path) => _offlinePlaylistUnavailable('PlaylistTagsFilter.colorOf');
  int playlistsCountOf(String path) => _offlinePlaylistUnavailable('PlaylistTagsFilter.playlistsCountOf');
  List<PlaylistTagChip> computeChips() => _offlinePlaylistUnavailable('PlaylistTagsFilter.computeChips');
  List<PlaylistTagSection> groupByTopLevelTag(List<String> names) => _offlinePlaylistUnavailable('PlaylistTagsFilter.groupByTopLevelTag');
  List<PlaylistTagInfo> listTopLevelTags() => _offlinePlaylistUnavailable('PlaylistTagsFilter.listTopLevelTags');
  List<String> apply(List<String> playlists) => _offlinePlaylistUnavailable('PlaylistTagsFilter.apply');
  void setColor(String path, int? color) => _offlinePlaylistUnavailable('PlaylistTagsFilter.setColor');
  void reorderTopLevelTag(int oldIndex, int newIndex) => _offlinePlaylistUnavailable('PlaylistTagsFilter.reorderTopLevelTag');
  void saveCurrentSelection() => _offlinePlaylistUnavailable('PlaylistTagsFilter.saveCurrentSelection');
  void applySelection(PlaylistTagsSelection saved) => _offlinePlaylistUnavailable('PlaylistTagsFilter.applySelection');
  void removeSavedSelection(PlaylistTagsSelection saved) => _offlinePlaylistUnavailable('PlaylistTagsFilter.removeSavedSelection');
  void toggleIncluded(PlaylistTagKey key) => _offlinePlaylistUnavailable('PlaylistTagsFilter.toggleIncluded');
  void toggleExcluded(PlaylistTagKey key) => _offlinePlaylistUnavailable('PlaylistTagsFilter.toggleExcluded');
  void clear() => _offlinePlaylistUnavailable('PlaylistTagsFilter.clear');
}
