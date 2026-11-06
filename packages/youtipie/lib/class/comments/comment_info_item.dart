import 'package:youtipie/class/comments/comment_info_item_base.dart' show YoutiPieCommentInfoItemBase;

typedef CommentInfoItem = YoutiPieCommentInfoItem;

class YoutiPieCommentInfoItem extends YoutiPieCommentInfoItemBase {
  const YoutiPieCommentInfoItem({
    super.author,
    super.authorAvatarUrl,
    super.commentId,
    super.content,
    super.engagement,
    super.isEdited,
    super.isHearted,
    super.isPinned,
    super.likeStatus,
    super.likesCount,
    super.linkedMainCommentId,
    super.linkedReply,
    super.publishedAt,
    super.publishedTimeText,
    super.repliesCount,
    super.replyContinuation,
    super.videoId,
    super.voiceReplyTranscript,
  });
}
