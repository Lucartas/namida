import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/class/publish_time.dart' show PublishTime;
import 'package:youtipie/class/youtipie_description/youtipie_description.dart' show YoutipieDescription;
import 'package:youtipie/core/enum.dart' show LikeStatus;

class YoutiPieCommentAuthor {
  final String? channelId;
  final String? displayName;
  final String? avatarThumbnailUrl;
  final String? memberBadgeText;
  final bool isCurrentUser;
  final bool isArtist;

  const YoutiPieCommentAuthor({this.channelId, this.displayName, this.avatarThumbnailUrl, this.memberBadgeText, this.isCurrentUser = false, this.isArtist = false});
}

class YoutiPieCommentEngagement {
  final Object? createReplyParams;

  const YoutiPieCommentEngagement({this.createReplyParams});
}

typedef CommentInfoItemBase = YoutiPieCommentInfoItemBase;

class YoutiPieCommentInfoItemBase extends MapSerializable {
  final YoutiPieCommentAuthor? author;
  final String? authorAvatarUrl;
  final String commentId;
  final YoutipieDescription content;
  final YoutiPieCommentEngagement engagement;
  final bool isEdited;
  final bool isHearted;
  final bool isPinned;
  final LikeStatus? likeStatus;
  final int? likesCount;
  final String? linkedMainCommentId;
  final YoutiPieCommentInfoItemBase? linkedReply;
  final PublishTime publishedAt;
  final String? publishedTimeText;
  final int? repliesCount;
  final String? replyContinuation;
  final String? videoId;
  final String? voiceReplyTranscript;

  const YoutiPieCommentInfoItemBase({
    this.author,
    this.authorAvatarUrl,
    this.commentId = '',
    this.content = const YoutipieDescription(),
    this.engagement = const YoutiPieCommentEngagement(),
    this.isEdited = false,
    this.isHearted = false,
    this.isPinned = false,
    this.likeStatus,
    this.likesCount,
    this.linkedMainCommentId,
    this.linkedReply,
    this.publishedAt = const PublishTime.unknown(),
    this.publishedTimeText,
    this.repliesCount,
    this.replyContinuation,
    this.videoId,
    this.voiceReplyTranscript,
  });
}
