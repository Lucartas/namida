export 'package:youtipie/core/enum.dart' show InnertubeClients;

import 'package:youtipie/managers/account_manager.dart' show YoutiPieCookies;
import 'package:youtipie/src/unavailable.dart';

class _YoutiPieCacheBuilder {
  const _YoutiPieCacheBuilder();

  dynamic forChannel({dynamic channelId}) => unavailable('cacheBuilder.forChannel');
  dynamic forChannelAbout({dynamic channelId}) => unavailable('cacheBuilder.forChannelAbout');
  dynamic forChannelTab({dynamic channelId, dynamic tab}) => unavailable('cacheBuilder.forChannelTab');
  dynamic forCommentReplies({dynamic commentId}) => unavailable('cacheBuilder.forCommentReplies');
  dynamic forComments({dynamic videoId}) => unavailable('cacheBuilder.forComments');
  dynamic forFeedItems() => unavailable('cacheBuilder.forFeedItems');
  dynamic forHashtag({dynamic params}) => unavailable('cacheBuilder.forHashtag');
  dynamic forHistoryVideos() => unavailable('cacheBuilder.forHistoryVideos');
  dynamic forMissingInfo({dynamic videoId}) => unavailable('cacheBuilder.forMissingInfo');
  dynamic forMixPlaylistVideos({dynamic mixId, dynamic userPersonalized}) => unavailable('cacheBuilder.forMixPlaylistVideos');
  dynamic forMusicBrowse({dynamic endpoint}) => unavailable('cacheBuilder.forMusicBrowse');
  dynamic forNotificationComments({dynamic videoId, dynamic linkedCommentId}) => unavailable('cacheBuilder.forNotificationComments');
  dynamic forNotificationItems() => unavailable('cacheBuilder.forNotificationItems');
  dynamic forPlaylistVideos({dynamic playlistId}) => unavailable('cacheBuilder.forPlaylistVideos');
  dynamic forRelatedVideos({dynamic videoId, dynamic userPersonalized}) => unavailable('cacheBuilder.forRelatedVideos');
  dynamic forReturnYoutubeDislike({dynamic videoId}) => unavailable('cacheBuilder.forReturnYoutubeDislike');
  dynamic forStreamInfoItem({dynamic videoId}) => unavailable('cacheBuilder.forStreamInfoItem');
  dynamic forUserChannels() => unavailable('cacheBuilder.forUserChannels');
  dynamic forUserChannelsAllVideos() => unavailable('cacheBuilder.forUserChannelsAllVideos');
  dynamic forUserPlaylists() => unavailable('cacheBuilder.forUserPlaylists');
  dynamic forVideoPage({dynamic videoId}) => unavailable('cacheBuilder.forVideoPage');
  dynamic forVideoStreams({dynamic videoId}) => unavailable('cacheBuilder.forVideoStreams');
}

class _YoutiPieCacheManager {
  const _YoutiPieCacheManager();

  void init(dynamic directory) => unavailable('cacheManager.init');
  void closeAll() => unavailable('cacheManager.closeAll');
}

class _YoutiPieCipher {
  const _YoutiPieCipher();

  bool get isPrepared => unavailable('cipher.isPrepared');
  String? get jsPlayerVersion => unavailable('cipher.jsPlayerVersion');
  dynamic get signatureTimestamp => unavailable('cipher.signatureTimestamp');
  dynamic get didFailedToExtractJsCode => unavailable('cipher.didFailedToExtractJsCode');
  dynamic prepareJSPlayer({required String cacheDirectoryPath}) => unavailable('cipher.prepareJSPlayer');
}

class _YoutiPieApi {
  const _YoutiPieApi();

