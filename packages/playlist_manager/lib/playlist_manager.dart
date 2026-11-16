import 'dart:async';
import 'dart:convert';
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

  bool get isReadOnly => remoteSource != null && remoteSource != PlaylistRemoteSource.none;

  PlaylistID? get playlistID {
    for (final track in tracks) {
      try {
        final id = (track as dynamic).playlistID;
        if (id is PlaylistID) return id;
      } on NoSuchMethodError {
        // Most playlist item types do not carry a source playlist ID.
      }
    }
    return null;
  }

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
  }) => GeneralPlaylist<T, S>(
    name: name ?? this.name,
    tracks: tracks ?? this.tracks,
    creationDate: creationDate ?? this.creationDate,
    modifiedDate: modifiedDate ?? this.modifiedDate,
    comment: comment ?? this.comment,
    moods: moods ?? this.moods,
    tags: tags ?? this.tags,
    isPinned: isPinned ?? this.isPinned,
    isFav: isFav ?? this.isFav,
    remoteSource: remoteSource ?? this.remoteSource,
    m3uPath: m3uPath ?? this.m3uPath,
    sortsType: sortsType ?? this.sortsType,
    sortReverse: sortReverse ?? this.sortReverse,
    customOrder: customOrder ?? this.customOrder,
  );

  GeneralPlaylist<E, S> copyWithConvertedTracks<E>(E Function(T track) convert) => GeneralPlaylist<E, S>(
    name: name,
    tracks: tracks.map(convert).toList(),
    creationDate: creationDate,
    modifiedDate: modifiedDate,
    comment: comment,
    moods: moods,
    tags: tags,
    isPinned: isPinned,
    isFav: isFav,
    remoteSource: remoteSource,
    m3uPath: m3uPath,
    sortsType: sortsType,
    sortReverse: sortReverse,
    customOrder: customOrder?.map(convert).toList(),
  );

  factory GeneralPlaylist.fromJson(
    Map<String, dynamic> value, [
    T Function(Map<String, dynamic>)? itemFromJson,
    List<S> Function(Object?)? sortFromJson,
  ]) {
    final remoteSourceJson = value['remoteSource'];
    final remoteSource = remoteSourceJson is Map
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
  }) => {
    'name': name,
    if (includeTracks) 'tracks': tracks.map((item) => itemToJson?.call(item) ?? item).toList(),
    'creationDate': creationDate,
    'modifiedDate': modifiedDate,
    'comment': comment,
    'moods': moods,
    'tags': tags,
    'isPinned': isPinned,
    'isFav': isFav,
    if (remoteSource != null) 'remoteSource': {'sourceKey': remoteSource!.sourceKey, 'remoteId': remoteSource!.remoteId},
    if (m3uPath != null) 'm3uPath': m3uPath,
    if (sortsType != null) 'sortsType': sortToJson?.call(sortsType!),
    'sortReverse': sortReverse,
    if (customOrder != null) 'customOrder': customOrder!.map((item) => itemToJson?.call(item) ?? item).toList(),
  };

  String toTagsAndMoodsText() => [...tags, ...moods].join(', ');
}

List<String> _stringList(Object? value) => value is List ? value.whereType<String>().toList() : <String>[];

