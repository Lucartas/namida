class PlaylistID {
  final String id;
  final String? playlistId;
  const PlaylistID({required this.id, this.playlistId});

  factory PlaylistID.fromJson(Map<String, dynamic> json) => PlaylistID(
    id: json['id']?.toString() ?? '',
    playlistId: json['playlistId']?.toString(),
  );

  Map<String, dynamic> toJson() => _unavailable('PlaylistID.toJson');
}

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');
