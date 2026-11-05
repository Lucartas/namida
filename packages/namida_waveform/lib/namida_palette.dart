import 'dart:typed_data';

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

class PaletteData {
  Uint32List get colors => _unavailable('PaletteData.colors');
}

abstract final class NamidaPalette {
  static Future<PaletteData> extractAsync({String? path, Uint8List? bytes, required int maxColors, required int maxHeight}) => _unavailable('NamidaPalette.extractAsync');
}
