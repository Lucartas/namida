typedef SponsorblockSegment = SponsorBlockSegment;

class SponsorBlockSegment {
  final String uuid;
  final String category;
  final String actionType;
  final int segmentStartMS;
  final int segmentEndMS;
  final int durationMS;

  const SponsorBlockSegment({
    this.uuid = '',
    this.category = '',
    this.actionType = '',
    this.segmentStartMS = 0,
    this.segmentEndMS = 0,
    this.durationMS = 0,
  });
}
