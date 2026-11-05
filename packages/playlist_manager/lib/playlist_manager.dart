import 'dart:io';
import 'dart:typed_data';

import 'package:nampack/reactive/class/rx.dart';
import 'package:nampack/reactive/types/rxmap/rx_map.dart';

import 'class/favourite_playlist.dart';
import 'core/enum.dart';

export 'class/favourite_playlist.dart';
export 'core/enum.dart';
export 'module/playlist_id.dart';

Never _offlinePlaylistUnavailable(String operation) => throw UnsupportedError(
  '$operation is unavailable in this build.',
);

mixin PlaylistItemWithDate {
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

  bool get isReadOnly => _offlinePlaylistUnavailable('GeneralPlaylist.isReadOnly');
  dynamic get playlistID => _offlinePlaylistUnavailable('GeneralPlaylist.playlistID');

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
  }) => _offlinePlaylistUnavailable('GeneralPlaylist.copyWith');

  GeneralPlaylist<E, S> copyWithConvertedTracks<E>(E Function(T track) convert) => _offlinePlaylistUnavailable('GeneralPlaylist.copyWithConvertedTracks');

  factory GeneralPlaylist.fromJson(
    dynamic value, [
    T Function(Map<String, dynamic>)? itemFromJson,
    List<S> Function(dynamic)? sortFromJson,
  ]) => _offlinePlaylistUnavailable('GeneralPlaylist.fromJson');

  Map<String, dynamic> toJson(
    dynamic Function(T)? itemToJson,
    dynamic Function(List<S>)? sortToJson, {
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
  dynamic getMetadataEditDate(GeneralPlaylist<T, S> playlist) => _offlinePlaylistUnavailable('Playlist metadata');
  GeneralPlaylist<T, S>? getPlaylist(String name) => _offlinePlaylistUnavailable('PlaylistManager.getPlaylist');
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
  void ensureCustomOrderValid({bool removeNonExistent = false}) => _offlinePlaylistUnavailable('PlaylistManager.ensureCustomOrderValid');
  Rx<List<String>?> getCustomIndicesOrderListRx() => _offlinePlaylistUnavailable('PlaylistManager.getCustomIndicesOrderListRx');
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
