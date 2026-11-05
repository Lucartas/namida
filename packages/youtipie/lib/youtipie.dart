import 'package:nampack/reactive/reactive.dart';

import 'src/mock_models.dart';

export 'src/mock_models.dart';

Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

class YoutiPieCookies {
  Rxn<YoutiPieChannelInfo> get activeAccountChannel => _unavailable('YoutiPieCookies.activeAccountChannel');
  Rx<Set<dynamic>> get signedInAccounts => _unavailable('YoutiPieCookies.signedInAccounts');
  bool? get canAddMultiAccounts => _unavailable('YoutiPieCookies.canAddMultiAccounts');
  set canAddMultiAccounts(bool? value) => _unavailable('YoutiPieCookies.canAddMultiAccounts');
  bool get canAuthorizeRequests => _unavailable('YoutiPieCookies.canAuthorizeRequests');

  void addOnAccountChanged(void Function() callback) => _unavailable('YoutiPieCookies.addOnAccountChanged');
  void removeOnAccountChanged(void Function() callback) => _unavailable('YoutiPieCookies.removeOnAccountChanged');
  bool isSessionExpired(dynamic account) => _unavailable('YoutiPieCookies.isSessionExpired');
  void signOut(dynamic userChannel) => _unavailable('YoutiPieCookies.signOut');
  void setAccount(dynamic userChannel) => _unavailable('YoutiPieCookies.setAccount');
  void setAnonymous() => _unavailable('YoutiPieCookies.setAnonymous');
}

class _YoutiPieCacheBuilder {
  const _YoutiPieCacheBuilder();

  dynamic forChannel({dynamic channelId}) => _unavailable('cacheBuilder.forChannel');
  dynamic forChannelAbout({dynamic channelId}) => _unavailable('cacheBuilder.forChannelAbout');
  dynamic forChannelTab({dynamic channelId, dynamic tab}) => _unavailable('cacheBuilder.forChannelTab');
  dynamic forCommentReplies({dynamic commentId}) => _unavailable('cacheBuilder.forCommentReplies');
  dynamic forComments({dynamic videoId}) => _unavailable('cacheBuilder.forComments');
  dynamic forFeedItems() => _unavailable('cacheBuilder.forFeedItems');
  dynamic forHashtag({dynamic params}) => _unavailable('cacheBuilder.forHashtag');
  dynamic forHistoryVideos() => _unavailable('cacheBuilder.forHistoryVideos');
  dynamic forMissingInfo({dynamic videoId}) => _unavailable('cacheBuilder.forMissingInfo');
  dynamic forMixPlaylistVideos({dynamic mixId, dynamic userPersonalized}) => _unavailable('cacheBuilder.forMixPlaylistVideos');
  dynamic forMusicBrowse({dynamic endpoint}) => _unavailable('cacheBuilder.forMusicBrowse');
  dynamic forNotificationComments({dynamic videoId, dynamic linkedCommentId}) => _unavailable('cacheBuilder.forNotificationComments');
  dynamic forNotificationItems() => _unavailable('cacheBuilder.forNotificationItems');
  dynamic forPlaylistVideos({dynamic playlistId}) => _unavailable('cacheBuilder.forPlaylistVideos');
  dynamic forRelatedVideos({dynamic videoId, dynamic userPersonalized}) => _unavailable('cacheBuilder.forRelatedVideos');
  dynamic forReturnYoutubeDislike({dynamic videoId}) => _unavailable('cacheBuilder.forReturnYoutubeDislike');
  dynamic forStreamInfoItem({dynamic videoId}) => _unavailable('cacheBuilder.forStreamInfoItem');
  dynamic forUserChannels() => _unavailable('cacheBuilder.forUserChannels');
  dynamic forUserChannelsAllVideos() => _unavailable('cacheBuilder.forUserChannelsAllVideos');
  dynamic forUserPlaylists() => _unavailable('cacheBuilder.forUserPlaylists');
  dynamic forVideoPage({dynamic videoId}) => _unavailable('cacheBuilder.forVideoPage');
  dynamic forVideoStreams({dynamic videoId}) => _unavailable('cacheBuilder.forVideoStreams');
}

class _YoutiPieCacheManager {
  const _YoutiPieCacheManager();

  void init(dynamic directory) => _unavailable('cacheManager.init');
  void closeAll() => _unavailable('cacheManager.closeAll');
}

