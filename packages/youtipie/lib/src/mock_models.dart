// Compile-time data types for the offline fork. Remote operations are unavailable.
typedef UnsupportedRemoteData = dynamic;
typedef AccountManager = dynamic;
typedef Caption = dynamic;
typedef ChannelAboutLink = dynamic;
typedef ChannelHomeSection = dynamic;
typedef ChannelInfo = dynamic;
typedef ChannelPageAbout = dynamic;
typedef ChannelPageResult = dynamic;

enum ChannelTab { videos }

extension ChannelTabTitle on ChannelTab {
  String get title => name;
}

typedef ChannelTabResult = dynamic;
typedef ChannelUserResult = dynamic;
typedef CodecInfo = dynamic;
typedef CommentInfoItem = dynamic;
typedef CommentInfoItemBase = dynamic;
typedef CommentNotificationResult = dynamic;
typedef CommentReplyResult = dynamic;
typedef CommentResult = dynamic;
typedef FeedResult = dynamic;
typedef HashtagResult = dynamic;
typedef HistoryChunk = dynamic;
typedef HistoryResult = dynamic;
typedef HlsVariant = dynamic;
typedef ItemsSort = dynamic;

class MissingVideoInfo {
  final dynamic videoId;
  final dynamic title;
  final dynamic channelId;
  final dynamic channelName;
  final dynamic description;
  final dynamic date;
  final dynamic durSeconds;
  final dynamic videoPage;
  final List<dynamic> sources;
  final dynamic subsource;
  const MissingVideoInfo({this.videoId, this.title, this.channelId, this.channelName, this.description, this.date, this.durSeconds, this.videoPage, this.sources = const [], this.subsource});
  static MissingVideoInfo fromMap(dynamic map) =>
      map is Map ? MissingVideoInfo(videoId: map['videoId'], title: map['title'], channelId: map['channelId'], channelName: map['channelName']) : const MissingVideoInfo();
}

typedef MusicBrowseEndpoint = dynamic;
typedef MusicBrowseResult = dynamic;
typedef MusicChip = dynamic;
typedef MusicFormOption = dynamic;
typedef MusicSearchChip = dynamic;
typedef MusicSearchResult = dynamic;
typedef MusicShelf = dynamic;
typedef MusicTopResult = dynamic;
typedef NotificationMenuAction = dynamic;
typedef NotificationResult = dynamic;
typedef PlaylistIdUtils = dynamic;
typedef PlaylistMixResult = dynamic;
typedef PlaylistResult = dynamic;
typedef PlaylistResultBase = dynamic;
typedef PlaylistUserResult = dynamic;
typedef RelatedVideosResult = dynamic;
typedef SearchFilters = dynamic;
typedef SearchResult = dynamic;
typedef SearchSuggestionInfo = dynamic;
typedef SponsorblockSegment = dynamic;
typedef SponsorblockSegmentsResult = dynamic;
typedef StreamBase = dynamic;
typedef StreamSegments = dynamic;
typedef Thumbnail = dynamic;
typedef UrlUtils = dynamic;
typedef UserChannelInfo = dynamic;
typedef UserChannelsAllVideosResult = dynamic;
typedef VideoHeatMap = dynamic;
typedef VideoInfo = dynamic;
typedef VideoPlayability = dynamic;
typedef VideoResult = dynamic;
typedef YoutipieDescription = dynamic;
typedef YtFeedBase = dynamic;

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
  bool get requiresAccount => switch (this) {
    YoutiPieOperation.fetchFeed ||
    YoutiPieOperation.fetchHistory ||
    YoutiPieOperation.fetchNotifications ||
    YoutiPieOperation.fetchNotificationsNext ||
    YoutiPieOperation.fetchUserChannels ||
    YoutiPieOperation.fetchUserChannelsNext ||
    YoutiPieOperation.fetchUserPlaylists ||
    YoutiPieOperation.fetchUserPlaylistsNext => true,
    _ => false,
  };
}

// Additional model names referenced by the app while remote features are disabled.
typedef AccountCookiesValidity = dynamic;
typedef SponsorBlockSegment = dynamic;
typedef SponsorBlockSegmentsResult = dynamic;
typedef StreamSegment = dynamic;
typedef StylesWrapper = dynamic;
typedef VideoPlayabilty = dynamic;

