import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/youtipie_feed/playlist_info_item_user.dart' show PlaylistInfoItemUser;

typedef PlaylistUserResult = YoutiPieUserPlaylistsResult;

class YoutiPieUserPlaylistsResult extends YoutiPieListWrapper<PlaylistInfoItemUser> {
  @override
  final List<PlaylistInfoItemUser> items;
  const YoutiPieUserPlaylistsResult({List<PlaylistInfoItemUser> items = const [], String? continuation}) : items = items, super(items: items, continuation: continuation);
}
