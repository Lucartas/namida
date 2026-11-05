import 'package:youtipie/class/execute_details.dart' show ExecuteDetails;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/stream_info_item/stream_info_item.dart' show StreamInfoItem;
import 'package:youtipie/class/youtipie_feed/playlist_basic_info.dart' show PlaylistBasicInfo;
import 'package:youtipie/src/unavailable.dart';

typedef PlaylistResultBase = dynamic;

class YoutiPiePlaylistResultBase extends YoutiPieListWrapper<StreamInfoItem> {
  final PlaylistBasicInfo basicInfo;
  final dynamic cacheKey;
  const YoutiPiePlaylistResultBase({required this.basicInfo, required List<StreamInfoItem> items, this.cacheKey, dynamic continuation})
    : super(items: items, continuation: continuation);
  PlaylistBasicInfo get info => unavailable('YoutiPiePlaylistResultBase.info');
  dynamic get playlistId => unavailable('YoutiPiePlaylistResultBase.playlistId');
  @override
  bool get canFetchNext => unavailable('YoutiPiePlaylistResultBase.canFetchNext');
  Future<bool> fetchNext() => unavailable('YoutiPiePlaylistResultBase.fetchNext');
  @override
  dynamic fetchAll({dynamic onProgress, ExecuteDetails? details}) => unavailable('Remote playlist pagination');
  Future<bool> fetchNextFunction(ExecuteDetails? details) => unavailable('YoutiPiePlaylistResultBase.fetchNextFunction');
  Map<String, dynamic> toMapRaw() => unavailable('Remote playlist serialization');
}
