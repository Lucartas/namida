import 'package:youtipie/class/map_serializable.dart' show MapSerializable;

typedef VideoPlayabilty = VideoPlayability;

enum VideoPlayabiltyStatus { ok, unknown }

class VideoPlayability extends MapSerializable {
  final String? reason;
  final List<String>? messages;
  final dynamic status;
  const VideoPlayability({this.reason, this.messages, this.status});
}
