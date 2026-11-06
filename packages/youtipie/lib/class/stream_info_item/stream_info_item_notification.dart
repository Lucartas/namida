import 'package:youtipie/class/comments/comment_info_item_base.dart' show YoutiPieCommentInfoItemBase;
import 'package:youtipie/class/notification_menu_action.dart' show NotificationMenuAction, NotificationPossibleInfo;
import 'package:youtipie/class/publish_time.dart' show PublishTime;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;

class StreamInfoItemNotification extends YoutiPieCommentInfoItemBase {
  final String id;
  final String title;
  final bool? isRead;
  final List<NotificationMenuAction> menuActions;
  final bool isComment;
  final String shortText;
  final PublishTime publishedAt;
  final NotificationPossibleInfo? possibleInfo;
  final List<YoutiPieThumbnail> thumbs;
  final List<YoutiPieThumbnail> uploaderthumbs;
  final bool isCommentReply;
  final String notificationId;
  final String? linkedCommentId;
  const StreamInfoItemNotification({
    this.id = '',
    this.title = '',
    this.isRead,
    this.menuActions = const [],
    this.isComment = false,
    this.shortText = '',
    this.publishedAt = const PublishTime.unknown(),
    this.possibleInfo,
    this.thumbs = const [],
    this.uploaderthumbs = const [],
    this.isCommentReply = false,
    this.notificationId = '',
    this.linkedCommentId,
    super.linkedReply,
    super.linkedMainCommentId,
  });
}
