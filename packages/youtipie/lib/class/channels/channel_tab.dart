import 'package:youtipie/src/unavailable.dart';

enum ChannelTab { videos }

extension ChannelTabTitle on ChannelTab {
  String get title => unavailable('ChannelTab.title');
}
