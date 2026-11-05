enum PlaylistAddDuplicateAction {
  justAddEverything,
  addAllAndRemoveOldOnes,
  addOnlyMissing,
  mergeAndSortByAddedDate,
  deleteAndCreateNewPlaylist;

  static const valuesForAdd = [justAddEverything, addAllAndRemoveOldOnes, addOnlyMissing];
  static const valuesForAddExcludingAddEverything = [addAllAndRemoveOldOnes, addOnlyMissing];
}

enum PlaylistTagFilterState { none, included, excluded }

sealed class PlaylistTagKey {
  const PlaylistTagKey();
  String toVirtualText() => throw UnsupportedError('Playlist tags are unavailable in Milestone 1.');
  dynamic toIcon() => throw UnsupportedError('Playlist tags are unavailable in Milestone 1.');
}

enum PlaylistVirtualTag implements PlaylistTagKey {
  pinned,
  untagged,
  m3u,
  remote;

  @override
  String toVirtualText() => throw UnsupportedError('Playlist tags are unavailable in Milestone 1.');
  @override
  dynamic toIcon() => throw UnsupportedError('Playlist tags are unavailable in Milestone 1.');
}

final class PlaylistUserTag extends PlaylistTagKey {
  final String path;
  const PlaylistUserTag(this.path);
}

class PlaylistTagInfo {
  final String path;
  final int count;
  final int? color;
  final List<PlaylistTagInfo> nested;

  const PlaylistTagInfo({required this.path, this.count = 0, this.color, this.nested = const []});
}

class PlaylistTagChip {
  final PlaylistTagKey key;
  final PlaylistTagFilterState state;
  final int depth;
  final String? label;
  final int? color;
  final int count;

  const PlaylistTagChip({required this.key, this.state = PlaylistTagFilterState.none, this.depth = 0, this.label, this.color, this.count = 0});
}

class PlaylistTagSection {
  final PlaylistTagKey key;
  final int? color;
  final List<String> names;

  const PlaylistTagSection({required this.key, this.color, this.names = const []});
}

class PlaylistTagsSelection {
  final String tag;
  final dynamic included;
  final dynamic excluded;
  const PlaylistTagsSelection({this.tag = '', this.included = const [], this.excluded = const []});
  String toText() => _unavailable('PlaylistTagsSelection.toText');
}

class PlaylistMetadataEdit {
  final bool? isPinned;
  final String? comment;
  final List<String>? tags;
  final List<String>? moods;
  final int? modifiedDate;
  final bool? isFav;

  const PlaylistMetadataEdit({this.isPinned, this.comment, this.tags, this.moods, this.modifiedDate, this.isFav});

  PlaylistMetadataEdit copyWith({bool? isPinned, String? comment, List<String>? tags, List<String>? moods, int? modifiedDate, bool? isFav}) =>
      _unavailable('PlaylistMetadataEdit.copyWith');
}

class PlaylistRemoteSource {
  final String sourceKey;
  final String remoteId;
  const PlaylistRemoteSource._none() : sourceKey = '', remoteId = '';
  const PlaylistRemoteSource({required this.sourceKey, required this.remoteId});
  static const none = PlaylistRemoteSource._none();
}

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');
