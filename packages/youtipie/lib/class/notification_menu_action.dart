typedef NotificationMenuAction = dynamic;

enum NotificationMenuActionType { hide, volume }

class NotificationPossibleInfo {
  final String title;
  final String channelTitle;
  const NotificationPossibleInfo({this.title = '', this.channelTitle = ''});
}
