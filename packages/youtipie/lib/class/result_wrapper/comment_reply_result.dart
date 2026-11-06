import 'package:youtipie/class/comments/comment_info_item_base.dart' show YoutiPieCommentInfoItemBase;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/src/unavailable.dart';

typedef CommentReplyResult = YoutiPieCommentReplyResult;

class YoutiPieCommentReplyResult extends YoutiPieListWrapper<YoutiPieCommentInfoItemBase> {
  final String? commentId;
  final String? cacheKey;
  const YoutiPieCommentReplyResult({this.commentId, this.cacheKey, List<YoutiPieCommentInfoItemBase> items = const [], String? continuation})
    : super(items: items, continuation: continuation);
  int get length => unavailable('YoutiPieCommentReplyResult.length');
  @override
  bool get canFetchNext => unavailable('YoutiPieCommentReplyResult.canFetchNext');
  Future<bool> fetchNext() => unavailable('YoutiPieCommentReplyResult.fetchNext');
  void transferLocalItemsTo(YoutiPieCommentReplyResult other) => unavailable('Remote comment pagination');
}
