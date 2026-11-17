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
  int? pinnedDate;
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
    this.pinnedDate,
    this.isFav = false,
    this.remoteSource,
    this.m3uPath,
    this.sortsType,
    this.sortReverse = false,
    this.customOrder,
  });

  bool get isReadOnly => remoteSource != null && remoteSource!.sourceKey.isNotEmpty;

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
    int? pinnedDate,
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
  ]) {
    final remoteSourceJson = value['remoteSource'];
    final remoteSource = remoteSourceJson is Map && (remoteSourceJson['sourceKey']?.toString() ?? '').isNotEmpty
        ? PlaylistRemoteSource(
            sourceKey: remoteSourceJson['sourceKey']?.toString() ?? '',
            remoteId: remoteSourceJson['remoteId']?.toString() ?? '',
          )
        : null;
    List<T> decodeItems(Object? source) {
      if (source is! List || itemFromJson == null) return <T>[];
      return source.map((item) => itemFromJson(Map<String, dynamic>.from(item as Map))).toList();
    }

    final sortValue = value['sortsType'];
    return GeneralPlaylist<T, S>(
      name: value['name']?.toString() ?? '',
      tracks: decodeItems(value['tracks']),
      creationDate: (value['creationDate'] as num?)?.toInt() ?? 0,
      modifiedDate: (value['modifiedDate'] as num?)?.toInt() ?? 0,
      comment: value['comment']?.toString() ?? '',
      moods: _stringList(value['moods']),
      tags: _stringList(value['tags']),
      isPinned: value['isPinned'] == true,
      isFav: value['isFav'] == true,
      remoteSource: remoteSource,
      m3uPath: value['m3uPath'] as String?,
      sortsType: sortFromJson?.call(sortValue),
      sortReverse: value['sortReverse'] == true,
      customOrder: value['customOrder'] == null ? null : decodeItems(value['customOrder']),
    );
  }

  Map<String, dynamic> toJson(
    Object? Function(T)? itemToJson,
    Object? Function(List<S>)? sortToJson, {
    bool includeTracks = true,
  }) => _offlinePlaylistUnavailable('GeneralPlaylist.toJson');

  String toTagsAndMoodsText() => _offlinePlaylistUnavailable('GeneralPlaylist.toTagsAndMoodsText');
}

List<String> _stringList(Object? value) => value is List ? value.whereType<String>().toList() : <String>[];

class PlaylistManager<T, I, S> {
  PlaylistManager() {
    playlistsMap = RxMap<String, GeneralPlaylist<T, S>>(<String, GeneralPlaylist<T, S>>{});
    favouritesPlaylist = FavouritePlaylist<T, I, S>(PLAYLIST_NAME_FAV, identifyBy: identifyBy);
    tagsFilter = PlaylistTagsFilter();
    customIndicesOrderRx = Rx<List<String>?>(null);
    canReorderItems = Rx<bool>(false);
  }

  late final RxMap<String, GeneralPlaylist<T, S>> playlistsMap;
  late final FavouritePlaylist<T, I, S> favouritesPlaylist;
  late final PlaylistTagsFilter tagsFilter;
  late final Rx<List<String>?> customIndicesOrderRx;
  late final Rx<bool> canReorderItems;

  Future<void>? _playlistsLoadFuture;
  Future<void>? _favouritesLoadFuture;
  bool _loadingPlaylists = false;
  bool _loadingFavourites = false;

  int get currentTimeMS => DateTime.now().millisecondsSinceEpoch;
  Future<void> get waitForPlaylistsLoad => _playlistsLoadFuture ?? prepareAllPlaylistsFile();
  Future<void> get waitForFavouritePlaylistLoad => _favouritesLoadFuture ?? _loadFavouritePlaylist();

  String get PLAYLIST_NAME_FAV => '_FAVOURITES_';
  String get PLAYLIST_NAME_HISTORY => '_HISTORY_';
  String get PLAYLIST_NAME_MOST_PLAYED => '_MOST_PLAYED_';

