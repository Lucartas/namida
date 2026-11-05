import 'package:youtipie/src/unavailable.dart';

class MissingVideoInfo {
  final dynamic videoId;
  final dynamic title;
  final dynamic channelId;
  final dynamic channelName;
  final dynamic description;
  final dynamic date;
  final dynamic durSeconds;
  final dynamic videoPage;
  final List<dynamic> sources;
  final dynamic subsource;
  const MissingVideoInfo({
    this.videoId,
    this.title,
    this.channelId,
    this.channelName,
    this.description,
    this.date,
    this.durSeconds,
    this.videoPage,
    this.sources = const [],
    this.subsource,
  });
  static MissingVideoInfo fromMap(dynamic map) => unavailable('MissingVideoInfo.fromMap');
}