class _YoutiPieCipher {
  const _YoutiPieCipher();

  bool get isPrepared => _unavailable('cipher.isPrepared');
  String? get jsPlayerVersion => _unavailable('cipher.jsPlayerVersion');
  dynamic get signatureTimestamp => _unavailable('cipher.signatureTimestamp');
  dynamic get didFailedToExtractJsCode => _unavailable('cipher.didFailedToExtractJsCode');
  dynamic prepareJSPlayer({required String cacheDirectoryPath}) => _unavailable('cipher.prepareJSPlayer');
}

class _YoutiPieApi {
  const _YoutiPieApi();

  dynamic addRemoveVideosInPlaylist({dynamic videosToAdd, dynamic videosToRemove, dynamic playlistId, dynamic mainList, dynamic onUserPlaylistUpdated}) =>
      _unavailable('playlistAction.addRemoveVideosInPlaylist');
  dynamic addVideoToHistory({dynamic statsPlaybackUrl, dynamic statsWatchtimeUrl}) => _unavailable('history.addVideoToHistory');
  dynamic addHostedPlaylistToLibrary({dynamic playlist}) => _unavailable('userplaylist.addHostedPlaylistToLibrary');
  dynamic applyMenuAction({dynamic mainList, dynamic notification, dynamic action}) => _unavailable('notificationsAction.applyMenuAction');
  dynamic browse(dynamic endpoint, {dynamic details}) => _unavailable('music.browse');
  dynamic changeChannelNotificationStatus({dynamic mainChannelInfo, dynamic notifications}) => _unavailable('channelAction.changeChannelNotificationStatus');
  dynamic changeLikeStatus({dynamic videoPage, dynamic engagement, dynamic action, dynamic comment, dynamic mainList}) => _unavailable('changeLikeStatus');
  dynamic sendVoteAction(dynamic videoId, dynamic action) => _unavailable('returnyoutubedislike.sendVoteAction');
  dynamic changeSubscribeStatus({dynamic mainChannelInfo, dynamic channelEngagement, dynamic subscribe}) => _unavailable('channelAction.changeSubscribeStatus');
  dynamic createComment({dynamic mainList, dynamic createCommentParams, dynamic content, dynamic videoPage, dynamic videoId}) => _unavailable('commentAction.createComment');
  dynamic createPlaylist({dynamic mainList, dynamic title, dynamic initialVideoIds, dynamic privacy}) => _unavailable('userplaylist.createPlaylist');
  dynamic createReply({dynamic mainList, dynamic createReplyParams, dynamic content, dynamic mainComment, dynamic commentsList, dynamic videoPage, dynamic videoId}) =>
      _unavailable('commentAction.createReply');
  dynamic deleteComment({dynamic comment, dynamic mainList, dynamic videoPage}) => _unavailable('commentAction.deleteComment');
  dynamic deleteReply({dynamic reply, dynamic mainList, dynamic mainComment, dynamic commentsList, dynamic videoPage}) => _unavailable('commentAction.deleteReply');
  dynamic editComment({dynamic mainList, dynamic comment, dynamic content}) => _unavailable('commentAction.editComment');
  dynamic editPlaylist({dynamic mainList, dynamic playlists, dynamic playlistId, dynamic title, dynamic description, dynamic privacy, dynamic newVideosAtTop}) =>
      _unavailable('userplaylist.editPlaylist');
  dynamic editReply({dynamic mainList, dynamic reply, dynamic content, dynamic videoId}) => _unavailable('commentAction.editReply');
  dynamic fetchChannelAbout({dynamic channel, dynamic details}) => _unavailable('channel.fetchChannelAbout');
  dynamic fetchChannelInfo({dynamic channelId, dynamic details}) => _unavailable('channel.fetchChannelInfo');
  dynamic fetchChannelPage({dynamic channelId, dynamic handle, dynamic details}) => _unavailable('channel.fetchChannelPage');
  dynamic fetchChannelTab({dynamic channelId, dynamic tab, dynamic sort, dynamic details}) => _unavailable('channel.fetchChannelTab');
  dynamic fetchCommentReplies({dynamic mainComment, dynamic details}) => _unavailable('comment.fetchCommentReplies');
  dynamic fetchComments({dynamic videoId, dynamic continuationToken, dynamic details}) => _unavailable('comment.fetchComments');
  dynamic fetchDislikes(dynamic videoId) => _unavailable('returnyoutubedislike.fetchDislikes');
  dynamic fetchFeed({dynamic details}) => _unavailable('feed.fetchFeed');
  dynamic fetchHashtag({dynamic params, dynamic details}) => _unavailable('hashtag.fetchHashtag');
  dynamic fetchHistory({dynamic details}) => _unavailable('history.fetchHistory');
  dynamic fetchMissingInfo({dynamic videoId}) => _unavailable('missingInfo.fetchMissingInfo');
  dynamic fetchMissingThumbnail({dynamic videoId}) => _unavailable('missingInfo.fetchMissingThumbnail');
  dynamic fetchMusicVideoThumbnailToFile({dynamic id, dynamic filePath}) => _unavailable('video.fetchMusicVideoThumbnailToFile');
  dynamic fetchNotificationComments({dynamic videoId, dynamic linkedCommentId, dynamic details}) => _unavailable('comment.fetchNotificationComments');
  dynamic fetchNotifications({dynamic details, dynamic useNewExtractor}) => _unavailable('feed.fetchNotifications');
  dynamic fetchPlaylist({dynamic playlistId, dynamic details}) => _unavailable('playlist.fetchPlaylist');
  dynamic fetchRelatedVideos({dynamic videoId, dynamic userPersonalized, dynamic preferMix, dynamic relatedVideosParams, dynamic details}) =>
      _unavailable('video.fetchRelatedVideos');
  dynamic fetchUserChannels({dynamic details}) => _unavailable('userchannel.fetchUserChannels');
  dynamic fetchUserChannelsAllVideos({dynamic details}) => _unavailable('userchannel.fetchUserChannelsAllVideos');
  dynamic fetchUserPlaylists({dynamic details}) => _unavailable('userplaylist.getUserPlaylists');
  dynamic fetchVideoPage({dynamic videoId, dynamic relatedVideosParams, dynamic details}) => _unavailable('video.fetchVideoPage');
  dynamic fetchVideoStreams({dynamic id, dynamic details, dynamic client}) => _unavailable('video.fetchVideoStreams');
  dynamic fetchHlsMasterPlaylist(dynamic url) => _unavailable('video.fetchHlsMasterPlaylist');
  dynamic getMixPlaylist({dynamic videoId, dynamic mixId, dynamic userPersonalized, dynamic includeFirstVideo, dynamic details}) => _unavailable('playlist.getMixPlaylist');
  dynamic getPlaylistsForVideo({dynamic videoId, dynamic insertActiveAtTop}) => _unavailable('userplaylist.getPlaylistsForVideo');
  dynamic getPlaylistEditInfo(dynamic playlistId) => _unavailable('userplaylist.getPlaylistEditInfo');
  dynamic getVisitorData() => _unavailable('potoken.getVisitorData');
  dynamic get hasPoToken => _unavailable('potoken.hasPoToken');
  dynamic get lastRefreshed => _unavailable('potoken.lastRefreshed');
  dynamic get MAX_PLAYLIST_NAME => _unavailable('userplaylist.MAX_PLAYLIST_NAME');
  dynamic get MAX_PLAYLIST_DESCRIPTION => _unavailable('userplaylist.MAX_PLAYLIST_DESCRIPTION');
  dynamic getSegments(dynamic videoId, {dynamic categories, dynamic serverAddress, dynamic details}) => _unavailable('sponsorblock.getSegments');
  dynamic getSuggestions(dynamic query, {dynamic details}) => _unavailable('search.getSuggestions');
  dynamic getUserPlaylists({dynamic details}) => _unavailable('userplaylist.getUserPlaylists');
  dynamic injectDefaultPlaylistsInUserPlaylists(dynamic playlists) => _unavailable('userplaylist.injectDefaultPlaylistsInUserPlaylists');
  dynamic markNotficationRead({dynamic mainList, dynamic notification}) => _unavailable('notificationsAction.markNotficationRead');
  dynamic markVideoWatched({dynamic videoId, dynamic streamResult, dynamic errorOnMissingParam}) => _unavailable('history.markVideoWatched');
  dynamic removeHostedPlaylistFromLibrary({dynamic playlist}) => _unavailable('userplaylist.removeHostedPlaylistFromLibrary');
  dynamic search(dynamic query, {dynamic filters, dynamic details, dynamic peopleAlsoWatched, dynamic params}) => _unavailable('search.search');
  dynamic trackSkippedSegment(dynamic uuid, {dynamic serverAddress}) => _unavailable('sponsorblock.trackSkippedSegment');
  dynamic updateInfo({dynamic visitorData, dynamic playerRequestPoToken, dynamic streamingPoToken}) => _unavailable('potoken.updateInfo');
  dynamic validatePlaylistTitle(dynamic title) => _unavailable('userplaylist.validatePlaylistTitle');
}

