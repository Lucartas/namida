export 'package:youtipie/core/enum.dart' show YoutiPieFetchAllResType;
export 'package:youtipie/core/extensions.dart' show YoutiPieNumberFormatting;

import 'package:youtipie/src/unavailable.dart';
import 'package:youtipie/class/cache_details.dart' show CacheDecision;

class ExecuteDetails {
  const ExecuteDetails();
  const ExecuteDetails.forceRequest();
  const ExecuteDetails.cache(CacheDecision _);
  static const kForceRequest = ExecuteDetails.forceRequest();
  factory ExecuteDetails.normal() => unavailable('ExecuteDetails.normal');
}
