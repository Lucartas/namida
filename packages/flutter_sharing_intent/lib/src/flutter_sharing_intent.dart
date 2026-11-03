import '../model/sharing_file.dart';

/// No-op replacement for the platform sharing plugin.
///
/// Sharing is outside the current compile-only milestone, so this mock reports
/// no initial shares and never emits stream events.
class FlutterSharingIntent {
  FlutterSharingIntent._();

  static final instance = FlutterSharingIntent._();

  Future<List<SharedFile>> getInitialSharing() async => const <SharedFile>[];

  Stream<List<SharedFile>> getMediaStream() => const Stream<List<SharedFile>>.empty();

  void reset() {}
}
