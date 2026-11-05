import 'package:youtipie/class/map_serializable.dart' show MapSerializable;

typedef CommentInfoItemBase = YoutiPieCommentInfoItemBase;

class YoutiPieCommentInfoItemBase extends MapSerializable {
  final dynamic author;
  final dynamic authorAvatarUrl;
  final dynamic commentId;
  final dynamic content;
  final dynamic engagement;
  final dynamic isEdited;
  final dynamic isHearted;
  final dynamic isPinned;
  final dynamic likeStatus;
  final dynamic likesCount;
  final dynamic linkedMainCommentId;
  final dynamic linkedReply;
  final dynamic publishedAt;
  final dynamic publishedTimeText;
  final dynamic repliesCount;
  final dynamic replyContinuation;
  final dynamic videoId;
  final dynamic voiceReplyTranscript;

  const YoutiPieCommentInfoItemBase({
    this.author,
    this.authorAvatarUrl,
    this.commentId,
    this.content,
    this.engagement,
    this.isEdited,
    this.isHearted,
    this.isPinned,
    this.likeStatus,
    this.likesCount,
    this.linkedMainCommentId,
    this.linkedReply,
    this.publishedAt,
    this.publishedTimeText,
    this.repliesCount,
    this.replyContinuation,
    this.videoId,
    this.voiceReplyTranscript,
  });
}
