import 'dart:io';
import 'dart:typed_data';

import 'package:nampack/reactive/class/rx.dart';
import 'package:nampack/reactive/class/rxn.dart';
import 'package:nampack/reactive/types/rxmap/rx_map.dart';

import 'class/favourite_playlist.dart';
import 'core/enum.dart';

export 'class/favourite_playlist.dart';
export 'core/enum.dart';
export 'module/playlist_id.dart';

Never _offlinePlaylistUnavailable(String operation) => throw UnsupportedError(
  '$operation is unavailable in Milestone 1; persistent playlists are implemented in Milestone 2.',
);

mixin PlaylistItemWithDate {
  dynamic get item => this;
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
  dynamic remoteSource;
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

  bool get isReadOnly => remoteSource != null;
  dynamic get playlistID => remoteSource?.remoteId;

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
    dynamic remoteSource,
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

  factory GeneralPlaylist.fromJson(dynamic value, [T Function(Map<String, dynamic>)? itemFromJson, List<S> Function(dynamic)? sortFromJson]) {
    final json = value is Map<String, dynamic> ? value : const <String, dynamic>{};
    return GeneralPlaylist<T, S>(
      name: json['name'] as String? ?? '',
      tracks: (json['tracks'] as List<dynamic>? ?? const []).map((e) => itemFromJson == null ? e as T : itemFromJson((e as Map).cast<String, dynamic>())).toList(),
      creationDate: json['creationDate'] as int? ?? 0,
      modifiedDate: json['modifiedDate'] as int? ?? 0,
      comment: json['comment'] as String? ?? '',
      moods: (json['moods'] as List<dynamic>? ?? const []).cast<String>(),
      tags: (json['tags'] as List<dynamic>? ?? const []).cast<String>(),
      isPinned: json['isPinned'] as bool? ?? false,
      isFav: json['isFav'] as bool? ?? false,
      m3uPath: json['m3uPath'] as String?,
      sortsType: sortFromJson == null || json['sortsType'] == null ? null : sortFromJson(json['sortsType']),
      customOrder: (json['customOrder'] as List<dynamic>?)?.map((e) => itemFromJson == null ? e as T : itemFromJson((e as Map).cast<String, dynamic>())).toList(),
    );
  }

  Map<String, dynamic> toJson(dynamic Function(T)? itemToJson, dynamic Function(List<S>)? sortToJson, {bool includeTracks = true}) => {
    'name': name,
    if (includeTracks) 'tracks': tracks.map((e) => itemToJson?.call(e) ?? e).toList(),
    'creationDate': creationDate,
    'modifiedDate': modifiedDate,
    'comment': comment,
    'moods': moods,
    'tags': tags,
    'isPinned': isPinned,
    'isFav': isFav,
    'm3uPath': m3uPath,
    'sortsType': sortToJson?.call(sortsType ?? const []),
    'customOrder': customOrder?.map((e) => itemToJson?.call(e) ?? e).toList(),
  };

  String toTagsAndMoodsText() => [...tags, ...moods].join(' • ');

  dynamic noSuchMethod(Invocation invocation) => _offlinePlaylistUnavailable(
    'Playlist model (${invocation.memberName})',
  );
}

class PlaylistManager<T, I, S> {
  PlaylistManager()
    : playlistsMap = RxMap<String, GeneralPlaylist<T, S>>({}),
      favouritesPlaylist = FavouritePlaylist<T, I, S>('Favourites'),
      tagsFilter = PlaylistTagsFilter(),
      customIndicesOrderRx = Rxn<List<String>>(),
      canReorderItems = Rx(false);

  final RxMap<String, GeneralPlaylist<T, S>> playlistsMap;
  final FavouritePlaylist<T, I, S> favouritesPlaylist;
  final PlaylistTagsFilter tagsFilter;
  final Rx<List<String>?> customIndicesOrderRx;
  final Rx<bool> canReorderItems;
  int get currentTimeMS => DateTime.now().millisecondsSinceEpoch;
  Future<void> get waitForPlaylistsLoad async {}
  Future<void> get waitForFavouritePlaylistLoad async {}

