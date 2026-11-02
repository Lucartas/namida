import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart' as public_plugin;
import 'package:flutter_sharing_intent/model/sharing_file.dart' as public_model;
import 'package:path_provider/path_provider.dart' as path_provider;

import '../model/sharing_file.dart';

class FlutterSharingIntent {
  FlutterSharingIntent._();

  static final instance = FlutterSharingIntent._();

  final public_plugin.FlutterSharingIntent _plugin = public_plugin.FlutterSharingIntent.instance;
  final MethodChannel _storageChannel = const MethodChannel('namida/storage');
  final Map<String, Future<String?>> _stagedFiles = {};
  Future<void>? _sessionPreparation;
  int _nextStagedFileId = 0;

  Future<List<SharedFile>> getInitialSharing() async {
    await _prepareSession();
    final files = await _plugin.getInitialSharing();
    return _adaptFiles(files);
  }

  Stream<List<SharedFile>> getMediaStream() => _plugin.getMediaStream().asyncMap((files) async {
    await _prepareSession();
    return _adaptFiles(files);
  });

  void reset() => _plugin.reset();

  Future<void> _prepareSession() => _sessionPreparation ??= _clearPreviousSessionFiles();

  Future<void> _clearPreviousSessionFiles() async {
    _stagedFiles.clear();
    if (!Platform.isAndroid) return;

    try {
      final cacheDirectory = await path_provider.getTemporaryDirectory();
      final stagingDirectory = Directory('${cacheDirectory.path}/namida_received_intents');
      if (await stagingDirectory.exists()) await stagingDirectory.delete(recursive: true);
    } catch (_) {}
  }

  Future<List<SharedFile>> _adaptFiles(List<public_model.SharedFile> files) async {
    final adapted = <SharedFile>[];
    for (final file in files) {
      var realPath = _realPathFrom(file);
      final value = file.value;
      if (value?.startsWith('content://') == true) {
        realPath = await _resolveContentUri(value!);
      }
      realPath = await _preserveCachedFile(realPath);
      adapted.add(SharedFile.fromPublicPlugin(file, realPath: realPath));
    }
    return adapted;
  }

  String? _realPathFrom(public_model.SharedFile file) {
    final value = file.value;
    if (value == null) return null;

    final isFileUri = value.startsWith('file://');
    final path = isFileUri ? Uri.parse(value).toFilePath() : value;
    if (file.type == public_model.SharedMediaType.IMAGE || file.type == public_model.SharedMediaType.VIDEO || file.type == public_model.SharedMediaType.FILE) {
      return path;
    }

    if (value.startsWith('/') || isFileUri) return path;
    return null;
  }

  Future<String?> _resolveContentUri(String contentUri) async {
    if (!Platform.isAndroid) return null;

    try {
      // Reuse Namida's existing Android storage bridge for ACTION_VIEW content URIs.
      return await _storageChannel.invokeMethod<String?>('getRealPath', {'contentUri': contentUri});
    } catch (_) {
      return null;
    }
  }

  Future<String?> _preserveCachedFile(String? path) async {
    if (!Platform.isAndroid || path == null) return path;

    try {
      final cachePath = (await path_provider.getTemporaryDirectory()).path;
      final stagingDirectoryPath = '$cachePath/namida_received_intents';
      if (path.startsWith('$stagingDirectoryPath/')) return path;

      final cachePrefix = '$cachePath/';
      if (!path.startsWith(cachePrefix)) return path;
      final cacheEntryName = path.substring(cachePrefix.length);
      if (cacheEntryName.isEmpty || cacheEntryName.contains('/')) return path;

      return await _stagedFiles.putIfAbsent(path, () => _stageCachedFile(path, cachePath));
    } catch (_) {
      return path;
    }
  }

  Future<String?> _stageCachedFile(String path, String cachePath) async {
    try {
      final stagingDirectory = Directory('$cachePath/namida_received_intents');
      final source = File(path);
      if (!await source.exists()) return path;

      final originalName = source.uri.pathSegments.isEmpty ? 'shared_file' : source.uri.pathSegments.last;
      final extensionIndex = originalName.lastIndexOf('.');
      final extension = extensionIndex >= 0 ? originalName.substring(extensionIndex) : '';
      final fileId = _nextStagedFileId++;
      final target = File('${stagingDirectory.path}/${DateTime.now().microsecondsSinceEpoch}_$fileId$extension');
      await stagingDirectory.create(recursive: true);

      try {
        return (await source.rename(target.path)).path;
      } catch (_) {
        try {
          return (await source.copy(target.path)).path;
        } catch (_) {
          return path;
        }
      }
    } catch (_) {
      return path;
    }
  }
}
