import 'package:youtipie/src/unavailable.dart';

enum LikeStatus { liked, disliked, undefined, unknown }

enum CommentsSortType { top, newest }

enum YoutiPieOperation {
  addRemoveVideosPlaylist,
  addVideoToHistory,
  changeVideoLikeStatus,
  createPlaylist,
  fetchChannelTab,
  fetchFeed,
  fetchHashtag,
  fetchHistory,
  fetchMusicBrowse,
  fetchNotificationComments,
  fetchNotificationCommentsNext,
  fetchNotifications,
  fetchNotificationsNext,
  fetchUserChannels,
  fetchUserChannelsAllVideos,
  fetchUserChannelsAllVideosNext,
  fetchUserChannelsNext,
  fetchUserChannelsSort,
  fetchUserPlaylists,
  fetchUserPlaylistsNext,
  fetchUserPlaylistsSort,
  getPlaylistEditInfo,
  getPlaylistsForVideo,
  markNotificationRead,
  sendVoteReturnYoutubeDislike,
}

extension YoutiPieOperationAccount on YoutiPieOperation {
  bool get requiresAccount => unavailable('YoutiPieOperation.requiresAccount');
}

enum PlaylistPrivacy { public, unlisted, private }

enum ChannelNotifications { all, personalized, none }

enum LikeAction { addLike, removeLike, addDislike, removeDislike }

extension LikeActionExpectedStatus on LikeAction {
  LikeStatus toExpectedStatus() => unavailable('LikeAction.toExpectedStatus');
}

enum YoutiPieSection { missingInfo, streamInfoItem, videoStreams }

enum YoutiPieMusicSearchType { songs, videos, albums, artists, playlists, profiles, episodes, podcasts }

enum YoutiPieMusicShelfLayout { carousel, rows, list, grid }

enum YoutiPieSearchType { all, video, channel, playlist, movie }

enum YoutiPieSearchSort { relevance, rating, date, views }

enum YoutiPieSearchUploadDate { none, lastHour, today, thisWeek, thisMonth, thisYear }

enum YoutiPieSearchMatchMode { phrase, title }

enum YoutiPieFetchAllResType { success, fail, alreadyDone, alreadyCanceled, inProgress }

enum InnertubeClients { tv, web, android, ios }

class InnertubeClientConfig {
  final bool requireJSPlayer;

  const InnertubeClientConfig({this.requireJSPlayer = false});
}

extension InnertubeClientConfiguration on InnertubeClients {
  InnertubeClientConfig get configuration => unavailable('InnertubeClients.configuration');
}
