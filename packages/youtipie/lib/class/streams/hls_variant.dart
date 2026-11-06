import 'package:youtipie/src/unavailable.dart';

class HlsVariant {
  final int height;
  final int bandwidth;
  final String uri;

  const HlsVariant({this.height = 0, this.bandwidth = 0, this.uri = ''});
}

class HlsMasterPlaylist {
  final List<HlsVariant> variants;
  const HlsMasterPlaylist({this.variants = const []});

  String buildSingleVariantMaster(HlsVariant variant) => unavailable('Live HLS variant selection');
}
