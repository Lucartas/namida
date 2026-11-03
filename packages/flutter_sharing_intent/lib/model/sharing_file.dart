// ignore_for_file: constant_identifier_names

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
}
