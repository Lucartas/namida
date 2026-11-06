import 'package:youtipie/class/comments/comment_info_item.dart' show YoutiPieCommentInfoItem;
import 'package:youtipie/class/result_wrapper/comment_result.dart' show YoutiPieCommentResult;

typedef CommentNotificationResult = YoutiPieNotificationCommentResult;

class YoutiPieNotificationCommentResult extends YoutiPieCommentResult {
  final YoutiPieCommentInfoItem? linkedReply;
  final String? linkedMainCommentId;
  const YoutiPieNotificationCommentResult({
    super.items = const [],
    super.continuation,
    super.sorters,
    super.commentsCount,
    super.pausedMessage,
    super.videoId,
    this.linkedReply,
    this.linkedMainCommentId,
  });
}