abstract final class YoutiPie {
  static const _YoutiPieApi channel = _YoutiPieApi();
  static const _YoutiPieApi channelAction = _YoutiPieApi();
  static const _YoutiPieApi comment = _YoutiPieApi();
  static const _YoutiPieApi commentAction = _YoutiPieApi();
  static const _YoutiPieApi feed = _YoutiPieApi();
  static const _YoutiPieApi hashtag = _YoutiPieApi();
  static const _YoutiPieApi history = _YoutiPieApi();
  static const _YoutiPieApi missingInfo = _YoutiPieApi();
  static const _YoutiPieApi music = _YoutiPieApi();
  static const _YoutiPieApi notificationsAction = _YoutiPieApi();
  static const _YoutiPieApi playlist = _YoutiPieApi();
  static const _YoutiPieApi playlistAction = _YoutiPieApi();
  static const _YoutiPieApi potoken = _YoutiPieApi();
  static const _YoutiPieApi returnyoutubedislike = _YoutiPieApi();
  static const _YoutiPieApi search = _YoutiPieApi();
  static const _YoutiPieApi sponsorblock = _YoutiPieApi();
  static const _YoutiPieApi userchannel = _YoutiPieApi();
  static const _YoutiPieApi userplaylist = _YoutiPieApi();
  static const _YoutiPieApi video = _YoutiPieApi();
  static const _YoutiPieApi videoAction = _YoutiPieApi();
  static const _YoutiPieCacheBuilder cacheBuilder = _YoutiPieCacheBuilder();
  static const _YoutiPieCacheManager cacheManager = _YoutiPieCacheManager();
  static const _YoutiPieCacheManager cacheManagerSync = _YoutiPieCacheManager();
  static const _YoutiPieCipher cipher = _YoutiPieCipher();
  static final YoutiPieCookies cookies = YoutiPieCookies();

