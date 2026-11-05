import 'package:youtipie/class/chunks/history_chunk.dart' show YoutiPieHistoryChunk;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;

typedef SearchResult = YoutiPieSearchResult;

class YoutiPieSearchResult extends YoutiPieListWrapper<YoutiPieHistoryChunk> {
  final dynamic correctedQuery;
  const YoutiPieSearchResult({List<YoutiPieHistoryChunk> items = const [], dynamic continuation, this.correctedQuery}) : super(items: items, continuation: continuation);
}
