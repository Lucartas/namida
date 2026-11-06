class NotificationMenuAction {
  final String text;
  final String? iconType;
  final NotificationMenuActionType type;

  const NotificationMenuAction({
    this.text = '',
    this.iconType,
    this.type = NotificationMenuActionType.hide,
  });
}

enum NotificationMenuActionType { hide, volume }

class NotificationPossibleInfo {
  final String title;
  final String channelTitle;
  const NotificationPossibleInfo({this.title = '', this.channelTitle = ''});
}
