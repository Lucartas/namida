class PlaylistID {
  final String id;
  final String? playlistId;
  const PlaylistID({required this.id, this.playlistId});

  factory PlaylistID.fromJson(Map<String, dynamic> json) => PlaylistID(
    id: json['id'] as String? ?? '',
    playlistId: json['playlistId'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, if (playlistId != null) 'playlistId': playlistId};
}
