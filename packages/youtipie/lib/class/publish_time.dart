import 'package:youtipie/src/unavailable.dart';

class PublishTime {
  final DateTime? date;
  final String? text;
  const PublishTime({this.date, this.text});
  const PublishTime.unknown() : date = null, text = null;
  DateTime? get accurateDate => unavailable('PublishTime.accurateDate');
  static PublishTime fromMap(Map<String, dynamic> map) => unavailable('PublishTime.fromMap');
}
