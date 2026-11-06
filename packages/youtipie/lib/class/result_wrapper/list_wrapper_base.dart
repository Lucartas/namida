import 'package:youtipie/class/execute_details.dart' show ExecuteDetails;
import 'package:youtipie/class/items_sort.dart' show YoutiPieItemsSort;
import 'package:youtipie/class/map_serializable.dart' show MapSerializable;
import 'package:youtipie/core/enum.dart' show YoutiPieFetchAllResType;
import 'package:youtipie/src/unavailable.dart';

class YoutiPieFetchAllRes {
  final Future<YoutiPieFetchAllResType> result;
  final bool isExecuting;

  const YoutiPieFetchAllRes({required this.result, this.isExecuting = false});

  void cancel() => unavailable('YoutiPieFetchAllRes.cancel');
}

class YoutiPieListWrapper<T extends MapSerializable> with YoutiPieListSorterMixin<T> {
  final List<T> items;
  final String? continuation;
  const YoutiPieListWrapper({this.items = const [], this.continuation});
  int get length => unavailable('YoutiPieListWrapper.length');
  bool get canFetchNext => unavailable('YoutiPieListWrapper.canFetchNext');
  Future<bool> fetchNext() => unavailable('YoutiPieListWrapper.fetchNext');
  YoutiPieFetchAllRes? fetchAll({void Function()? onProgress, ExecuteDetails? details}) => unavailable('Remote list pagination');
}

mixin YoutiPieListSorterMixin<T> {
  List<YoutiPieItemsSort> get itemsSort => unavailable('YoutiPieListSorterMixin.itemsSort');
  YoutiPieItemsSort? get customSort => unavailable('YoutiPieListSorterMixin.customSort');
  Future<bool> fetchWithNewSort({YoutiPieItemsSort? sort, ExecuteDetails? details}) => unavailable('YoutiPieListSorterMixin.fetchWithNewSort');
}
