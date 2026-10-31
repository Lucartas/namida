Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this offline build.');
typedef SupabaseSub = dynamic;
typedef SupportTier = dynamic;

class NamicoSubscriptionManager {
  static dynamic get cacheManager => _unavailable('NamicoSubscriptionManager.cacheManager');
  static dynamic get initialize => _unavailable('NamicoSubscriptionManager.initialize');
  static set onError(dynamic _) {}
  static dynamic get patreon => _unavailable('NamicoSubscriptionManager.patreon');
  static dynamic get supabase => _unavailable('NamicoSubscriptionManager.supabase');
}
