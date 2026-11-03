import 'package:namico_subscription_manager/core/enum.dart';

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this offline build.');

class SupabaseSub {
  final String? name;
  final DateTime? availableTill;
  final int days;
  final bool claimed;
  final DateTime? lastChecked;
  final String? uuid;
  final String? email;

  const SupabaseSub({this.name, this.availableTill, this.days = 0, this.claimed = false, this.lastChecked, this.uuid, this.email});

  MembershipType toMembershipType() => MembershipType.none;
}

class SupportTier {
  final String? userName;
  final dynamic imageUrl;
  final num? ammountUSD;
  final DateTime? declinedSince;
  final DateTime? createdAt;
  final DateTime? lastChecked;

  const SupportTier({this.userName, this.imageUrl, this.ammountUSD, this.declinedSince, this.createdAt, this.lastChecked});

  MembershipType toMembershipType() => MembershipType.none;
}

class NamicoSubscriptionManager {
  static dynamic get cacheManager => _unavailable('NamicoSubscriptionManager.cacheManager');
  static dynamic get initialize => _unavailable('NamicoSubscriptionManager.initialize');
  static set onError(dynamic _) {}
  static dynamic get patreon => _unavailable('NamicoSubscriptionManager.patreon');
  static dynamic get supabase => _unavailable('NamicoSubscriptionManager.supabase');
}
