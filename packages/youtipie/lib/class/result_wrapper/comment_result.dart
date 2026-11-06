import 'package:youtipie/class/comments/comment_info_item.dart' show YoutiPieCommentInfoItem;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/core/enum.dart' show CommentsSortType;
import 'package:youtipie/src/unavailable.dart';

typedef CommentResult = YoutiPieCommentResult;

class YoutiPieCommentResult extends YoutiPieListWrapper<YoutiPieCommentInfoItem> {
  final Map<CommentsSortType, String> sorters;
  final int? commentsCount;
  final String? pausedMessage;
  final String? videoId;

  const YoutiPieCommentResult({
    List<YoutiPieCommentInfoItem> items = const [],
    String? continuation,
    this.sorters = const {},
    this.commentsCount,
    this.pausedMessage,
    this.videoId,
  }) : super(items: items, continuation: continuation);

  bool get isEmpty => unavailable('YoutiPieCommentResult.isEmpty');
  YoutiPieCommentInfoItem operator [](int index) => unavailable('YoutiPieCommentResult.[]');
  Object? get createParams => unavailable('YoutiPieCommentResult.createParams');
  void transferLocalItemsTo(YoutiPieCommentResult other) => unavailable('Remote comment pagination');
}
