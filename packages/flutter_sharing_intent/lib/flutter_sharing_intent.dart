Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

class SharedFile {
  final String? value;
  final String? realPath;

  const SharedFile({this.value, this.realPath});
}

class FlutterSharingIntent {
  FlutterSharingIntent._();

  static final instance = FlutterSharingIntent._();

  Future<List<SharedFile>> getInitialSharing() => _unavailable('FlutterSharingIntent.getInitialSharing');
  Stream<List<SharedFile>> getMediaStream() => _unavailable('FlutterSharingIntent.getMediaStream');
}
