import 'package:nampack/reactive/reactive.dart';

import 'src/mock_models.dart';

export 'src/mock_models.dart';

Never _unavailableRemoteOperation(Invocation invocation) => throw UnsupportedError(
  'YouTube operation ${invocation.memberName} is unavailable in the offline build.',
);

class _UnavailableRemoteApi {
  const _UnavailableRemoteApi();

  dynamic noSuchMethod(Invocation invocation) => _unavailableRemoteOperation(invocation);
}

class YoutiPieCookies {
  final Rxn<YoutiPieChannelInfo> activeAccountChannel = Rxn<YoutiPieChannelInfo>();
  final Rx<Set<dynamic>> signedInAccounts = Rx<Set<dynamic>>(<dynamic>{});
  bool? canAddMultiAccounts;
  bool get canAuthorizeRequests => false;

  void addOnAccountChanged(void Function() callback) {}
  void removeOnAccountChanged(void Function() callback) {}
  bool isSessionExpired(dynamic account) => false;
  void signOut(dynamic userChannel) {}
  void setAccount(dynamic userChannel) {}
  void setAnonymous() {}
}

/// Compile-time facade for the upstream remote client.
///
/// Accessing any remote operation fails explicitly; this adapter never returns
/// simulated YouTube data or account success.
abstract final class YoutiPie {
  static const _UnavailableRemoteApi _api = _UnavailableRemoteApi();

  static const dynamic activeAccountDetails = _api;
  static const dynamic cacheBuilder = _api;
  static const dynamic cacheManager = _api;
  static const dynamic cacheManagerSync = _api;
  static const dynamic channel = _api;
  static const dynamic channelAction = _api;
  static const dynamic cipher = _api;
  static const dynamic comment = _api;
  static const dynamic commentAction = _api;
  static final YoutiPieCookies cookies = YoutiPieCookies();
  static const dynamic countryCode = _api;
  static const dynamic feed = _api;
  static const dynamic hashtag = _api;
  static const dynamic history = _api;
  static const dynamic lastSessionFailureReport = _api;
  static const dynamic lastSessionReset = _api;
  static const dynamic memoryCache = _api;
  static const dynamic missingInfo = _api;
  static const dynamic music = _api;
  static const dynamic notificationsAction = _api;
  static const dynamic playlist = _api;
  static const dynamic playlistAction = _api;
  static const dynamic potoken = _api;
  static const dynamic returnyoutubedislike = _api;
  static const dynamic search = _api;
  static const dynamic signedInAccounts = _api;
  static const dynamic sponsorblock = _api;
  static const dynamic userchannel = _api;
  static const dynamic userplaylist = _api;
  static const dynamic video = _api;
  static const dynamic videoAction = _api;

  static set canExecuteOperation(dynamic _) {}
  static set onOperationFailNoAccount(dynamic _) {}

  static dynamic get canExecuteOperation => _api;
  static dynamic get onOperationFailNoAccount => _api;
  static const dynamic getActiveAccountChannelIsolate = _api;
  static const dynamic initialize = _api;
  static const dynamic dispose = _api;
  static const dynamic resetSession = _api;
  static const dynamic setDefaultClients = _api;
  static const dynamic setLogs = _api;
  static const dynamic languageCode = _api;
}