class YoutiPieChannelInfo extends ChannelInfoItem {
  const YoutiPieChannelInfo({
    super.id,
    super.handler,
    super.title,
    super.thumbnails,
    super.subscribersCount,
    super.subscribed,
    super.notifications,
    super.notificationParameters,
    super.channelEngagement,
    super.banners,
    super.tvbanners,
    super.mobileBanners,
  });
  void rebuild({dynamic newSubscribed, dynamic newNotifications, dynamic newNotificationParameters}) {}
}

typedef YoutiPieChannelPageResult = dynamic;
typedef YoutiPieCommentResult = dynamic;
typedef YoutiPieFeedResult = dynamic;
typedef YoutiPieFetchAllRes = dynamic;
typedef YoutiPieHashtagResult = dynamic;
typedef YoutiPieHistoryChunk = dynamic;
typedef YoutiPieHistoryResult = dynamic;
typedef YoutiPieItemsSort = dynamic;
typedef YoutiPieMixPlaylistResult = dynamic;
typedef YoutiPieMusicBrowseResult = dynamic;
typedef YoutiPieMusicChip = dynamic;
typedef YoutiPieMusicFormOption = dynamic;
typedef YoutiPieMusicSearchChip = dynamic;
typedef YoutiPieMusicSearchResult = dynamic;
typedef YoutiPieMusicTopResult = dynamic;
typedef YoutiPieNotificationCommentResult = dynamic;
typedef YoutiPieNotificationResult = dynamic;
typedef YoutiPiePlaylistResult = dynamic;
typedef YoutiPieSearchResult = dynamic;
typedef YoutiPieThumbnail = dynamic;
typedef YoutiPieUserChannelsAllVideosResult = dynamic;
typedef YoutiPieVideoHeatMap = dynamic;
typedef YoutiPieVideoInfo = dynamic;
typedef YoutiPieVideoPageResult = dynamic;
typedef YoutubeFeed = dynamic;

enum PlaylistPrivacy { public, unlisted, private }

enum ChannelNotifications { all, personalized, none }

enum LikeAction { addLike, removeLike, addDislike, removeDislike }

extension LikeActionExpectedStatus on LikeAction {
  LikeStatus toExpectedStatus() => this == LikeAction.addLike
      ? LikeStatus.liked
      : this == LikeAction.addDislike
      ? LikeStatus.disliked
      : LikeStatus.undefined;
}

enum NotificationMenuActionType { hide, volume }

enum YoutiPieSection { missingInfo, streamInfoItem, videoStreams }

enum YoutiPieMusicSearchType { songs, videos, albums, artists, playlists, profiles, episodes, podcasts }

enum YoutiPieMusicShelfLayout { carousel, rows, list, grid }

enum YoutiPieSearchType { all, video, channel, playlist, movie }

enum YoutiPieSearchSort { relevance, rating, date, views }

enum YoutiPieSearchUploadDate { none, lastHour, today, thisWeek, thisMonth, thisYear }

enum YoutiPieSearchMatchMode { phrase, title }

enum YoutiPieFetchAllResType { success, fail, alreadyDone, alreadyCanceled, inProgress }

enum InnertubeClients { tv, web, android, ios }

enum VideoPlayabiltyStatus { ok, unknown }

enum VideoEndScreenItemType { video, playlist, channel, unknown }

class MapSerializable {
  static const String dummyKey = '_dummy';
  static const String timestampKey = '_timestamp';
}

class ExecuteDetails {
  const ExecuteDetails();
  const ExecuteDetails.forceRequest();
  const ExecuteDetails.cache(dynamic _);
  static const kForceRequest = ExecuteDetails.forceRequest();
  factory ExecuteDetails.normal() => const ExecuteDetails();
}

class CacheDecision {
  static const cacheOnly = CacheDecision._();
  const CacheDecision._();
}

class RelatedVideosRequestParams {
  const RelatedVideosRequestParams.allowAll();
}

class PublishTime {
  final DateTime? date;
  final String? text;
  const PublishTime({this.date, this.text});
  const PublishTime.unknown() : date = null, text = null;
  static PublishTime fromMap(dynamic map) =>
      map is Map ? PublishTime(date: map['date'] is String ? DateTime.tryParse(map['date']) : null, text: map['text']?.toString()) : const PublishTime.unknown();
}

