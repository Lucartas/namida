export 'package:youtipie/core/enum.dart' show YoutiPieFetchAllResType;
export 'package:youtipie/core/extensions.dart' show YoutiPieNumberFormatting;

import 'package:youtipie/src/unavailable.dart';

class ExecuteDetails {
  const ExecuteDetails();
  const ExecuteDetails.forceRequest();
  const ExecuteDetails.cache(dynamic _);
  static const kForceRequest = ExecuteDetails.forceRequest();
  factory ExecuteDetails.normal() => unavailable('ExecuteDetails.normal');
}