class PlaylistManager<T, I, S> {
  PlaylistManager() {
    playlistsMap = RxMap<String, GeneralPlaylist<T, S>>(<String, GeneralPlaylist<T, S>>{});
    favouritesPlaylist = FavouritePlaylist<T, I, S>(PLAYLIST_NAME_FAV);
    tagsFilter = PlaylistTagsFilter(() => playlistsMap.value.values);
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
  Future<void>? _defaultPlaylistsFuture;

  int get currentTimeMS => DateTime.now().millisecondsSinceEpoch;
  Future<void> get waitForPlaylistsLoad => _playlistsLoadFuture ?? Future<void>.value();
  Future<void> get waitForFavouritePlaylistLoad => _favouritesLoadFuture ?? Future<void>.value();

  String get PLAYLIST_NAME_FAV => '_FAVOURITES_';
  String get PLAYLIST_NAME_HISTORY => '_HISTORY_';
  String get PLAYLIST_NAME_MOST_PLAYED => '_MOST_PLAYED_';

  String get playlistsDirectory => '';
  String get playlistsArtworksDirectory => '';
  String get playlistsMetadataDirectory => '';
  String get favouritePlaylistPath => '';
  bool get sortAfterPreparing => false;
  bool get addTracksAtBeginning => false;

  Future<Map<String, GeneralPlaylist<T, S>>> prepareAllPlaylistsFunction() async => <String, GeneralPlaylist<T, S>>{};
  Future<GeneralPlaylist<T, S>?> prepareFavouritePlaylistFunction() async => null;
  FutureOr<void> onPlaylistTracksChanged(GeneralPlaylist<T, S> playlist) {}
  FutureOr<bool> canRemovePlaylist(GeneralPlaylist<T, S> playlist) => true;
  void onPlaylistRemovedFromMap(List<String> names) {}
  void onFavouritesChanged(Iterable<I>? items) {}
  void onTagsFilterChanged() {}
  void onPlaylistItemsSort(List<S> sorts, bool reverse, List<T> items) {}
  void sortPlaylists() {}
  Map<String, dynamic> itemToJson(T item) => <String, dynamic>{'item': item};
  dynamic sortToJson(List<S> items) => items;

  RegExp get cleanupFilenameRegex => RegExp(r'[\\/:*?"<>|]');
  I identifyBy(T item) => item as I;
  int? getMetadataEditDate(GeneralPlaylist<T, S> playlist) => currentTimeMS;
  GeneralPlaylist<T, S>? getPlaylist(String name) => playlistsMap.value[name];
  File getArtworkFileForPlaylist(String name) => File(_joinPath(playlistsArtworksDirectory, '${_cleanFilename(name)}.png'));
  bool isOneOfDefaultPlaylists(String name) => name == PLAYLIST_NAME_FAV || name == PLAYLIST_NAME_HISTORY || name == PLAYLIST_NAME_MOST_PLAYED;
  String? validatePlaylistName(String? name) {
    if (name == null || name.trim().isEmpty) return 'empty';
    if (cleanupFilenameRegex.hasMatch(name)) return 'invalid';
    if (isOneOfDefaultPlaylists(name)) return 'reserved';
    if (playlistsMap.value.containsKey(name)) return 'exists';
    return null;
  }

  void resetCanReorder() => canReorderItems.value = false;
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
  Future<void> prepareAllPlaylistsFile() => _playlistsLoadFuture ??= _prepareAllPlaylistsFile();
  Future<void> removePlaylists(List<String> names) => _offlinePlaylistUnavailable('Remove playlists');
  Future<void> updatePlaylistsMetadata(Map<String, PlaylistMetadataEdit> edits) => _offlinePlaylistUnavailable('Playlist metadata');
  Future<bool> writePlaylistToStorage(GeneralPlaylist<T, S> playlist) async {
    final file = File(_playlistFilePath(playlist.name));
    await file.parent.create(recursive: true);
    await file.writeAsString(jsonEncode(playlist.toJson(itemToJson, sortToJson)));
    return true;
  }

  Future<void> removePlaylist(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Remove playlist');
  Future<void> prepareDefaultPlaylistsFileAsync() => _defaultPlaylistsFuture ??= _prepareDefaultPlaylistsFileAsync();

  Future<void> _prepareDefaultPlaylistsFileAsync() async {
    await Future.wait([
      prepareAllPlaylistsFile(),
      _favouritesLoadFuture ??= _prepareFavouritePlaylist(),
    ]);
  }

  Future<void> _prepareAllPlaylistsFile() async {
    final prepared = await prepareAllPlaylistsFunction();
    final playlists = <String, GeneralPlaylist<T, S>>{};
    for (final entry in prepared.entries) {
      if (entry.key.isEmpty || isOneOfDefaultPlaylists(entry.key)) continue;
      final playlist = entry.value;
      if (sortAfterPreparing && playlist.sortsType?.isNotEmpty == true) {
        onPlaylistItemsSort(playlist.sortsType!, playlist.sortReverse, playlist.tracks);
      }
      playlists[entry.key] = playlist;
    }
    playlistsMap.value = playlists;
  }

  Future<void> _prepareFavouritePlaylist() async {
    final loaded = await prepareFavouritePlaylistFunction();
    if (loaded != null) {
      loaded.isFav = true;
      favouritesPlaylist.value = loaded;
      if (loaded.tracks.isNotEmpty) onFavouritesChanged(loaded.tracks.map(identifyBy));
      return;
    }
    favouritesPlaylist.value = GeneralPlaylist<T, S>(name: PLAYLIST_NAME_FAV, tracks: <T>[], isFav: true);
  }

  String _playlistFilePath(String name) => _joinPath(playlistsDirectory, '${_cleanFilename(name)}.json');
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

  PlaylistTagsFilter([Iterable<dynamic> Function()? playlists]) : _playlists = playlists;

  final Iterable<dynamic> Function()? _playlists;
  final Rx<int> _revision = Rx<int>(0);
  PlaylistTagsSelection _selection = const PlaylistTagsSelection();
  final List<PlaylistTagsSelection> _savedSelections = [];
  final Map<String, int> _colors = {};
  final List<String> _topLevelOrder = [];

  Rx<int> get revision => _revision;
  PlaylistTagsSelection get selection => _selection;
  set selection(PlaylistTagsSelection value) {
    _selection = value;
    _revision.value++;
  }

  List<String> get allPaths => expandTags((_playlists?.call() ?? const <dynamic>[]).expand((playlist) => _tagsOf(playlist)));
  Set<int> get usedColors => _colors.values.toSet();
  static List<String> normalizeTags(Iterable<String> tags) {
    final result = <String>[];
    final seen = <String>{};
    for (final tag in tags) {
      final normalized = tag.replaceAll('\\', separator).split(separator).map((part) => part.trim()).where((part) => part.isNotEmpty).join(separator);
      if (normalized.isNotEmpty && seen.add(normalized)) result.add(normalized);
    }
    return result;
  }

  static List<String> expandTags(Iterable<String> tags) {
    final result = <String>[];
    final seen = <String>{};
    for (final tag in normalizeTags(tags)) {
      final parts = tag.split(separator);
      for (var i = 1; i <= parts.length; i++) {
        final path = parts.take(i).join(separator);
        if (seen.add(path)) result.add(path);
      }
    }
    return result;
  }

  List<PlaylistTagsSelection> get savedSelections => List.unmodifiable(_savedSelections);
  bool get isActive => _selection.tag.isNotEmpty || _selection.included.isNotEmpty || _selection.excluded.isNotEmpty;
  List<int> colorsOf(Iterable<String> tags) => tags.map(colorOf).whereType<int>().toList();
  int? colorOf(String path) => _colors[path];
  int playlistsCountOf(String path) => (_playlists?.call() ?? const <dynamic>[]).where((playlist) => _matchesUserTag(playlist, path)).length;
  List<PlaylistTagChip> computeChips() => _offlinePlaylistUnavailable('PlaylistTagsFilter.computeChips');
  List<PlaylistTagSection> groupByTopLevelTag(List<String> names) => _offlinePlaylistUnavailable('PlaylistTagsFilter.groupByTopLevelTag');
  List<PlaylistTagInfo> listTopLevelTags() => _offlinePlaylistUnavailable('PlaylistTagsFilter.listTopLevelTags');
  List<String> apply(List<String> playlists) {
    if (!isActive) return List<String>.from(playlists);
    final byName = {for (final playlist in _playlists?.call() ?? const <dynamic>[]) playlist.name as String: playlist};
    return playlists.where((name) {
      final playlist = byName[name];
      if (playlist == null) return false;
      if (_selection.tag.isNotEmpty && !_matchesUserTag(playlist, _selection.tag)) return false;
      if (_selection.included.any((key) => !_matchesKey(playlist, key))) return false;
      if (_selection.excluded.any((key) => _matchesKey(playlist, key))) return false;
      return true;
    }).toList();
  }

  void setColor(String path, int? color) {
    if (color == null) {
      _colors.remove(path);
    } else {
      _colors[path] = color;
    }
    _revision.value++;
  }

  void reorderTopLevelTag(int oldIndex, int newIndex) {
    final paths = allPaths.where((path) => !path.contains(separator)).toList();
    _topLevelOrder
      ..removeWhere((path) => !paths.contains(path))
      ..addAll(paths.where((path) => !_topLevelOrder.contains(path)));
    if (oldIndex < 0 || oldIndex >= _topLevelOrder.length || newIndex < 0 || newIndex >= _topLevelOrder.length) return;
    final path = _topLevelOrder.removeAt(oldIndex);
    _topLevelOrder.insert(newIndex, path);
    _revision.value++;
  }

  void saveCurrentSelection() {
    if (_selection.tag.isEmpty && _selection.included.isEmpty && _selection.excluded.isEmpty) return;
    _savedSelections.add(_selection);
    _revision.value++;
  }

  void applySelection(PlaylistTagsSelection saved) => selection = saved;
  void removeSavedSelection(PlaylistTagsSelection saved) {
    _savedSelections.remove(saved);
    _revision.value++;
  }

  void toggleIncluded(PlaylistTagKey key) {
    final included = List<PlaylistTagKey>.from(_selection.included);
    final excluded = List<PlaylistTagKey>.from(_selection.excluded)..remove(key);
    if (!included.remove(key)) included.add(key);
    selection = PlaylistTagsSelection(tag: _selection.tag, included: included, excluded: excluded);
  }

  void toggleExcluded(PlaylistTagKey key) {
    final included = List<PlaylistTagKey>.from(_selection.included)..remove(key);
    final excluded = List<PlaylistTagKey>.from(_selection.excluded);
    if (!excluded.remove(key)) excluded.add(key);
    selection = PlaylistTagsSelection(tag: _selection.tag, included: included, excluded: excluded);
  }

  void clear() => selection = const PlaylistTagsSelection();

  bool _matchesKey(dynamic playlist, PlaylistTagKey key) {
    if (key case PlaylistUserTag(:final path)) return _matchesUserTag(playlist, path);
    if (key case PlaylistVirtualTag.pinned) return playlist.isPinned == true;
    if (key case PlaylistVirtualTag.untagged) return _tagsOf(playlist).isEmpty;
    if (key case PlaylistVirtualTag.m3u) return (playlist.m3uPath as String?)?.isNotEmpty == true;
    if (key case PlaylistVirtualTag.remote) return playlist.remoteSource != null;
    return false;
  }

  bool _matchesUserTag(dynamic playlist, String path) => _tagsOf(playlist).any((tag) => tag == path || tag.startsWith('$path$separator'));

  static List<String> _tagsOf(dynamic playlist) {
    try {
      final tags = playlist.tags;
      return tags is Iterable<String> ? tags.toList() : <String>[];
    } on NoSuchMethodError {
      return <String>[];
    }
  }
}
