import 'package:youtipie/class/streams/codec_info.dart' show CodecInfo;

abstract interface class StreamBase {
  int get sizeInBytes;
  CodecInfo get codecInfo;
  Uri? buildUrl();
}
