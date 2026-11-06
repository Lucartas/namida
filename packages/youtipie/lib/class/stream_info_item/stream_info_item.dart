import 'dart:async';

import 'package:flutter/material.dart' show Color;
import 'package:nampack/reactive/reactive.dart' show Rxn;
import 'package:youtipie/class/music/music_browse_endpoint.dart' show YoutiPieMusicBrowseEndpoint;
import 'package:youtipie/class/publish_time.dart' show PublishTime;
import 'package:youtipie/class/thumbnail.dart' show YoutiPieThumbnail;
import 'package:youtipie/class/youtipie_feed/channel_info_item.dart' show ChannelInfoItem;
import 'package:youtipie/class/youtipie_feed/playlist_basic_info.dart' show PlaylistBasicInfo, YoutiPieHostedPlaylistParams;
import 'package:youtipie/class/youtipie_feed/playlist_info_item_user.dart' show PlaylistInfoItemUser;
import 'package:youtipie/class/result_wrapper/playlist_result_base.dart' show YoutiPiePlaylistResultBase;
import 'package:youtipie/core/enum.dart' show PlaylistPrivacy;
import 'package:youtipie/class/youtipie_feed/yt_feed_base.dart' show YoutubeFeed;
import 'package:youtipie/src/unavailable.dart';

class StreamInfoItem extends YoutubeFeed implements PlaylistBasicInfo {
  final String id;
  final String title;
  final String? shortDescription;
  final ChannelInfoItem? channel;
  final String? channelName;
  final String? channelId;
  final List<YoutiPieThumbnail> thumbnails;
  final String subtitle;
  final bool isMix;
  final bool isShortContent;
  final bool isMixPlaylist;
  final List<YoutubeFeed> initialVideos;
  final String? thumbnailGifUrl;
  final String? publishedFromText;
  final PublishTime publishedAt;
  final int? indexInPlaylist;
  final int? durSeconds;
  final String? durText;
  final String? viewsText;
  final int? viewsCount;
  final double? percentageWatched;
  final List<YoutiPieThumbnail> liveThumbs;
  final bool? isUploaderVerified;
  final List<String>? badges;
  final bool? isActuallyShortContent;
  const StreamInfoItem({
    this.id = '',
    this.title = '',
    this.shortDescription,
    this.channel,
    this.channelName,
    this.channelId,
    this.thumbnails = const [],
    this.subtitle = '',
    this.isMix = false,
    this.isShortContent = false,
    this.isMixPlaylist = false,
    this.initialVideos = const [],
    this.thumbnailGifUrl,
    this.publishedFromText,
    this.publishedAt = const PublishTime.unknown(),
    this.indexInPlaylist,
    this.durSeconds,
    this.durText,
    this.viewsText,
    this.viewsCount,
    this.percentageWatched,
    this.liveThumbs = const [],
    this.isUploaderVerified,
    this.badges,
    this.isActuallyShortContent,
  });
  String? get videosCountText => unavailable('StreamInfoItem.videosCountText');
  int? get videosCount => unavailable('StreamInfoItem.videosCount');
  String? get viewsCountText => unavailable('StreamInfoItem.viewsCountText');
  String? get description => unavailable('StreamInfoItem.description');
  ChannelInfoItem? get uploader => unavailable('StreamInfoItem.uploader');
  Rxn<bool> get isInLibrary => unavailable('StreamInfoItem.isInLibrary');
  PlaylistPrivacy? get privacy => unavailable('StreamInfoItem.privacy');
  YoutiPieHostedPlaylistParams get hostedParams => unavailable('StreamInfoItem.hostedParams');
  List<YoutubeFeed> get items => unavailable('StreamInfoItem.items');
  String? get playlistId => unavailable('StreamInfoItem.playlistId');
  YoutiPieMusicBrowseEndpoint get endpoint => unavailable('StreamInfoItem.endpoint');
  String? get cacheKey => unavailable('StreamInfoItem.cacheKey');
  Color? get color => unavailable('StreamInfoItem.color');
  List<ChannelInfoItem> get artists => unavailable('StreamInfoItem.artists');
  FutureOr<List<T>> getPopupMenuItems<T>({
    Object? queueSource,
    YoutiPiePlaylistResultBase? playlistToFetch,
    PlaylistInfoItemUser? userPlaylist,
    bool displayOpenPlaylist = false,
    bool displayDownloadItem = true,
    bool displayShuffle = true,
    bool displayPlay = true,
    bool showProgressSheet = false,
    bool isInFullScreen = false,
  }) => unavailable('StreamInfoItem.getPopupMenuItems');
  String? get availableDescription => unavailable('StreamInfoItem.availableDescription');
  String buildUrl() => unavailable('Remote video URL');
  Map<String, dynamic> toMap() => unavailable('StreamInfoItem.toMap');
  static StreamInfoItem fromMap(Map<String, dynamic> map) => unavailable('StreamInfoItem.fromMap');
}