  String get playlistsArtworksDirectory => '';
  bool get sortAfterPreparing => false;

  Future<Map<String, GeneralPlaylist<T, S>>> prepareAllPlaylistsFunction() async => <String, GeneralPlaylist<T, S>>{};
  Future<GeneralPlaylist<T, S>?> prepareFavouritePlaylistFunction() async => null;
  void onFavouritesChanged(Iterable<I>? items) {}
  FutureOr<void> onPlaylistItemsSort(List<S> sorts, bool reverse, List<T> items) {}

  RegExp get cleanupFilenameRegex => _offlinePlaylistUnavailable('PlaylistManager.cleanupFilenameRegex');
  I identifyBy(T item) => _offlinePlaylistUnavailable('Playlist item lookup');
  int? getMetadataEditDate(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Playlist metadata');
  GeneralPlaylist<T, S>? getPlaylist(String name) => playlistsMap.value[name];
  File getArtworkFileForPlaylist(String name) => File(_joinPath(playlistsArtworksDirectory, '${_cleanFilename(name)}.png'));
  bool isOneOfDefaultPlaylists(String name) => name == PLAYLIST_NAME_FAV || name == PLAYLIST_NAME_HISTORY || name == PLAYLIST_NAME_MOST_PLAYED;
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
  Future<void> replaceTheseTracksInFavourites(bool Function(T item) test, T Function(T oldItem) replace) => _offlinePlaylistUnavailable('Update favourite tracks');
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
  Future<bool> renamePlaylistInStorage(GeneralPlaylist<T, S> playlist, String newName) => _offlinePlaylistUnavailable('Rename playlist storage');
  Future<void> prepareAllPlaylistsFile() {
    // Share an active read, but allow explicit reloads after success or failure.
    if (_loadingPlaylists) return _playlistsLoadFuture!;
    _loadingPlaylists = true;
    return _playlistsLoadFuture = _prepareAllPlaylistsFile().whenComplete(() => _loadingPlaylists = false);
  }

  Future<void> removePlaylists(List<String> names, {bool deleteFiles = true}) => _offlinePlaylistUnavailable('Remove playlists');
  Future<void> updatePlaylistsMetadata(Map<String, PlaylistMetadataEdit> edits) => _offlinePlaylistUnavailable('Playlist metadata');
  Future<bool> writePlaylistToStorage(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Playlist storage');
  Future<void> removePlaylist(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Remove playlist');
  Future<void> prepareDefaultPlaylistsFileAsync() async {
    await Future.wait([
      prepareAllPlaylistsFile(),
      _loadFavouritePlaylist(),
    ]);
  }

  Future<void> _prepareAllPlaylistsFile() async {
    final prepared = await prepareAllPlaylistsFunction();
    final playlists = <String, GeneralPlaylist<T, S>>{};
    for (final entry in prepared.entries) {
      if (entry.key.isEmpty || isOneOfDefaultPlaylists(entry.key)) continue;
      final playlist = entry.value;
      if (sortAfterPreparing && playlist.sortsType?.isNotEmpty == true) {
        await onPlaylistItemsSort(playlist.sortsType!, playlist.sortReverse, playlist.tracks);
      }
      playlists[entry.key] = playlist;
    }
    playlistsMap.value = playlists;
  }

  Future<void> _loadFavouritePlaylist() {
    if (_loadingFavourites) return _favouritesLoadFuture!;
    _loadingFavourites = true;
    return _favouritesLoadFuture = _prepareFavouritePlaylist().whenComplete(() => _loadingFavourites = false);
  }

  Future<void> _prepareFavouritePlaylist() async {
    final loaded = await prepareFavouritePlaylistFunction();
    if (loaded != null) {
      loaded.isFav = true;
      favouritesPlaylist.value = loaded;
      // Reloading can remove favorites too, so refresh all favorite-based sorting.
      onFavouritesChanged(null);
      return;
    }
    favouritesPlaylist.value = GeneralPlaylist<T, S>(name: PLAYLIST_NAME_FAV, tracks: <T>[], isFav: true);
    onFavouritesChanged(null);
  }
}

extension PinnedPlaylistEntries<T, S> on List<MapEntry<String, GeneralPlaylist<T, S>>> {
  void movePinnedFirst() {
    final pinned = where((entry) => entry.value.isPinned).toList();
    final unpinned = where((entry) => !entry.value.isPinned).toList();
    final reordered = [...pinned, ...unpinned];
    for (var index = 0; index < reordered.length; index++) {
      this[index] = reordered[index];
    }
  }
}

String _cleanFilename(String name) => name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_').trim();

String _joinPath(String directory, String filename) {
  if (directory.isEmpty) return filename;
  if (directory.endsWith(Platform.pathSeparator)) return '$directory$filename';
  return '$directory${Platform.pathSeparator}$filename';
}

class PlaylistTagsFilter {
  static const String separator = '/';
  final Rx<int> revision = Rx<int>(0);
  PlaylistTagsSelection get selection => _offlinePlaylistUnavailable('PlaylistTagsFilter.selection');
  set selection(PlaylistTagsSelection value) => _offlinePlaylistUnavailable('PlaylistTagsFilter.selection');
  List<String> get allPaths => _offlinePlaylistUnavailable('PlaylistTagsFilter.allPaths');
  Set<int> get usedColors => _offlinePlaylistUnavailable('PlaylistTagsFilter.usedColors');
  static List<String> normalizeTags(Iterable<String> tags) => _offlinePlaylistUnavailable('PlaylistTagsFilter.normalizeTags');
  static List<String> expandTags(Iterable<String> tags) => _offlinePlaylistUnavailable('PlaylistTagsFilter.expandTags');

  PlaylistTagsFilter();
  List<PlaylistTagsSelection> get savedSelections => _offlinePlaylistUnavailable('PlaylistTagsFilter.savedSelections');
  bool get isActive => _offlinePlaylistUnavailable('PlaylistTagsFilter.isActive');
  List<int> colorsOf(Iterable<String> tags) => _offlinePlaylistUnavailable('PlaylistTagsFilter.colorsOf');
  int? colorOf(String path) => _offlinePlaylistUnavailable('PlaylistTagsFilter.colorOf');
  int playlistsCountOf(String path) => _offlinePlaylistUnavailable('PlaylistTagsFilter.playlistsCountOf');
  List<PlaylistTagChip> computeChips() => _offlinePlaylistUnavailable('PlaylistTagsFilter.computeChips');
  List<PlaylistTagSection> groupByTopLevelTag(List<String> names) => _offlinePlaylistUnavailable('PlaylistTagsFilter.groupByTopLevelTag');
  List<PlaylistTagInfo> listTopLevelTags() => _offlinePlaylistUnavailable('PlaylistTagsFilter.listTopLevelTags');
  // Filter editing is unsupported; startup displays the unfiltered collection.
  List<String> apply(List<String> playlists) => List<String>.from(playlists);
  void setColor(String path, int? color) => _offlinePlaylistUnavailable('PlaylistTagsFilter.setColor');
  void reorderTopLevelTag(int oldIndex, int newIndex) => _offlinePlaylistUnavailable('PlaylistTagsFilter.reorderTopLevelTag');
  void saveCurrentSelection() => _offlinePlaylistUnavailable('PlaylistTagsFilter.saveCurrentSelection');
  void applySelection(PlaylistTagsSelection saved) => _offlinePlaylistUnavailable('PlaylistTagsFilter.applySelection');
  void removeSavedSelection(PlaylistTagsSelection saved) => _offlinePlaylistUnavailable('PlaylistTagsFilter.removeSavedSelection');
  void toggleIncluded(PlaylistTagKey key) => _offlinePlaylistUnavailable('PlaylistTagsFilter.toggleIncluded');
  void toggleExcluded(PlaylistTagKey key) => _offlinePlaylistUnavailable('PlaylistTagsFilter.toggleExcluded');
  void clear() => _offlinePlaylistUnavailable('PlaylistTagsFilter.clear');
}
