import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/src/unavailable.dart';

typedef StreamSegments = List<StreamSegment>;

class StreamSegment {
  final int? startSeconds;
  final String title;
  final YoutiPieThumbnail? thumbnail;

  const StreamSegment({this.startSeconds, this.title = '', this.thumbnail});
}

extension StreamSegmentListLookup on List<StreamSegment> {
  StreamSegment? findByMillisecond(int milliseconds) => unavailable('StreamSegments.findByMillisecond');
}
