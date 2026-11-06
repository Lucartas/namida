import 'package:youtipie/class/streams/video_stream.dart' show VideoStream;
import 'package:youtipie/src/unavailable.dart';

extension ThumbnailPickerExt<T> on List<T> {
  T? pick() => unavailable('List.pick');
}

extension StreamFilterVideoUtils on List<VideoStream> {
  List<VideoStream> withoutWebmIfNeccessaryOrExperimentalCodecs({bool allowExperimentalCodecs = false}) => unavailable('VideoStream list filtering');
}

typedef CodecInfoUtils = dynamic;

extension YoutiPieNumberFormatting on num {
  String formatDecimalShort([bool expanded = false]) => unavailable('YoutiPieNumberFormatting.formatDecimalShort');
}

extension YTStringUtils on String {
  bool get isDummyVideoId => unavailable('String.isDummyVideoId');
  bool isYTTitleFaulty() => unavailable('String.isYTTitleFaulty');
}
