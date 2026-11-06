import 'package:youtipie/src/unavailable.dart';

typedef UrlUtils = YTUrlUtils;

abstract final class YTUrlUtils {
  static String buildVideoUrl(String id, {int? timestampSeconds}) => unavailable('YTUrlUtils.buildVideoUrl');
  static String buildChannelUrl(String id) => unavailable('YTUrlUtils.buildChannelUrl');
  static String buildPlaylistUrl(String id) => unavailable('YTUrlUtils.buildPlaylistUrl');
}