class PlaylistBasicInfo {
  final dynamic id;
  final dynamic title;
  final dynamic videosCountText;
  final dynamic videosCount;
  final dynamic viewsCount;
  final dynamic viewsCountText;
  final List<dynamic> thumbnails;
  final dynamic subtitle;
  final dynamic description;
  final dynamic isMix;
  final dynamic uploader;
  final dynamic isInLibrary;
  const PlaylistBasicInfo({
    this.id = '',
    this.title,
    this.videosCountText,
    this.videosCount,
    this.viewsCount,
    this.viewsCountText,
    this.thumbnails = const [],
    this.subtitle,
    this.description,
    this.isMix = false,
    this.uploader,
    this.isInLibrary,
  });
  static PlaylistBasicInfo fromMap(dynamic map) => map is Map
      ? PlaylistBasicInfo(id: map['id'] ?? '', title: map['title'], videosCountText: map['videosCountText'], videosCount: map['videosCount'])
      : const PlaylistBasicInfo();
  dynamic buildUrl() => _unavailable('Remote playlist URL');
  Map<String, dynamic> toMap() => {};
  dynamic getPopupMenuItems({
    dynamic queueSource,
    dynamic playlistToFetch,
    dynamic userPlaylist,
    bool displayOpenPlaylist = false,
    bool displayDownloadItem = true,
    bool displayShuffle = true,
    bool displayPlay = true,
    bool showProgressSheet = false,
    bool isInFullScreen = false,
  }) => _unavailable('Playlist actions');
}

class ChannelInfoItem {
  final dynamic id;
  final dynamic handler;
  final dynamic title;
  final List<dynamic> thumbnails;
  final dynamic subscribersCount;
  final dynamic subscribed;
  final dynamic notifications;
  final dynamic notificationParameters;
  final dynamic channelEngagement;
  final dynamic banners;
  final dynamic tvbanners;
  final dynamic mobileBanners;
  const ChannelInfoItem({
    this.id,
    this.handler,
    this.title,
    this.thumbnails = const [],
    this.subscribersCount,
    this.subscribed,
    this.notifications,
    this.notificationParameters,
    this.channelEngagement,
    this.banners,
    this.tvbanners,
    this.mobileBanners,
  });
  const ChannelInfoItem.anonymous()
    : id = '',
      handler = '',
      title = '',
      thumbnails = const [],
      subscribersCount = null,
      subscribed = null,
      notifications = null,
      notificationParameters = null,
      channelEngagement = null,
      banners = null,
      tvbanners = null,
      mobileBanners = null;
}

class StreamInfoItem {
  final dynamic id;
  final dynamic title;
  final dynamic shortDescription;
  final dynamic channel;
  final dynamic channelName;
  final dynamic channelId;
  final dynamic thumbnailGifUrl;
  final dynamic publishedFromText;
  final dynamic publishedAt;
  final dynamic indexInPlaylist;
  final dynamic durSeconds;
  final dynamic durText;
  final dynamic viewsText;
  final dynamic viewsCount;
  final dynamic percentageWatched;
  final dynamic liveThumbs;
  final dynamic isUploaderVerified;
  final dynamic badges;
  final dynamic isActuallyShortContent;
  const StreamInfoItem({
    this.id = '',
    this.title = '',
    this.shortDescription,
    this.channel,
    this.channelName,
    this.channelId,
    this.thumbnailGifUrl,
    this.publishedFromText,
    this.publishedAt,
    this.indexInPlaylist,
    this.durSeconds,
    this.durText,
    this.viewsText,
    this.viewsCount,
    this.percentageWatched,
    this.liveThumbs,
    this.isUploaderVerified,
    this.badges,
    this.isActuallyShortContent,
  });
  dynamic get availableDescription => shortDescription;
  dynamic buildUrl() => _unavailable('Remote video URL');
  Map<String, dynamic> toMap() => {};
  static StreamInfoItem fromMap(dynamic map) => map is Map ? StreamInfoItem(id: map['id'] ?? '', title: map['title'] ?? '') : const StreamInfoItem();
}

class YoutiPieChannelTabResult extends YoutiPieListWrapper<dynamic> with YoutiPieListSorterMixin<dynamic> {
  final dynamic channelId;
  const YoutiPieChannelTabResult({super.items = const [], super.continuation, this.channelId});
}

