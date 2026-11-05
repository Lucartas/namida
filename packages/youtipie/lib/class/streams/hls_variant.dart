import 'package:youtipie/src/unavailable.dart';

typedef HlsVariant = dynamic;

class HlsMasterPlaylist {
  final List<dynamic> variants;
  const HlsMasterPlaylist({this.variants = const []});

  String buildSingleVariantMaster(dynamic variant) => unavailable('Live HLS variant selection');
}
