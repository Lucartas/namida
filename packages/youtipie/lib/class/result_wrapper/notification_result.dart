import 'package:youtipie/class/result_wrapper/list_wrapper_base.dart' show YoutiPieListWrapper;
import 'package:youtipie/class/stream_info_item/stream_info_item_notification.dart' show StreamInfoItemNotification;

typedef NotificationResult = YoutiPieNotificationResult;

class YoutiPieNotificationResult extends YoutiPieListWrapper<StreamInfoItemNotification> {
  const YoutiPieNotificationResult({List<StreamInfoItemNotification> items = const [], String? continuation}) : super(items: items, continuation: continuation);
}
