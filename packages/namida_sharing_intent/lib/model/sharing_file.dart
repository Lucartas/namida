// ignore_for_file: constant_identifier_names

import 'package:flutter_sharing_intent/model/sharing_file.dart' as public_plugin;

enum SharedMediaType { TEXT, URL, IMAGE, VIDEO, FILE, WEB_SEARCH, OTHER }

class SharedFile {
  final String? value;
  final String? realPath;
  final String? thumbnail;
  final int? duration;
  final SharedMediaType type;
  final String? mimeType;
  final String? message;

  const SharedFile({
    required this.value,
    required this.realPath,
    required this.type,
    this.thumbnail,
    this.duration,
    this.mimeType,
    this.message,
  });

  factory SharedFile.fromPublicPlugin(public_plugin.SharedFile file, {required String? realPath}) => SharedFile(
    value: file.value,
    realPath: realPath,
    thumbnail: file.thumbnail,
    duration: file.duration,
    type: _convertType(file.type),
    mimeType: file.mimeType,
    message: file.message,
  );
}

SharedMediaType _convertType(public_plugin.SharedMediaType type) => switch (type) {
  public_plugin.SharedMediaType.TEXT => SharedMediaType.TEXT,
  public_plugin.SharedMediaType.URL => SharedMediaType.URL,
  public_plugin.SharedMediaType.IMAGE => SharedMediaType.IMAGE,
  public_plugin.SharedMediaType.VIDEO => SharedMediaType.VIDEO,
  public_plugin.SharedMediaType.FILE => SharedMediaType.FILE,
  public_plugin.SharedMediaType.WEB_SEARCH => SharedMediaType.WEB_SEARCH,
  public_plugin.SharedMediaType.OTHER => SharedMediaType.OTHER,
};
