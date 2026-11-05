import 'package:youtipie/class/comments/comment_info_item.dart' show YoutiPieCommentInfoItem;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/src/unavailable.dart';

typedef CommentResult = YoutiPieCommentResult;

class YoutiPieCommentResult extends YoutiPieListWrapper<YoutiPieCommentInfoItem> {
  final dynamic sorters;
  final dynamic commentsCount;
  final dynamic pausedMessage;
  final dynamic videoId;

  const YoutiPieCommentResult({
    List<YoutiPieCommentInfoItem> items = const [],
    dynamic continuation,
    this.sorters,
    this.commentsCount,
    this.pausedMessage,
    this.videoId,
  }) : super(items: items, continuation: continuation);

  bool get isEmpty => unavailable('YoutiPieCommentResult.isEmpty');
  YoutiPieCommentInfoItem operator [](int index) => unavailable('YoutiPieCommentResult.[]');
  dynamic get createParams => unavailable('YoutiPieCommentResult.createParams');
  dynamic transferLocalItemsTo(dynamic other) => unavailable('Remote comment pagination');
}