class StreamInfoItemShort {
  final dynamic id;
  final dynamic title;
  final dynamic viewsText;
  final dynamic viewsCount;
  final dynamic liveThumbs;
  const StreamInfoItemShort({this.id = '', this.title = '', this.viewsText, this.viewsCount, this.liveThumbs});
}

class StreamInfoItemNotification {
  final dynamic id;
  final dynamic title;
  final dynamic isRead;
  final dynamic menuActions;
  final dynamic isComment;
  final dynamic shortText;
  final dynamic publishedAt;
  final dynamic possibleInfo;
  final dynamic thumbs;
  final dynamic uploaderthumbs;
  final dynamic isCommentReply;
  final dynamic notificationId;
  final dynamic linkedCommentId;
  final dynamic linkedReply;
  final dynamic linkedMainCommentId;
  const StreamInfoItemNotification({
    this.id = '',
    this.title = '',
    this.isRead,
    this.menuActions,
    this.isComment,
    this.shortText,
    this.publishedAt,
    this.possibleInfo,
    this.thumbs,
    this.uploaderthumbs,
    this.isCommentReply,
    this.notificationId,
    this.linkedCommentId,
    this.linkedReply,
    this.linkedMainCommentId,
  });
}

class VideoStreamInfo {
  final dynamic id;
  final dynamic title;
  final dynamic durSeconds;
  final dynamic keywords;
  final dynamic channelName;
  final dynamic channelId;
  final dynamic description;
  final dynamic thumbnails;
  final dynamic viewsCount;
  final dynamic isPrivate;
  final dynamic isUnlisted;
  final dynamic isLiveNow;
  final dynamic isLiveContent;
  final dynamic category;
  final dynamic publishDate;
  final dynamic uploadDate;
  const VideoStreamInfo({
    this.id = '',
    this.title = '',
    this.durSeconds,
    this.keywords,
    this.channelName,
    this.channelId,
    this.description,
    this.thumbnails,
    this.viewsCount,
    this.isPrivate,
    this.isUnlisted,
    this.isLiveNow,
    this.isLiveContent,
    this.category,
    this.publishDate,
    this.uploadDate,
  });
  dynamic get availableDescription => description;
  dynamic get publishedAt => publishDate;
  Map<String, dynamic> toMap() => {};
  static VideoStreamInfo merge(String id, VideoStreamInfo? oldInfo, VideoStreamInfo newInfo) => newInfo;
  static VideoStreamInfo fromMap(dynamic map) => map is Map ? VideoStreamInfo(id: map['id'] ?? '', title: map['title'] ?? '') : const VideoStreamInfo();
}

class AudioTrack {
  final String? id;
  final String? displayName;
  final String? label;
  final String? langCode;
  final bool? isDefault;
  const AudioTrack({this.id, this.displayName, this.label, this.langCode, this.isDefault});
}

class AudioStream {
  final dynamic id;
  final dynamic url;
  final dynamic duration;
  final dynamic bitrate;
  final dynamic codecInfo;
  final AudioTrack? audioTrack;
  final dynamic itag;
  final dynamic isWebm;
  final dynamic sizeInBytes;
  final dynamic sampleRate;
  final dynamic channelCount;
  const AudioStream({this.id, this.url, this.duration, this.bitrate, this.codecInfo, this.audioTrack, this.itag, this.isWebm = false, this.sizeInBytes = 0, this.sampleRate, this.channelCount});
  static AudioStream fromMap(dynamic map) => const AudioStream();
  dynamic bitrateText() => _unavailable('Remote audio stream');
  dynamic buildUrl() => _unavailable('Remote audio stream');
  Map<String, dynamic> toMap() => {};
}

