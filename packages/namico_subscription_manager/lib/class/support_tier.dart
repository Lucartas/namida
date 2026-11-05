import '../core/enum.dart';

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

class SupportTier {
  String? get userName => _unavailable('SupportTier.userName');
  dynamic get imageUrl => _unavailable('SupportTier.imageUrl');
  num? get ammountUSD => _unavailable('SupportTier.ammountUSD');
  DateTime? get declinedSince => _unavailable('SupportTier.declinedSince');
  DateTime? get createdAt => _unavailable('SupportTier.createdAt');
  DateTime? get lastChecked => _unavailable('SupportTier.lastChecked');
  MembershipType toMembershipType() => _unavailable('SupportTier.toMembershipType');
}
