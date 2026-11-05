import 'package:youtipie/class/comments/comment_info_item_base.dart' show YoutiPieCommentInfoItemBase;
import 'package:youtipie/class/notification_menu_action.dart' show NotificationPossibleInfo;

class StreamInfoItemNotification extends YoutiPieCommentInfoItemBase {
  final String id;
  final String title;
  final dynamic isRead;
  final dynamic menuActions;
  final dynamic isComment;
  final dynamic shortText;
  final dynamic publishedAt;
  final NotificationPossibleInfo? possibleInfo;
  final dynamic thumbs;
  final dynamic uploaderthumbs;
  final dynamic isCommentReply;
  final dynamic notificationId;
  final dynamic linkedCommentId;
  const StreamInfoItemNotification({
    this.id = '',
    this.title = '',
    this.isRead,
    this.menuActions,
    this.isComment,
    this.shortText,
    this.publishedAt,
    this.possibleInfo,
    this.thumbs,
    this.uploaderthumbs,
    this.isCommentReply,
    this.notificationId,
    this.linkedCommentId,
    super.linkedReply,
    super.linkedMainCommentId,
  });
}