class VideoStream {
  final dynamic id;
  final dynamic url;
  final dynamic duration;
  final dynamic bitrate;
  final dynamic codecInfo;
  final dynamic width;
  final dynamic height;
  final dynamic fps;
  final dynamic itag;
  final dynamic qualityLabel;
  final bool isSelected;
  final dynamic displayName;
  final dynamic label;
  final dynamic mimeType;
  final dynamic sampleRate;
  final dynamic channelCount;
  final dynamic isWebm;
  final dynamic sizeInBytes;
  const VideoStream({
    this.id,
    this.url,
    this.duration,
    this.bitrate,
    this.codecInfo,
    this.width,
    this.height,
    this.fps,
    this.itag,
    this.qualityLabel,
    this.isSelected = false,
    this.displayName,
    this.label,
    this.mimeType,
    this.sampleRate,
    this.channelCount,
    this.isWebm = false,
    this.sizeInBytes = 0,
  });
  static VideoStream fromMap(dynamic map) => const VideoStream();
  dynamic bitrateText() => _unavailable('Remote video stream');
  dynamic buildUrl() => _unavailable('Remote video stream');
  Map<String, dynamic> toMap() => {};
}

class VideoStreamsResult {
  final dynamic videoId;
  final VideoStreamInfo? info;
  final List<AudioStream> audioStreams;
  final List<VideoStream> videoStreams;
  final dynamic captions;
  final dynamic playability;
  final dynamic mixedStreams;
  final dynamic statsPlaybackUrl;
  final dynamic statsWatchtimeUrl;
  final dynamic overlay;
  final dynamic endscreens;
  final dynamic loudnessDBData;
  final Map<String, AudioStream>? audioStreamsOrganizedByLanguage;
  const VideoStreamsResult({
    this.videoId,
    this.info,
    this.audioStreams = const [],
    this.videoStreams = const [],
    this.captions = const [],
    this.playability,
    this.mixedStreams = const [],
    this.statsPlaybackUrl,
    this.statsWatchtimeUrl,
    this.overlay,
    this.endscreens = const [],
    this.loudnessDBData,
    this.audioStreamsOrganizedByLanguage,
  });
  bool hasExpired() => false;
  Map<String, dynamic> toMap() => {};
}

class CacheDetails<T> {
  final dynamic section;
  final dynamic key;
  final dynamic accountId;
  const CacheDetails({this.section, this.key, this.accountId});
  Future<T?> read() async => _unavailable('Remote cache');
  T? readSync() => _unavailable('Remote cache');
}

class CacheDetailsBase {
  final dynamic section;
  final dynamic key;
  final dynamic Function()? accountId;
  const CacheDetailsBase(this.section, this.key, this.accountId);
  Future<void> close() async => _unavailable('Remote cache');
  dynamic loadEverythingSync(dynamic callback) => _unavailable('Remote cache');
  dynamic loadEverythingExtractedSync(dynamic paths, dynamic callback) => _unavailable('Remote cache');
  dynamic readAllMapsSync(dynamic keys) => _unavailable('Remote cache');
}

class YoutiPieListWrapper<T> {
  final List<T> items;
  final dynamic continuation;
  const YoutiPieListWrapper({this.items = const [], this.continuation});
  bool get canFetchNext => false;
  Future<bool> fetchNext() async => _unavailable('Remote list pagination');
  dynamic fetchAll({dynamic onProgress, ExecuteDetails? details}) => _unavailable('Remote list pagination');
}

class PlaylistInfoItemUser extends PlaylistBasicInfo {
  final dynamic handler;
  final dynamic privacy;
  final List<String>? infoTexts;
  const PlaylistInfoItemUser({
    super.id,
    super.title,
    this.handler,
    super.description,
    super.thumbnails,
    this.privacy,
    super.videosCount,
    super.videosCountText,
    super.isMix,
    this.infoTexts,
  });
}

class YoutiPieUserPlaylistsResult extends YoutiPieListWrapper<PlaylistInfoItemUser> {
  @override
  final List<PlaylistInfoItemUser> items;
  const YoutiPieUserPlaylistsResult({List<PlaylistInfoItemUser> items = const [], dynamic continuation}) : items = items, super(items: items, continuation: continuation);
}

class YoutiPieUserChannelsResult extends YoutiPieListWrapper<YoutiPieChannelInfo?> {
  @override
  final List<YoutiPieChannelInfo?> items;
  const YoutiPieUserChannelsResult({List<YoutiPieChannelInfo?> items = const [], dynamic continuation}) : items = items, super(items: items, continuation: continuation);
}

mixin YoutiPieListSorterMixin<T> {
  dynamic get itemsSort => const [];
  dynamic get customSort => null;
  Future<bool> fetchWithNewSort({dynamic sort, ExecuteDetails? details}) async => _unavailable('Remote list sorting');
}

