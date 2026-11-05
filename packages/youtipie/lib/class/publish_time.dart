import 'package:youtipie/src/unavailable.dart';

class PublishTime {
  final DateTime? date;
  final String? text;
  const PublishTime({this.date, this.text});
  const PublishTime.unknown() : date = null, text = null;
  static PublishTime fromMap(dynamic map) => unavailable('PublishTime.fromMap');
}
