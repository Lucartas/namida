import 'package:youtipie/class/chunks/history_chunk.dart' show YoutiPieHistoryChunk;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;

typedef HistoryResult = YoutiPieHistoryResult;

class YoutiPieHistoryResult extends YoutiPieListWrapper<YoutiPieHistoryChunk> {
  const YoutiPieHistoryResult({List<YoutiPieHistoryChunk> items = const [], dynamic continuation}) : super(items: items, continuation: continuation);
}