class YoutiPiePlaylistResultBase extends YoutiPieListWrapper<StreamInfoItem> {
  final PlaylistBasicInfo basicInfo;
  final dynamic cacheKey;
  const YoutiPiePlaylistResultBase({required this.basicInfo, required List<StreamInfoItem> items, this.cacheKey, dynamic continuation}) : super(items: items, continuation: continuation);
  PlaylistBasicInfo get info => basicInfo;
  dynamic get playlistId => basicInfo.id;
  @override
  bool get canFetchNext => continuation != null;
  Future<bool> fetchNext() async => fetchNextFunction(null);
  @override
  dynamic fetchAll({dynamic onProgress, ExecuteDetails? details}) => _unavailable('Remote playlist pagination');
  Future<bool> fetchNextFunction(ExecuteDetails? details) async => _unavailable('Remote playlist pagination');
  Map<String, dynamic> toMapRaw() => _unavailable('Remote playlist serialization');
}

class YoutiPieCommentReplyResult extends YoutiPieListWrapper<dynamic> {
  final dynamic commentId;
  final dynamic cacheKey;
  const YoutiPieCommentReplyResult({this.commentId, this.cacheKey, dynamic items = const [], dynamic continuation}) : super(items: items, continuation: continuation);
  int get length => (items as List).length;
  @override
  bool get canFetchNext => continuation != null;
  Future<bool> fetchNext() async => _unavailable('Remote comment pagination');
  dynamic transferLocalItemsTo(dynamic other) => _unavailable('Remote comment pagination');
}

class PlaylistForVideoItem {
  final dynamic playlistId;
  final dynamic playlistTitle;
  final dynamic privacy;
  final bool containsVideo;
  const PlaylistForVideoItem({this.playlistId, this.playlistTitle, this.privacy, this.containsVideo = false});
}

class YoutiPiePlaylistEditCallbacks {
  final dynamic Function() oldPlaylist;
  final dynamic Function(dynamic newPlaylist) newPlaylistCallback;
  const YoutiPiePlaylistEditCallbacks({required this.oldPlaylist, required this.newPlaylistCallback});
}

class LoginPageConfiguration {
  final dynamic header;
  final dynamic title;
  final dynamic description;
  final dynamic popPage;
  final dynamic pushPage;
  const LoginPageConfiguration({this.header, this.title, this.description, this.popPage, this.pushPage});
}

class YoutiPieSearchFilters {
  final YoutiPieSearchType type;
  final YoutiPieSearchSort sort;
  final YoutiPieSearchUploadDate uploadDate;
  final YoutiPieMusicSearchType? musicType;
  final YoutiPieSearchMatchMode? matchMode;
  final List<String> excluded;
  final dynamic after;
  final dynamic before;
  final bool clearAfter;
  final bool clearBefore;
  final List<String> exclude;
  const YoutiPieSearchFilters({
    this.type = YoutiPieSearchType.all,
    this.sort = YoutiPieSearchSort.relevance,
    this.uploadDate = YoutiPieSearchUploadDate.none,
    this.musicType,
    this.matchMode,
    this.excluded = const [],
    this.after,
    this.before,
    this.clearAfter = false,
    this.clearBefore = false,
    this.exclude = const [],
  });
  static const defaults = YoutiPieSearchFilters();
  bool get hasDateRange => after != null || before != null;
  bool get isDefault =>
      type == YoutiPieSearchType.all &&
      sort == YoutiPieSearchSort.relevance &&
      uploadDate == YoutiPieSearchUploadDate.none &&
      musicType == null &&
      matchMode == null &&
      excluded.isEmpty &&
      after == null &&
      before == null;
  static YoutiPieSearchParsedDateOperators? parseDateOperators(String _) => null;
  static String stripDateOperators(String text) => text;
  YoutiPieSearchFilters copyWith({
    YoutiPieSearchType? type,
    YoutiPieSearchSort? sort,
    YoutiPieSearchUploadDate? uploadDate,
    YoutiPieMusicSearchType? musicType,
    YoutiPieSearchMatchMode? matchMode,
    List<String>? excluded,
    dynamic after,
    dynamic before,
    bool? clearAfter,
    bool? clearBefore,
    List<String>? exclude,
  }) => YoutiPieSearchFilters(
    type: type ?? this.type,
    sort: sort ?? this.sort,
    uploadDate: uploadDate ?? this.uploadDate,
    musicType: musicType ?? this.musicType,
    matchMode: matchMode ?? this.matchMode,
    excluded: excluded ?? this.excluded,
    after: after ?? this.after,
    before: before ?? this.before,
    clearAfter: clearAfter ?? this.clearAfter,
    clearBefore: clearBefore ?? this.clearBefore,
    exclude: exclude ?? this.exclude,
  );
}

