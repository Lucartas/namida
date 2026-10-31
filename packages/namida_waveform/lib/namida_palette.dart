import 'dart:typed_data';

Never _unsupported() => throw UnsupportedError('Native palette extraction is unavailable in this build.');

enum PaletteError { none, allocation, openInput, noVideoStream, noDecoder, decoderOpen, decode, unsupportedFormat, noOutput, thread, unknown }

class PaletteData {
  final Uint32List colors;
  final Uint32List populations;
  final int width;
  final int height;
  final PaletteError error;

  const PaletteData({required this.colors, required this.populations, required this.width, required this.height, required this.error});

  PaletteData.failed(this.error) : colors = Uint32List(0), populations = Uint32List(0), width = 0, height = 0;

  bool get isEmpty => colors.isEmpty;
  bool get isNotEmpty => colors.isNotEmpty;
}

abstract final class NamidaPalette {
  static Future<PaletteData> extractAsync({String? path, Uint8List? bytes, int maxColors = 16, int maxHeight = 240}) async => _unsupported();

  static int get nativeVersion => _unsupported();
}
