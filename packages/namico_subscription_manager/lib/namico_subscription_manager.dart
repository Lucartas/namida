import 'class/supabase_sub.dart';
import 'class/support_tier.dart';

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

class NamicoSubscriptionManager {
  static set onError(void Function(String message, Object? error, StackTrace? stackTrace) callback) => _unavailable('NamicoSubscriptionManager.onError');

  static Future<void> initialize({required dynamic dataDirectory, required dynamic encryptionKey, required bool isNewKey}) =>
      _unavailable('NamicoSubscriptionManager.initialize');

  static NamicoPatreon get patreon => _unavailable('NamicoSubscriptionManager.patreon');
  static NamicoSupabase get supabase => _unavailable('NamicoSubscriptionManager.supabase');
  static NamicoSubscriptionCache get cacheManager => _unavailable('NamicoSubscriptionManager.cacheManager');
}

class NamicoPatreon {
  Future<SupportTier?> getUserSupportTierInCacheValid() => _unavailable('NamicoPatreon.getUserSupportTierInCacheValid');
  Future<SupportTier?> getUserSupportTier({required dynamic redirectUrlCompleter, required dynamic pageConfig, required dynamic signIn}) =>
      _unavailable('NamicoPatreon.getUserSupportTier');
  Future<SupportTier?> getUserSupportTierWithoutLogin() => _unavailable('NamicoPatreon.getUserSupportTierWithoutLogin');
}

class NamicoSupabase {
  Future<SupabaseSub?> getUserSubValidCache() => _unavailable('NamicoSupabase.getUserSubValidCache');
  Future<SupabaseSub?> getUserSubInCache() => _unavailable('NamicoSupabase.getUserSubInCache');
  Future<SupabaseSub> fetchUserValid({required String uuid, required String email, required dynamic deviceId}) => _unavailable('NamicoSupabase.fetchUserValid');
  Future<SupabaseSub> claimSubscription({required String uuid, required String email, required dynamic deviceId}) => _unavailable('NamicoSupabase.claimSubscription');
}

class NamicoSubscriptionCache {
  Future<PatreonToken?> getPatreonTokenCache() => _unavailable('NamicoSubscriptionCache.getPatreonTokenCache');
  void deletePatreonCache() => _unavailable('NamicoSubscriptionCache.deletePatreonCache');
  void deleteSupabaseCache() => _unavailable('NamicoSubscriptionCache.deleteSupabaseCache');
}

class PatreonToken {
  String? get accessToken => _unavailable('PatreonToken.accessToken');
}
