class PlaylistID {
  final String id;
  final String? playlistId;
  const PlaylistID({required this.id, this.playlistId});

  factory PlaylistID.fromJson(Map<String, dynamic> json) => PlaylistID(
    id: json['id']?.toString() ?? '',
    playlistId: json['playlistId']?.toString(),
  );

  Map<String, dynamic> toJson() => {'id': id, if (playlistId != null) 'playlistId': playlistId};

  @override
  bool operator ==(Object other) => other is PlaylistID && other.id == id && other.playlistId == playlistId;

  @override
  int get hashCode => Object.hash(id, playlistId);

  @override
  String toString() => playlistId == null ? id : '$id:$playlistId';
}
