import 'package:youtipie/class/publish_time.dart' show PublishTime;
import 'package:youtipie/class/youtipie_description/youtipie_description.dart' show YoutipieDescription;
import 'package:youtipie/core/enum.dart' show LikeStatus;
import 'package:youtipie/src/unavailable.dart';

typedef VideoInfo = YoutiPieVideoInfo;

class YoutiPieVideoEngagement {
  final int? likesCount;
  final String? likesCountText;
  final LikeStatus likeStatus;

  const YoutiPieVideoEngagement({this.likesCount, this.likesCountText, this.likeStatus = LikeStatus.unknown});
}

class YoutiPieVideoInfo {
  final String title;
  final int? viewsCount;
  final String? viewsText;
  final String? viewCountTextShort;
  final String? viewCountTextLong;
  final PublishTime publishedAt;
  final YoutipieDescription? description;
  final YoutiPieVideoEngagement? engagement;

  const YoutiPieVideoInfo({
    this.title = '',
    this.viewsCount,
    this.viewsText,
    this.viewCountTextShort,
    this.viewCountTextLong,
    this.publishedAt = const PublishTime.unknown(),
    this.description,
    this.engagement,
  });

  String buildUrl() => unavailable('YoutiPieVideoInfo.buildUrl');
}