class YoutiPieSearchParsedDateOperators {
  final YoutiPieSearchDate? after;
  final YoutiPieSearchDate? before;
  const YoutiPieSearchParsedDateOperators({this.after, this.before});
}

class YoutiPieSearchDate {
  final DateTime dateTime;
  const YoutiPieSearchDate(this.dateTime);
  static YoutiPieSearchDate fromDateTime(DateTime dateTime) => YoutiPieSearchDate(dateTime);
  static YoutiPieSearchDate? parse(String text) {
    final date = DateTime.tryParse(text);
    return date == null ? null : YoutiPieSearchDate(date);
  }

  DateTime toDateTime() => dateTime;
  DateTime toDateTimeUtc() => dateTime.toUtc();
  @override
  String toString() => dateTime.toIso8601String();
}

class YoutiPieSearchOperators {
  final String remainingText;
  final List<String> phrases;
  final List<String> titlePhrases;
  final List<String> excluded;
  final YoutiPieSearchMatchMode? matchMode;
  const YoutiPieSearchOperators({this.remainingText = '', this.phrases = const [], this.titlePhrases = const [], this.excluded = const [], this.matchMode});
  static String buildQuery(String query, {dynamic matchMode, Iterable<String> excluded = const []}) => query;
  static YoutiPieSearchOperators? parse(String _) => null;
}

class YoutiPieMusicBrowseEndpoint {
  final String browseId;
  const YoutiPieMusicBrowseEndpoint(this.browseId);
  static const home = YoutiPieMusicBrowseEndpoint('home');
  static const explore = YoutiPieMusicBrowseEndpoint('explore');
  static const charts = YoutiPieMusicBrowseEndpoint('charts');
  static const moodsAndGenres = YoutiPieMusicBrowseEndpoint('moodsAndGenres');
  static const newReleases = YoutiPieMusicBrowseEndpoint('newReleases');
  String? extractPlaylistId() => null;
  YoutiPieMusicBrowseEndpoint withFormValues(dynamic values) => this;
}

class YoutiPieMusicShelf {
  final YoutiPieMusicShelfLayout layout;
  final dynamic items;
  final bool hasHeader;
  final dynamic title;
  final dynamic strapline;
  final dynamic moreEndpoint;
  final int rowsPerColumn;
  final dynamic thumbnails;
  const YoutiPieMusicShelf({
    this.layout = YoutiPieMusicShelfLayout.list,
    this.items = const [],
    this.hasHeader = false,
    this.title,
    this.strapline,
    this.moreEndpoint,
    this.rowsPerColumn = 1,
    this.thumbnails,
  });
}

class YoutiPieRelatedVideosResult extends YoutiPieListWrapper<dynamic> {
  final dynamic cacheKey;
  final dynamic videoId;
  final dynamic isPersonalized;
  final dynamic shortsSection;
  const YoutiPieRelatedVideosResult({this.cacheKey, dynamic items = const [], dynamic continuation, this.videoId, this.isPersonalized, this.shortsSection})
    : super(items: items, continuation: continuation);
  @override
  bool get canFetchNext => continuation != null;
  @override
  Future<bool> fetchNext() async => _unavailable('Remote related-video pagination');
}

class HlsMasterPlaylist {
  const HlsMasterPlaylist();
}

class YoutiAccountManager {
  static Future<dynamic> signIn({required dynamic pageConfig, required dynamic onProgress, required bool forceSignIn}) async => _unavailable('Account sign-in');
}

class EndScreenDisplay {
  final double aspectRatio;
  final dynamic left;
  final dynamic top;
  final dynamic width;
  const EndScreenDisplay({this.aspectRatio = 1, this.left = 0, this.top = 0, this.width = 0});
}

