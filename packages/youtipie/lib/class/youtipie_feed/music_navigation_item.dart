import 'package:flutter/material.dart' show Color;
import 'package:youtipie/class/music/music_browse_endpoint.dart' show YoutiPieMusicBrowseEndpoint;

class MusicNavigationItem {
  final String id;
  final String title;
  final String? subtitle;
  final Color? color;
  final YoutiPieMusicBrowseEndpoint endpoint;
  const MusicNavigationItem({this.id = '', this.title = '', this.subtitle, this.color, required this.endpoint});
}