  static dynamic get activeAccountDetails => _unavailable('YoutiPie.activeAccountDetails');
  static dynamic get countryCode => _unavailable('YoutiPie.countryCode');
  static dynamic get languageCode => _unavailable('YoutiPie.languageCode');
  static dynamic get lastSessionFailureReport => _unavailable('YoutiPie.lastSessionFailureReport');
  static dynamic get lastSessionReset => _unavailable('YoutiPie.lastSessionReset');
  static dynamic get memoryCache => _unavailable('YoutiPie.memoryCache');
  static dynamic get signedInAccounts => _unavailable('YoutiPie.signedInAccounts');

  static set canExecuteOperation(dynamic callback) => _unavailable('YoutiPie.canExecuteOperation');
  static dynamic get canExecuteOperation => _unavailable('YoutiPie.canExecuteOperation');
  static set onOperationFailNoAccount(dynamic callback) => _unavailable('YoutiPie.onOperationFailNoAccount');
  static dynamic get onOperationFailNoAccount => _unavailable('YoutiPie.onOperationFailNoAccount');
  static Future<void> initialize({
    dynamic dataDirectory,
    dynamic sensitiveDataDirectory,
    dynamic sensitiveDataEncryptionKey,
    dynamic isNewSensitiveDataEncryptionKey,
    dynamic checkJSPlayer,
    dynamic checkHasConnectionCallback,
    dynamic syncItemsCompleter,
    dynamic accountCompleter,
  }) => _unavailable('YoutiPie.initialize');
  static Future<void> dispose() => _unavailable('YoutiPie.dispose');
  static Future<void> resetSession() => _unavailable('YoutiPie.resetSession');
  static void setDefaultClients(dynamic clients) => _unavailable('YoutiPie.setDefaultClients');
  static void setLogs(dynamic logs) => _unavailable('YoutiPie.setLogs');
  static Future<dynamic> getActiveAccountChannelIsolate(dynamic sensitiveDataDirectory, {dynamic encryptionKey}) => _unavailable('YoutiPie.getActiveAccountChannelIsolate');
}
