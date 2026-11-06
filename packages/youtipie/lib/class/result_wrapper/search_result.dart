import 'package:youtipie/class/chunks/history_chunk.dart' show YoutiPieHistoryChunk;
import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;

typedef SearchResult = YoutiPieSearchResult;

class YoutiPieSearchResult extends YoutiPieListWrapper<YoutiPieHistoryChunk> {
  final List<YoutiPieCorrectedQueryItem> correctedQuery;
  const YoutiPieSearchResult({List<YoutiPieHistoryChunk> items = const [], String? continuation, this.correctedQuery = const []}) : super(items: items, continuation: continuation);
}

class YoutiPieCorrectedQueryItem {
  final String text;
  final bool corrected;

  const YoutiPieCorrectedQueryItem({this.text = '', this.corrected = false});
}