  RegExp get cleanupFilenameRegex => RegExp(r'[^a-zA-Z0-9 _.-]');
  I identifyBy(T item) => _offlinePlaylistUnavailable('Playlist item lookup');
  dynamic getMetadataEditDate(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Playlist metadata');
  GeneralPlaylist<T, S>? getPlaylist(String name) => playlistsMap.value[name];
  File getArtworkFileForPlaylist(String name) => _offlinePlaylistUnavailable('Playlist artwork');
  bool isOneOfDefaultPlaylists(String name) => _offlinePlaylistUnavailable('Default playlist lookup');
  String? validatePlaylistName(String? name) => _offlinePlaylistUnavailable('Playlist name validation');
  dynamic resetCanReorder() => _offlinePlaylistUnavailable('Playlist reordering');
  dynamic updatePropertyInPlaylist(
    String playlist, {
    dynamic tracks,
    dynamic tracksRaw,
    dynamic convertItem,
    dynamic tracksFromNewSource,
    dynamic modifiedDate,
    dynamic creationDate,
    dynamic itemsSortReverse,
    dynamic itemsSortType,
    dynamic restoreCustomOrder,
    dynamic comment,
    dynamic tags,
    dynamic moods,
    dynamic isPinned,
    dynamic isFav,
    dynamic m3uPath,
    dynamic remoteSource,
    dynamic sortsType,
    dynamic sortReverse,
  }) => _offlinePlaylistUnavailable('Playlist metadata');
  dynamic importTracksToPlaylist(dynamic playlist, dynamic tracks, {dynamic index, dynamic source}) => _offlinePlaylistUnavailable('Import tracks to playlist');
  dynamic removeTracksFromPlaylist(dynamic playlist, dynamic indices) => _offlinePlaylistUnavailable('Remove tracks from playlist');
  dynamic reorderTrack(dynamic playlist, int oldIndex, int newIndex) => _offlinePlaylistUnavailable('Reorder playlist tracks');
  dynamic replaceTheseTracksInPlaylists(dynamic replace, dynamic after) => _offlinePlaylistUnavailable('Update playlist tracks');
  dynamic replaceTheseTracksInPlaylistsBulk(dynamic replacements) => _offlinePlaylistUnavailable('Update playlist tracks');
  dynamic computeCustomOrder(dynamic playlist) => _offlinePlaylistUnavailable('Playlist order');
  dynamic importPlaylistsIfNewer(dynamic playlists) => _offlinePlaylistUnavailable('Import playlists');
  dynamic importPlaylistForce(dynamic playlist, {bool sortPlaylists = true, bool tracksFromNewSource = false}) => _offlinePlaylistUnavailable('Import playlist');
  dynamic ensureNewSourceItemsSorted(dynamic playlist) => _offlinePlaylistUnavailable('Playlist order');
  dynamic reAddPlaylist(dynamic playlist, dynamic modifiedDate, {dynamic artworkBytes}) => _offlinePlaylistUnavailable('Restore playlist');
  dynamic updatePlaylistMetadata(String playlist, {bool? isPinned, String? comment, List<String>? tags, List<String>? moods, int? modifiedDate, bool? isFav}) =>
      _offlinePlaylistUnavailable('Playlist metadata');
  dynamic mergeMetadataFrom(String directoryPath) => _offlinePlaylistUnavailable('Playlist metadata');
  dynamic renameTag(String oldPath, String newPath) => _offlinePlaylistUnavailable('Playlist tags');
  dynamic removeTag(String path) => _offlinePlaylistUnavailable('Playlist tags');
  Map<String, int> computeTagsCounts() => _offlinePlaylistUnavailable('Playlist tag counts');
  Map<String, int> computeMoodsCounts() => _offlinePlaylistUnavailable('Playlist mood counts');
  dynamic insertTracksInPlaylist(dynamic playlist, dynamic tracks, dynamic index) => _offlinePlaylistUnavailable('Insert playlist tracks');
  dynamic insertTracksInPlaylistWithEachIndex(dynamic playlist, dynamic tracks) => _offlinePlaylistUnavailable('Insert playlist tracks');
  void ensureCustomOrderValid({bool removeNonExistent = false}) {}
  Rx<List<String>?> getCustomIndicesOrderListRx() => customIndicesOrderRx;
  dynamic onPlaylistReorder(int oldIndex, int newIndex) => _offlinePlaylistUnavailable('Playlist order');

  dynamic addNewPlaylistRaw(
    String name, {
    dynamic tracks,
    dynamic tracksRaw,
    dynamic convertItem,
    dynamic tracksFromNewSource,
    int? creationDate,
    int? modifiedDate,
    String comment = '',
    List<String> moods = const [],
    List<String> tags = const [],
    bool isPinned = false,
    String? m3uPath,
    dynamic actionIfAlreadyExists,
  }) => _offlinePlaylistUnavailable('Create playlist');

  dynamic addTracksToPlaylistRaw(dynamic playlist, dynamic tracks, dynamic duplicateAction, dynamic convertItem) => _offlinePlaylistUnavailable('Add tracks to playlist');
  dynamic toggleTrackFavourite(dynamic item) => _offlinePlaylistUnavailable('Favourites playlist');
  Future<bool> setArtworkForPlaylist(String name, {required File? artworkFile, required Uint8List? artworkBytes}) async => _offlinePlaylistUnavailable('Playlist artwork');
  Future<bool> renamePlaylist(String playlistName, String newName) async => _offlinePlaylistUnavailable('Rename playlist');
  Future<void> prepareAllPlaylistsFile() async {}
  Future<void> removePlaylists(List<String> names) async => _offlinePlaylistUnavailable('Remove playlists');
  Future<void> updatePlaylistsMetadata(Map<String, PlaylistMetadataEdit> edits) async => _offlinePlaylistUnavailable('Playlist metadata');
  Future<bool> writePlaylistToStorage(GeneralPlaylist<T, S> playlist) async => _offlinePlaylistUnavailable('Playlist storage');
  Future<void> removePlaylist(GeneralPlaylist<T, S> playlist) async => _offlinePlaylistUnavailable('Remove playlist');
  dynamic prepareDefaultPlaylistsFileAsync() => _offlinePlaylistUnavailable('Playlist storage');

  dynamic noSuchMethod(Invocation invocation) => _offlinePlaylistUnavailable(
    'Playlist manager operation (${invocation.memberName})',
  );
}

extension PinnedPlaylistEntries<T, S> on List<MapEntry<String, GeneralPlaylist<T, S>>> {
  void movePinnedFirst() {
    sort((a, b) => (b.value.isPinned ? 1 : 0) - (a.value.isPinned ? 1 : 0));
  }
}

class PlaylistTagsFilter {
  static const String separator = '/';
  final revision = Rx(0);
  PlaylistTagsSelection selection = const PlaylistTagsSelection();
  List<String> get allPaths => const [];
  Set<int> get usedColors => const {};
  static List<String> normalizeTags(Iterable<String> tags) => tags.map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  static List<String> expandTags(Iterable<String> tags) => normalizeTags(tags);

  PlaylistTagsFilter();
  List<PlaylistTagsSelection> get savedSelections => const [];
  bool get isActive => false;
  List<int> colorsOf(Iterable<String> tags) => const [];
  int? colorOf(String path) => null;
  int playlistsCountOf(String path) => 0;
  List<PlaylistTagChip> computeChips() => const [];
  List<PlaylistTagSection> groupByTopLevelTag(List<String> names) => const [];
  List<PlaylistTagInfo> listTopLevelTags() => const [];
  List<String> apply(List<String> playlists) => playlists;
  void setColor(String path, int? color) {}
  void reorderTopLevelTag(int oldIndex, int newIndex) {}
  void saveCurrentSelection() {}
  void applySelection(PlaylistTagsSelection saved) {}
  void removeSavedSelection(PlaylistTagsSelection saved) {}
  void toggleIncluded(PlaylistTagKey key) {}
  void toggleExcluded(PlaylistTagKey key) {}
  void clear() {}
  dynamic noSuchMethod(Invocation invocation) => _offlinePlaylistUnavailable('Playlist tags');
}
