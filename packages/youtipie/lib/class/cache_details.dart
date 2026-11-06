import 'package:youtipie/core/enum.dart' show YoutiPieSection;
import 'package:youtipie/src/unavailable.dart';

class CacheDecision {
  static const cacheOnly = CacheDecision._();
  const CacheDecision._();
}

class CacheDetails<T> {
  final YoutiPieSection? section;
  final String? key;
  final String? accountId;
  const CacheDetails({this.section, this.key, this.accountId});
  Future<T?> read() => unavailable('CacheDetails.read');
  T? readSync() => unavailable('Remote cache');
  (T, bool)? readSyncRaw() => unavailable('Remote cache');
  CacheDetails<T> withMaxPeriod({required Duration allowedDuration}) => unavailable('Remote cache');
}

class CacheDetailsBase {
  final YoutiPieSection section;
  final String? key;
  final String? Function()? accountId;
  const CacheDetailsBase(this.section, this.key, this.accountId);
  Future<void> close() => unavailable('CacheDetailsBase.close');
  void loadEverythingSync(void Function(Map<String, dynamic> map) callback) => unavailable('Remote cache');
  void loadEverythingExtractedSync(List<String> paths, void Function(String key, List<Object?> values) callback) => unavailable('Remote cache');
  List<Map<String, dynamic>> readAllMapsSync(Iterable<String> keys) => unavailable('Remote cache');
}