sealed class EndScreenItemBase {
  final VideoEndScreenItemType type;
  final EndScreenDisplay display;
  final dynamic startMs;
  final dynamic endMs;
  final dynamic thumbnails;
  const EndScreenItemBase({this.type = VideoEndScreenItemType.unknown, this.display = const EndScreenDisplay(), this.startMs, this.endMs, this.thumbnails});
}

final class EndScreenItemVideo extends EndScreenItemBase {
  final dynamic videoId;
  final dynamic title;
  final dynamic viewsCount;
  final dynamic viewsCountText;
  const EndScreenItemVideo({
    this.videoId,
    this.title,
    this.viewsCount,
    this.viewsCountText,
    super.type = VideoEndScreenItemType.video,
    super.display,
    super.startMs,
    super.endMs,
    super.thumbnails,
  });
}

final class EndScreenItemChannel extends EndScreenItemBase {
  final dynamic channelId;
  final dynamic title;
  const EndScreenItemChannel({this.channelId, this.title, super.type = VideoEndScreenItemType.channel, super.display});
}

final class EndScreenItemPlaylist extends EndScreenItemBase {
  final PlaylistBasicInfo basicInfo;
  const EndScreenItemPlaylist({required this.basicInfo, super.type = VideoEndScreenItemType.playlist, super.display});
}

class MusicAlbumInfoItem {
  final dynamic id;
  final dynamic title;
  final dynamic subtitle;
  final List<dynamic> thumbnails;
  final dynamic artists;
  const MusicAlbumInfoItem({this.id, this.title, this.subtitle, this.thumbnails = const [], this.artists});
}

class MusicNavigationItem {
  final dynamic id;
  final dynamic title;
  final dynamic subtitle;
  final dynamic color;
  final dynamic endpoint;
  const MusicNavigationItem({this.id, this.title, this.subtitle, this.color, this.endpoint});
}

class PlaylistInfoItem extends PlaylistBasicInfo {
  final List<dynamic> initialVideos;
  const PlaylistInfoItem({
    super.id = '',
    super.title,
    super.videosCountText,
    super.videosCount,
    super.thumbnails = const [],
    super.subtitle,
    super.isMix = false,
    super.uploader,
    this.initialVideos = const [],
  });
  static bool isMixPlaylist(String id) => id.startsWith('RD');
}

class YoutiPieChannelHomeSection {
  final dynamic title;
  final dynamic thumbnails;
  final dynamic items;
  final dynamic playlistId;
  const YoutiPieChannelHomeSection({this.title, this.thumbnails = const [], this.items = const [], this.playlistId});
}

abstract final class YTPlaylistIdUtils {
  static bool isUserCreated(String? id) => id != null && id.startsWith('PL');
}

abstract final class YoutiPieVideoThumbnail {
  static List<String> mix(String id) => ['https://i.ytimg.com/vi/$id/hqdefault.jpg'];
  static List<String> mixLow(String id) => ['https://i.ytimg.com/vi/$id/default.jpg'];
}

extension PickRemoteListItem<T> on List<T> {
  T? pick() => isEmpty ? null : first;
}

extension YoutiPieVideoStreamsListUtils on List<VideoStream> {
  List<VideoStream> withoutWebmIfNeccessaryOrExperimentalCodecs({bool allowExperimentalCodecs = false}) => this;
}

extension YoutiPieNumberFormatting on num {
  String formatDecimalShort([bool expanded = false]) => toString();
}

extension InnertubeClientConfiguration on InnertubeClients {
  dynamic get configuration => const _InnertubeConfiguration();
}

class _InnertubeConfiguration {
  const _InnertubeConfiguration();
  bool get requireJSPlayer => false;
}

abstract final class YTUrlUtils {
  static String buildVideoUrl(String id, {int? timestampSeconds}) => 'https://www.youtube.com/watch?v=$id${timestampSeconds == null ? '' : '&t=$timestampSeconds'}';
  static String buildChannelUrl(String id) => 'https://www.youtube.com/channel/$id';
  static String buildPlaylistUrl(String id) => 'https://www.youtube.com/playlist?list=$id';
}

extension YoutiPieStringUtils on String {
  bool get isDummyVideoId => startsWith('dummy_');
  bool isYTTitleFaulty() => trim().isEmpty;
}

Never _unavailable(String operation) => throw UnsupportedError('$operation is unavailable in this offline build.');
