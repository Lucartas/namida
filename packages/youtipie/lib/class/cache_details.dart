import 'package:youtipie/src/unavailable.dart';

class CacheDecision {
  static const cacheOnly = CacheDecision._();
  const CacheDecision._();
}

class CacheDetails<T> {
  final dynamic section;
  final dynamic key;
  final dynamic accountId;
  const CacheDetails({this.section, this.key, this.accountId});
  Future<T?> read() => unavailable('CacheDetails.read');
  T? readSync() => unavailable('Remote cache');
}

class CacheDetailsBase {
  final dynamic section;
  final dynamic key;
  final dynamic Function()? accountId;
  const CacheDetailsBase(this.section, this.key, this.accountId);
  Future<void> close() => unavailable('CacheDetailsBase.close');
  dynamic loadEverythingSync(dynamic callback) => unavailable('Remote cache');
  dynamic loadEverythingExtractedSync(dynamic paths, dynamic callback) => unavailable('Remote cache');
  dynamic readAllMapsSync(dynamic keys) => unavailable('Remote cache');
}
