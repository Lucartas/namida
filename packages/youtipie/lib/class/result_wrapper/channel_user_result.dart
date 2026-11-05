import 'package:youtipie/class/channels/channel_info.dart' show YoutiPieChannelInfo;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;

typedef ChannelUserResult = YoutiPieUserChannelsResult;

class YoutiPieUserChannelsResult extends YoutiPieListWrapper<YoutiPieChannelInfo> {
  @override
  final List<YoutiPieChannelInfo> items;
  const YoutiPieUserChannelsResult({List<YoutiPieChannelInfo> items = const [], dynamic continuation}) : items = items, super(items: items, continuation: continuation);
}