  dynamic addRemoveVideosInPlaylist({dynamic videosToAdd, dynamic videosToRemove, dynamic playlistId, dynamic mainList, dynamic onUserPlaylistUpdated}) =>
      unavailable('playlistAction.addRemoveVideosInPlaylist');
  dynamic addVideoToHistory({dynamic statsPlaybackUrl, dynamic statsWatchtimeUrl}) => unavailable('history.addVideoToHistory');
  dynamic addHostedPlaylistToLibrary({dynamic playlist}) => unavailable('userplaylist.addHostedPlaylistToLibrary');
  dynamic applyMenuAction({dynamic mainList, dynamic notification, dynamic action}) => unavailable('notificationsAction.applyMenuAction');
  dynamic browse(dynamic endpoint, {dynamic details}) => unavailable('music.browse');
  dynamic changeChannelNotificationStatus({dynamic mainChannelInfo, dynamic notifications}) => unavailable('channelAction.changeChannelNotificationStatus');
  dynamic changeLikeStatus({dynamic videoPage, dynamic engagement, dynamic action, dynamic comment, dynamic mainList}) => unavailable('changeLikeStatus');
  dynamic sendVoteAction(dynamic videoId, dynamic action) => unavailable('returnyoutubedislike.sendVoteAction');
  dynamic changeSubscribeStatus({dynamic mainChannelInfo, dynamic channelEngagement, dynamic subscribe}) => unavailable('channelAction.changeSubscribeStatus');
  dynamic createComment({dynamic mainList, dynamic createCommentParams, dynamic content, dynamic videoPage, dynamic videoId}) => unavailable('commentAction.createComment');
  dynamic createPlaylist({dynamic mainList, dynamic title, dynamic initialVideoIds, dynamic privacy}) => unavailable('userplaylist.createPlaylist');
  dynamic createReply({dynamic mainList, dynamic createReplyParams, dynamic content, dynamic mainComment, dynamic commentsList, dynamic videoPage, dynamic videoId}) =>
      unavailable('commentAction.createReply');
  dynamic deleteComment({dynamic comment, dynamic mainList, dynamic videoPage}) => unavailable('commentAction.deleteComment');
  dynamic deleteReply({dynamic reply, dynamic mainList, dynamic mainComment, dynamic commentsList, dynamic videoPage}) => unavailable('commentAction.deleteReply');
  dynamic editComment({dynamic mainList, dynamic comment, dynamic content}) => unavailable('commentAction.editComment');
  dynamic editPlaylist({dynamic mainList, dynamic playlists, dynamic playlistId, dynamic title, dynamic description, dynamic privacy, dynamic newVideosAtTop}) =>
      unavailable('userplaylist.editPlaylist');
  dynamic editReply({dynamic mainList, dynamic reply, dynamic content, dynamic videoId}) => unavailable('commentAction.editReply');
  dynamic fetchChannelAbout({dynamic channel, dynamic details}) => unavailable('channel.fetchChannelAbout');
  dynamic fetchChannelInfo({dynamic channelId, dynamic details}) => unavailable('channel.fetchChannelInfo');
  dynamic fetchChannelPage({dynamic channelId, dynamic handle, dynamic details}) => unavailable('channel.fetchChannelPage');
  dynamic fetchChannelTab({dynamic channelId, dynamic tab, dynamic sort, dynamic details}) => unavailable('channel.fetchChannelTab');
  dynamic fetchCommentReplies({dynamic mainComment, dynamic details}) => unavailable('comment.fetchCommentReplies');
  dynamic fetchComments({dynamic videoId, dynamic continuationToken, dynamic details}) => unavailable('comment.fetchComments');
  dynamic fetchDislikes(dynamic videoId) => unavailable('returnyoutubedislike.fetchDislikes');
  dynamic fetchFeed({dynamic details}) => unavailable('feed.fetchFeed');
  dynamic fetchHashtag({dynamic params, dynamic details}) => unavailable('hashtag.fetchHashtag');
  dynamic fetchHistory({dynamic details}) => unavailable('history.fetchHistory');
  dynamic fetchMissingInfo({dynamic videoId}) => unavailable('missingInfo.fetchMissingInfo');
  dynamic fetchMissingThumbnail({dynamic videoId}) => unavailable('missingInfo.fetchMissingThumbnail');
  dynamic fetchMusicVideoThumbnailToFile({dynamic id, dynamic filePath}) => unavailable('video.fetchMusicVideoThumbnailToFile');
  dynamic fetchNotificationComments({dynamic videoId, dynamic linkedCommentId, dynamic details}) => unavailable('comment.fetchNotificationComments');
  dynamic fetchNotifications({dynamic details, dynamic useNewExtractor}) => unavailable('feed.fetchNotifications');
  dynamic fetchPlaylist({dynamic playlistId, dynamic details}) => unavailable('playlist.fetchPlaylist');
  dynamic fetchRelatedVideos({dynamic videoId, dynamic userPersonalized, dynamic preferMix, dynamic relatedVideosParams, dynamic details}) =>
      unavailable('video.fetchRelatedVideos');
  dynamic fetchUserChannels({dynamic details}) => unavailable('userchannel.fetchUserChannels');
  dynamic fetchUserChannelsAllVideos({dynamic details}) => unavailable('userchannel.fetchUserChannelsAllVideos');
  dynamic fetchUserPlaylists({dynamic details}) => unavailable('userplaylist.getUserPlaylists');
  dynamic fetchVideoPage({dynamic videoId, dynamic relatedVideosParams, dynamic details}) => unavailable('video.fetchVideoPage');
  dynamic fetchVideoStreams({dynamic id, dynamic details, dynamic client}) => unavailable('video.fetchVideoStreams');
  dynamic fetchHlsMasterPlaylist(dynamic url) => unavailable('video.fetchHlsMasterPlaylist');
  dynamic getMixPlaylist({dynamic videoId, dynamic mixId, dynamic userPersonalized, dynamic includeFirstVideo, dynamic details}) => unavailable('playlist.getMixPlaylist');
  dynamic getPlaylistsForVideo({dynamic videoId, dynamic insertActiveAtTop}) => unavailable('userplaylist.getPlaylistsForVideo');
  dynamic getPlaylistEditInfo(dynamic playlistId) => unavailable('userplaylist.getPlaylistEditInfo');
  dynamic getVisitorData() => unavailable('potoken.getVisitorData');
  dynamic get hasPoToken => unavailable('potoken.hasPoToken');
  dynamic get lastRefreshed => unavailable('potoken.lastRefreshed');
  dynamic get MAX_PLAYLIST_NAME => unavailable('userplaylist.MAX_PLAYLIST_NAME');
  dynamic get MAX_PLAYLIST_DESCRIPTION => unavailable('userplaylist.MAX_PLAYLIST_DESCRIPTION');
  dynamic getSegments(dynamic videoId, {dynamic categories, dynamic serverAddress, dynamic details}) => unavailable('sponsorblock.getSegments');
  dynamic getSuggestions(dynamic query, {dynamic details}) => unavailable('search.getSuggestions');
  dynamic getUserPlaylists({dynamic details}) => unavailable('userplaylist.getUserPlaylists');
  dynamic injectDefaultPlaylistsInUserPlaylists(dynamic playlists) => unavailable('userplaylist.injectDefaultPlaylistsInUserPlaylists');
  dynamic markNotficationRead({dynamic mainList, dynamic notification}) => unavailable('notificationsAction.markNotficationRead');
  dynamic markVideoWatched({dynamic videoId, dynamic streamResult, dynamic errorOnMissingParam}) => unavailable('history.markVideoWatched');
  dynamic removeHostedPlaylistFromLibrary({dynamic playlist}) => unavailable('userplaylist.removeHostedPlaylistFromLibrary');
  dynamic search(dynamic query, {dynamic filters, dynamic details, dynamic peopleAlsoWatched, dynamic params}) => unavailable('search.search');
  dynamic trackSkippedSegment(dynamic uuid, {dynamic serverAddress}) => unavailable('sponsorblock.trackSkippedSegment');
  dynamic updateInfo({dynamic visitorData, dynamic playerRequestPoToken, dynamic streamingPoToken}) => unavailable('potoken.updateInfo');
  dynamic validatePlaylistTitle(dynamic title) => unavailable('userplaylist.validatePlaylistTitle');
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

