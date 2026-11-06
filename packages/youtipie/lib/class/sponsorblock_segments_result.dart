import 'package:youtipie/class/sponsorblock_segment.dart' show SponsorBlockSegment;

typedef SponsorblockSegmentsResult = SponsorBlockSegmentsResult;

class SponsorBlockSegmentsResult {
  final List<SponsorBlockSegment> segments;
  final int? videoDurationMS;
  final SponsorBlockSegment? poi_highlight;
  final int? firstMS;
  final int? lastMS;

  const SponsorBlockSegmentsResult({this.segments = const [], this.videoDurationMS, this.poi_highlight, this.firstMS, this.lastMS});
}
