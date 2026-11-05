class MusicAlbumInfoItem {
  final dynamic id;
  final dynamic title;
  final dynamic subtitle;
  final List<dynamic> thumbnails;
  final dynamic artists;
  const MusicAlbumInfoItem({this.id, this.title, this.subtitle, this.thumbnails = const [], this.artists});
}