  static dynamic get activeAccountDetails => unavailable('YoutiPie.activeAccountDetails');
  static dynamic get countryCode => unavailable('YoutiPie.countryCode');
  static dynamic get languageCode => unavailable('YoutiPie.languageCode');
  static dynamic get lastSessionFailureReport => unavailable('YoutiPie.lastSessionFailureReport');
  static dynamic get lastSessionReset => unavailable('YoutiPie.lastSessionReset');
  static dynamic get memoryCache => unavailable('YoutiPie.memoryCache');
  static dynamic get signedInAccounts => unavailable('YoutiPie.signedInAccounts');

  static set canExecuteOperation(dynamic callback) => unavailable('YoutiPie.canExecuteOperation');
  static dynamic get canExecuteOperation => unavailable('YoutiPie.canExecuteOperation');
  static set onOperationFailNoAccount(dynamic callback) => unavailable('YoutiPie.onOperationFailNoAccount');
  static dynamic get onOperationFailNoAccount => unavailable('YoutiPie.onOperationFailNoAccount');
  static Future<void> initialize({
    dynamic dataDirectory,
    dynamic sensitiveDataDirectory,
    dynamic sensitiveDataEncryptionKey,
    dynamic isNewSensitiveDataEncryptionKey,
    dynamic checkJSPlayer,
    dynamic checkHasConnectionCallback,
    dynamic syncItemsCompleter,
    dynamic accountCompleter,
  }) => unavailable('YoutiPie.initialize');
  static Future<void> dispose() => unavailable('YoutiPie.dispose');
  static Future<void> resetSession() => unavailable('YoutiPie.resetSession');
  static void setDefaultClients(dynamic clients) => unavailable('YoutiPie.setDefaultClients');
  static void setLogs(dynamic logs) => unavailable('YoutiPie.setLogs');
  static Future<dynamic> getActiveAccountChannelIsolate(dynamic sensitiveDataDirectory, {dynamic encryptionKey}) => unavailable('YoutiPie.getActiveAccountChannelIsolate');
}
