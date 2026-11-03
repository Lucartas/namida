import 'dart:async';
import 'dart:math' as math;

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart'
    show AudioPlayer, AudioTrack, AudioVideoSource, LiveWindow, PlaybackEvent, ProcessingState, TextTrack, UriSource, VideoInfoData, VideoSourceOptions;
import 'package:nampack/nampack.dart';

Never _offlineAudioUnavailable(String operation) => throw UnsupportedError(
  '$operation is unavailable in this build; local playback support is implemented in Milestone 2.',
);

enum PlayerRepeatMode { none, one, all, allShuffle, forNtimes }

enum InterruptionType { shouldPause, shouldDuck, unknown }

enum InterruptionAction { doNothing, duckAudio, pause }

enum EqualizerBandType { peak, lowShelf, highShelf, lowPass, highPass, bandPass, notch, allPass }

enum EqualizerChannel { all, left, right }

enum PlayerConfigModificationScale { none, main, alt }

extension EqualizerBandTypeProperties on EqualizerBandType {
  bool get hasGain => switch (this) {
    EqualizerBandType.peak || EqualizerBandType.lowShelf || EqualizerBandType.highShelf => true,
    _ => false,
  };
  bool get hasOrder => this == EqualizerBandType.peak;
}

class EqualizerBand {
  final int id;
  final double frequency;
  final double gain;
  final double q;
  final EqualizerBandType type;
  final EqualizerChannel channel;
  final bool enabled;
  final int order;

  const EqualizerBand({
    required this.id,
    required this.frequency,
    required this.gain,
    this.q = 1.0,
    this.type = EqualizerBandType.peak,
    this.channel = EqualizerChannel.all,
    this.enabled = true,
    this.order = 1,
  });

  static const double kMinFrequency = 10;
  static const double kMaxFrequency = 24000;
  static const double kMinGain = -24;
  static const double kMaxGain = 24;
  static const double kMinQ = 0.1;
  static const double kMaxQ = 18;
  static const double kDefaultQ = 1.0;
  static const List<int> kOrders = [1, 2, 3, 4];
  int get sectionCount => 1;
  double sectionQ(int _) => q;

  EqualizerBand copyWith({
    int? id,
    double? frequency,
    double? gain,
    double? q,
    EqualizerBandType? type,
    EqualizerChannel? channel,
    bool? enabled,
    int? order,
  }) => EqualizerBand(
    id: id ?? this.id,
    frequency: frequency ?? this.frequency,
    gain: gain ?? this.gain,
    q: q ?? this.q,
    type: type ?? this.type,
    channel: channel ?? this.channel,
    enabled: enabled ?? this.enabled,
    order: order ?? this.order,
  );
}

class ParametricEqualizer {
  final List<EqualizerBand> bands;
  final double preamp;
  final bool autoPreamp;
  final bool limiter;

  const ParametricEqualizer({
    this.bands = const [],
    this.preamp = 0,
    this.autoPreamp = false,
    this.limiter = false,
  });

  static const double kMinPreamp = -24;
  static const double kMaxPreamp = 24;
  static const ParametricEqualizer flat = ParametricEqualizer();
  static const List<double> graphic5Frequencies = [60, 230, 910, 3600, 14000];
  static const List<double> graphic10Frequencies = [31, 62, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];
  static const List<double> graphic15Frequencies = [25, 40, 63, 100, 160, 250, 400, 630, 1000, 1600, 2500, 4000, 6300, 10000, 16000];
  static const List<double> graphic31Frequencies = [
    20,
    25,
    31,
    40,
    50,
    63,
    80,
    100,
    125,
    160,
    200,
    250,
    315,
    400,
    500,
    630,
    800,
    1000,
    1250,
    1600,
    2000,
    2500,
    3150,
    4000,
    5000,
    6300,
    8000,
    10000,
    12500,
    16000,
    20000,
  ];

  factory ParametricEqualizer.fromMap(dynamic map) => flat;
  factory ParametricEqualizer.fromLegacyGains(dynamic _) => flat;
  factory ParametricEqualizer.fromEqualizerApo(String _) => flat;

  Map<String, dynamic> toMap() => {
    'bands': bands.map((b) => {'id': b.id, 'frequency': b.frequency, 'gain': b.gain, 'q': b.q, 'type': b.type.name, 'channel': b.channel.name}).toList(),
    'preamp': preamp,
    'autoPreamp': autoPreamp,
    'limiter': limiter,
  };

  String toEqualizerApo() => _offlineAudioUnavailable('Equalizer export');

  ParametricEqualizer copyWith({List<EqualizerBand>? bands, double? preamp, bool? autoPreamp, bool? limiter}) => ParametricEqualizer(
    bands: bands ?? this.bands,
    preamp: preamp ?? this.preamp,
    autoPreamp: autoPreamp ?? this.autoPreamp,
    limiter: limiter ?? this.limiter,
  );

  ParametricEqualizer withBand(EqualizerBand band) {
    final updated = [...bands];
    final index = updated.indexWhere((e) => e.id == band.id);
    if (index < 0) {
      updated.add(band);
    } else {
      updated[index] = band;
    }
    return copyWith(bands: updated);
  }

  ParametricEqualizer withoutBand(int id) => copyWith(bands: bands.where((b) => b.id != id).toList());
  int getNextBandId() => bands.isEmpty ? 0 : bands.map((e) => e.id).reduce(math.max) + 1;
  bool hasChannelSpecificBands() => bands.any((b) => b.channel != EqualizerChannel.all);
  List<EqualizerBand> getActiveBands() => bands.where((b) => b.gain != 0).toList();
  double computeEffectivePreamp() => preamp;
  double responseDb(double _, {EqualizerChannel channel = EqualizerChannel.all}) => 0;
  List<double> responseCurve(List<double> frequencies, {EqualizerChannel channel = EqualizerChannel.all}) => List.filled(frequencies.length, 0);

  static ParametricEqualizer graphic(List<double> frequencies) => ParametricEqualizer(
    bands: [for (var i = 0; i < frequencies.length; i++) EqualizerBand(id: i, frequency: frequencies[i], gain: 0)],
  );

  static List<double> logFrequencies(double minFrequency, double maxFrequency, int count) {
    if (count <= 0) return const [];
    if (count == 1) return [minFrequency];
    final minLog = math.log(minFrequency);
    final maxLog = math.log(maxFrequency);
    return [for (var i = 0; i < count; i++) math.exp(minLog + (maxLog - minLog) * i / (count - 1))];
  }
}

class EqualizerPreset {
  final String name;
  final ParametricEqualizer equalizer;

  const EqualizerPreset({required this.name, this.equalizer = ParametricEqualizer.flat});

  static const List<EqualizerPreset> allDefaults = [EqualizerPreset(name: 'Flat')];

  static EqualizerPreset? fromMap(dynamic map) =>
      map is Map ? EqualizerPreset(name: map['name']?.toString() ?? 'Preset', equalizer: ParametricEqualizer.fromMap(map['equalizer'])) : null;

  Map<String, dynamic> toMap() => {'name': name, 'equalizer': equalizer.toMap()};
  EqualizerPreset copyWith({String? name, ParametricEqualizer? equalizer}) => EqualizerPreset(name: name ?? this.name, equalizer: equalizer ?? this.equalizer);
}

class PlayerConfig {
  final bool skipSilence;
  final bool loudnessEnhancerEnabled;
  final dynamic loudnessEnhancer;
  final bool equalizerEnabled;
  final ParametricEqualizer equalizer;
  final EqualizerPreset? preset;
  final double speed;
  final double volume;
  final double pitch;

  const PlayerConfig({
    this.skipSilence = false,
    this.loudnessEnhancerEnabled = false,
    this.loudnessEnhancer,
    this.equalizerEnabled = false,
    this.equalizer = ParametricEqualizer.flat,
    this.preset,
    this.speed = 1,
    this.volume = 1,
    this.pitch = 1,
  });

  static const bool isSkipSilenceSupported = false;
  static const bool isEqualizerSupported = false;
  static const bool isLoudnessEnhancerSupported = false;

  factory PlayerConfig.fromMap(dynamic _) => const PlayerConfig();
  Map<String, dynamic> toMap() => {
    'skipSilence': skipSilence,
    'loudnessEnhancerEnabled': loudnessEnhancerEnabled,
    'equalizerEnabled': equalizerEnabled,
    'equalizer': equalizer?.toMap(),
    'preset': preset?.toMap(),
    'speed': speed,
    'volume': volume,
    'pitch': pitch,
  };

  PlayerConfigModificationScale getModificationScale() => PlayerConfigModificationScale.none;

  PlayerConfig copyWith({
    bool? skipSilence,
    bool? loudnessEnhancerEnabled,
    dynamic loudnessEnhancer,
    bool? equalizerEnabled,
    ParametricEqualizer? equalizer,
    EqualizerPreset? preset,
    double? speed,
    double? volume,
    double? pitch,
  }) => PlayerConfig(
    skipSilence: skipSilence ?? this.skipSilence,
    loudnessEnhancerEnabled: loudnessEnhancerEnabled ?? this.loudnessEnhancerEnabled,
    loudnessEnhancer: loudnessEnhancer ?? this.loudnessEnhancer,
    equalizerEnabled: equalizerEnabled ?? this.equalizerEnabled,
    equalizer: equalizer ?? this.equalizer,
    preset: preset ?? this.preset,
    speed: speed ?? this.speed,
    volume: volume ?? this.volume,
    pitch: pitch ?? this.pitch,
  );
}

class PlayerConfigOverrides {
  final bool? skipSilence;
  final bool? loudnessEnhancerEnabled;
  final double? loudnessEnhancer;
  final ParametricEqualizer? equalizer;
  final bool? equalizerEnabled;
  final double? speed;
  final double? volume;
  final double? pitch;
  final int modifiedDate;

  const PlayerConfigOverrides({
    this.skipSilence,
    this.loudnessEnhancerEnabled,
    this.loudnessEnhancer,
    this.equalizer,
    this.equalizerEnabled,
    this.speed,
    this.volume,
    this.pitch,
    this.modifiedDate = 0,
  });

  static const none = PlayerConfigOverrides();
  bool get isEmpty =>
      skipSilence == null &&
      loudnessEnhancerEnabled == null &&
      loudnessEnhancer == null &&
      equalizer == null &&
      equalizerEnabled == null &&
      speed == null &&
      volume == null &&
      pitch == null;

  static PlayerConfigOverrides fromMap(Map<String, dynamic> _) => none;
  Map<String, dynamic> toMap() => {};
  PlayerConfig resolve(PlayerConfig _) => _offlineAudioUnavailable('Per-track player configuration');
  PlayerConfigOverrides copyWith({
    bool? skipSilence,
    bool? loudnessEnhancerEnabled,
    double? loudnessEnhancer,
    ParametricEqualizer? equalizer,
    bool? equalizerEnabled,
    double? speed,
    double? volume,
    double? pitch,
    int? modifiedDate,
  }) => PlayerConfigOverrides(
    skipSilence: skipSilence ?? this.skipSilence,
    loudnessEnhancerEnabled: loudnessEnhancerEnabled ?? this.loudnessEnhancerEnabled,
    equalizer: equalizer ?? this.equalizer,
    equalizerEnabled: equalizerEnabled ?? this.equalizerEnabled,
    speed: speed ?? this.speed,
    volume: volume ?? this.volume,
    pitch: pitch ?? this.pitch,
    loudnessEnhancer: loudnessEnhancer ?? this.loudnessEnhancer,
    modifiedDate: modifiedDate ?? this.modifiedDate,
  );
  PlayerConfigOverrides copyWithEqualizer(ParametricEqualizer? value, [EqualizerPreset? _]) => copyWith(equalizer: value);
  PlayerConfigOverrides clear({bool volume = false, bool speed = false, bool pitch = false, bool loudnessEnhancer = false}) => PlayerConfigOverrides(
    skipSilence: skipSilence,
    loudnessEnhancerEnabled: loudnessEnhancerEnabled,
    loudnessEnhancer: loudnessEnhancer ? null : this.loudnessEnhancer,
    equalizer: equalizer,
    equalizerEnabled: equalizerEnabled,
    speed: speed ? null : this.speed,
    volume: volume ? null : this.volume,
    pitch: pitch ? null : this.pitch,
    modifiedDate: modifiedDate,
  );
}

class EqualizerExtended {
  dynamic get androidAudioEffect => null;
  Future<void> apply(bool _, ParametricEqualizer? __) async => _offlineAudioUnavailable('Equalizer');
}

class LoudnessEnhancerExtended {
  dynamic get androidAudioEffect => null;
  static const double kMinGain = -20;
  static const double kMaxGain = 20;
  Future<void> setTargetGainUser(double _) async => _offlineAudioUnavailable('Loudness enhancer');
  Future<void> setTargetGainTrack(double _) async => _offlineAudioUnavailable('Loudness enhancer');
  Future<void> setEnabledUser(bool _) async => _offlineAudioUnavailable('Loudness enhancer');
  dynamic get targetGainTrack => _offlineAudioUnavailable('Loudness enhancer');
  dynamic refreshEnabled() => _offlineAudioUnavailable('Loudness enhancer');
  dynamic getActualGainFromUser(bool _, double __) => _offlineAudioUnavailable('Loudness enhancer');
}

class SleepTimerConfig {
  final bool enableSleepAfterItems;
  final int sleepAfterItems;
  final int sleepAfterMin;
  final bool enableSleepAfterMins;

  const SleepTimerConfig({this.enableSleepAfterItems = false, this.sleepAfterItems = 0, this.sleepAfterMin = 0, this.enableSleepAfterMins = false});
}

class BeatGrid {
  final double bpm;
  final double beatOffsetMS;
  const BeatGrid({required this.bpm, required this.beatOffsetMS});
}

class ItemTiming {
  final int audibleStartMS;
  final int audibleEndMS;
  final int? fadeOutStartMS;
  const ItemTiming({required this.audibleStartMS, required this.audibleEndMS, this.fadeOutStartMS});
}

class QueueShuffler<Q> {
  void shuffleRange(List<Q> items, List<int>? pairedIndices, int start, int end) {
    for (var i = end - 1; i > start; i--) {
      final j = start + math.Random().nextInt(i - start + 1);
      swap(items, pairedIndices, i, j);
    }
  }

  static void swap<Q>(List<Q> items, List<int>? pairedIndices, int a, int b) {
    final item = items[a];
    items[a] = items[b];
    items[b] = item;
    if (pairedIndices != null) {
      final paired = pairedIndices[a];
      pairedIndices[a] = pairedIndices[b];
      pairedIndices[b] = paired;
    }
  }
}

class CrossFadeCurve {
  const CrossFadeCurve.equalPower();
  double transform(double value) => value;
}

class CrossfadeTransition<Q> {
  const CrossfadeTransition();
}

class DefaultCrossfadeTransition<Q> extends CrossfadeTransition<Q> {
  const DefaultCrossfadeTransition();
}

class SmartCrossfadeTransition<Q> extends CrossfadeTransition<Q> {
  const SmartCrossfadeTransition({required dynamic timingOf});
}

class BeatMatchedCrossfadeTransition<Q> extends CrossfadeTransition<Q> {
  const BeatMatchedCrossfadeTransition({required dynamic timingOf, required dynamic gridOf});
}

class ItemPrepareConfig<T, S> {
  final S source;
  final int index;
  final Duration? initialPosition;
  final String? audioTrackId;
  final dynamic videoOptions;
  final bool keepOldVideoSource;
  final T? item;
  final bool? itemExists;

  const ItemPrepareConfig(
    this.source, {
    required this.index,
    this.initialPosition,
    this.audioTrackId,
    this.videoOptions,
    this.keepOldVideoSource = false,
    this.item,
    this.itemExists,
  });
}

abstract interface class AVPlayer {
  Stream<PlaybackEvent> get playbackEventStream;
  Stream<List<AudioTrack>?> get audioTracksStream;
  Stream<List<TextTrack>?> get textTracksStream;
  Stream<String?> get subtitleTextStream;
  Stream<VideoInfoData> get videoInfoStream;
  Stream<Duration> get bufferedPositionStream;
  Stream<ProcessingState> get processingStateStream;
  Stream<Duration> get positionStream;
  Stream<Duration?> get durationStream;
  Stream<double> get volumeStream;
  Stream<double> get speedStream;
  Stream<double> get pitchStream;
  Stream<bool> get playingStream;
  Stream<LiveWindow?> get liveWindowStream;
  int? get androidAudioSessionId;
  ProcessingState get processingState;
  Duration get bufferedPosition;
  Duration get position;
  Duration? get duration;
  double get volume;
  double get speed;
  double get pitch;
  bool get playing;
  bool get rendersSubtitlesInternally;
  bool get supportsSeamlessSpeedChange;
  UriSource? get audioSource;
  bool get isDisposed;
  bool get hasVideoOptions;
  LiveWindow? get liveWindow;
  Future<Duration?> setSource<T>(ItemPrepareConfig<T, UriSource> config);
  Future<void> setVideo(VideoSourceOptions? video);
  Future<void> setAudioTrack(String? trackId);
  Future<void> setTextTrack(String? trackId);
  Future<bool> setExternalSubtitle(String? uri);
  Future<void> play();
  Future<void> pause();
  Future<void> seek(Duration? position);
  Future<void> stop();
  Future<void> freePlayer();
  Future<void> dispose();
  Future<void> setSkipSilenceEnabled(bool enabled);
  Future<void> setEqualizer(ParametricEqualizer? equalizer);
  Future<void> setAudioOutput(String? device, {required bool bitPerfect, required bool exclusive, required bool mono});
  Future<void> setLoudnessEnhancerEnabled(bool enabled);
  Future<void> setLoudnessEnhancerGain(double gainDb);
  Future<void> setVolume(double volume);
  Future<void> setPitch(double pitch);
  Future<void> setSpeed(double speed);
  Future<bool> addMediaNext<T>(ItemPrepareConfig<T, UriSource> config);
  Future<void> removeAllMediaNext();
}

class ItemPreparedPlayerInfo<Q> {
  final ItemPrepareConfig<Q, UriSource> config;
  const ItemPreparedPlayerInfo(this.config);
}

class BasicQueue<Q> {
  final Rx<List<Q>> queueRx = Rx<List<Q>>(<Q>[]);
  List<int>? originalIndices;

  List<Q> get value => queueRx.value;
  int get length => queueRx.value.length;
  bool get isEmpty => queueRx.value.isEmpty;

  void replace(List<Q> items, {List<int>? indices}) {
    queueRx.value = items;
    originalIndices = indices;
  }
}

class CustomAudioPlayer implements AVPlayer {
  final AudioPlayer audioPlayer;
  CustomAudioPlayer(this.audioPlayer);

  Duration get position => audioPlayer.position;
  Duration? get duration => audioPlayer.duration;
  Duration get bufferedPosition => audioPlayer.bufferedPosition;
  bool get playing => audioPlayer.playing;
  ProcessingState get processingState => audioPlayer.processingState;
  double get volume => audioPlayer.volume;
  double get speed => audioPlayer.speed;
  double get pitch => audioPlayer.pitch;
  Stream<Duration> get positionStream => audioPlayer.positionStream;
  Stream<Duration?> get durationStream => audioPlayer.durationStream;
  Stream<Duration> get bufferedPositionStream => audioPlayer.bufferedPositionStream;
  Stream<bool> get playingStream => audioPlayer.playingStream;
  Stream<ProcessingState> get processingStateStream => audioPlayer.processingStateStream;
  Stream<LiveWindow?> get liveWindowStream => audioPlayer.liveWindowStream;
  Stream<PlaybackEvent> get playbackEventStream => audioPlayer.playbackEventStream;
  Stream<double> get speedStream => audioPlayer.speedStream;
  LiveWindow? get liveWindow => audioPlayer.liveWindow;

  Future<Duration?> setSource<T>(ItemPrepareConfig<T, UriSource> config) => audioPlayer.setSource(
    config.source as AudioVideoSource,
    initialPosition: config.initialPosition,
  );

  Future<void> play() => audioPlayer.play();
  Future<void> pause() => audioPlayer.pause();
  Future<void> seek(Duration? position) => audioPlayer.seek(position);
  Future<void> stop() => audioPlayer.stop();
  Future<void> setVolume(double value) => audioPlayer.setVolume(value);
  Future<void> setSpeed(double value) => audioPlayer.setSpeed(value);
  Future<void> setPitch(double value) => audioPlayer.setPitch(value);
  Future<void> setSkipSilenceEnabled(bool value) => audioPlayer.setSkipSilenceEnabled(value);
  Future<void> dispose() => audioPlayer.dispose();

  Future<void> setAudioOutput(String? _, {required bool bitPerfect, required bool exclusive, required bool mono}) async {}
  Future<void> setVideo(dynamic options) async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class BasicAudioHandler<Q> extends BaseAudioHandler {
  BasicAudioHandler();

  final playWhenReady = Rx<bool>(false);
  final isPlaying = Rx<bool>(false);
  final currentIndex = Rx<int>(-1);
  final currentItem = Rxn<Q>();
  final currentQueue = BasicQueue<Q>();
  final currentPositionMS = Rx<int>(0);
  final currentState = Rxn<ProcessingState>();
  final currentLiveWindow = Rxn<LiveWindow>();
  final audioTracks = Rxn<List<AudioTrack>>();
  final textTracks = Rxn<List<TextTrack>>();
  final subtitleText = Rxn<String>();
  final currentSpeed = Rx<double>(1.0);
  final buffered = Rx<Duration>(Duration.zero);
  final numberOfRepeats = Rx<int>(0);
  final totalListenedTimeInSec = RxMap<String, int>(<String, int>{});
  final sleepTimerConfig = Rx<SleepTimerConfig>(const SleepTimerConfig());
  final videoPlayerInfo = Rxn<VideoInfoData>();
  final equalizerExtended = EqualizerExtended();
  final loudnessEnhancerExtended = LoudnessEnhancerExtended();
  final QueueShuffler<Q> _queueShuffler = QueueShuffler<Q>();
  final List<StreamSubscription<dynamic>> _playerSubscriptions = [];
  dynamic _currentPlayer;
  CrossfadeTransition<Q> _crossfadeTransition = DefaultCrossfadeTransition<Q>();
  bool _isQueueShuffled = false;
  bool _sleepTimerAnchoredToItem = false;
  Timer? _sleepTimer;

  final _currentItemDurationRx = Rxn<Duration>();
  RxBaseCore<Duration?> get currentItemDuration => _currentItemDurationRx;
  Duration? get liveJoinPosition => null;
  double get userPlayerVolumeForItem => 1.0;
  int get seekCount => 0;
  int get lastSeekPositionMS => 0;
  int get latestInsertedIndex => -1;
  bool get isShuffleEnabled => false;
  bool get isLastItem => true;
  bool get isModifyingQueue => false;
  bool get isAutoSkipping => false;
  bool get rendersSubtitlesInternally => false;
  int? get androidSessionId => null;

  set onVideoError(void Function(Object, StackTrace)? callback) {}

  void onVolumeChangeAddListener(String key, void Function(double) callback) {}
  void onVolumeChangeRemoveListener(String key) {}
  Future<void> executeWithPausedOutput(Future<void> Function() callback) async => callback();
  Future<void> executeOnPlayers(Future<void> Function(dynamic player) callback) async => callback(currentPlayer);
  Future<void> refreshCurrentItemPlayerConfig() async {}
  void refreshRxVariables() {}
  Future<void> setVolumeWithMultiplier(double value) async {}
  Future<void> setPlayerPitch(double value) async {}
  Future<void> setPlayerSpeed(double value) async {}
  void invokeQueueModifyLock() {}
  void invokeQueueModifyLockRelease({bool isCanceled = false}) {}
  int? shuffleNextIndex() => null;
  bool isSameAsOriginalQueue(Iterable<Q> items) => false;
  bool getLoudnessEnhancerEnabledTrackValue() => false;
  bool getLoudnessEnhancerEnabledTrackValueR() => false;
  void refreshPlatformIcons() {}
  void cancelPlayErrorSkipTimer() {}
  Rx<int> get playErrorRemainingSecondsToSkip => Rx<int>(0);
  void toggleItemFavourite(Q item) {}
  bool get displayFavouriteButtonAsLikeInNotification => false;
  void refreshNotification() {}
  void refreshChapterNotificationButtons() {}
  void refreshCrossfadeTransition() {}
  int getOwnCrossfadeMS() => 0;
  void invokeQueueModifyOnModifyCancel() {}
  Future<void> resetGaplessPlaybackData() async {}
  Future<void> shuffleAllItems() async => _offlineAudioUnavailable('Queue shuffling');
  Future<void> shuffleNextItems() async => _offlineAudioUnavailable('Queue shuffling');
  int removeDuplicatesFromQueue() => _offlineAudioUnavailable('Queue cleanup');
  Future<void> setAudioOnlyPlayback(bool audioOnly) async {}
  Future<void> tryAddingMixPlaylist(String videoId) async {}
  Future<void> tryGenerateWaveform(covariant Object? video) async {}
  Future<void> onItemPlayYoutubeIDSetQuality({
    required covariant Object? mainStreams,
    required covariant Object? stream,
    required covariant Object? cachedFile,
    required bool useCache,
    required String videoId,
    required covariant Object? videoItem,
  }) async {}
  Future<void> onItemPlayYoutubeIDSetAudio({
    required covariant Object? mainStreams,
    required covariant Object? stream,
    required covariant Object? cachedFile,
    required bool useCache,
    required String videoId,
  }) async {}
  Future<void> recheckCachedVideos(String videoId) async {}

  Future<bool> moveToNext(int index) async => _offlineAudioUnavailable('Queue movement');
  Future<bool> moveToAfterLatestInserted(int index) async => _offlineAudioUnavailable('Queue movement');
  Future<bool> moveToLast(int index) async => _offlineAudioUnavailable('Queue movement');
  Future<bool> moveItemsToNext(List<int> indices) async => _offlineAudioUnavailable('Queue movement');
  Future<bool> moveItemsToLast(List<int> indices) async => _offlineAudioUnavailable('Queue movement');
  Future<void> insertInQueue(Iterable<Q> items, int index) async => _offlineAudioUnavailable('Queue insertion');
  Future<void> reorderItems(int oldIndex, int newIndex) async => _offlineAudioUnavailable('Queue reordering');
  Future<void> removeFromQueue(int index) async => _offlineAudioUnavailable('Queue removal');
  Future<void> replaceAllItemsInQueue(Q oldItem, Q newItem) async => _offlineAudioUnavailable('Queue replacement');
  Future<void> replaceAllItemsInQueueBulk(Map<Q, Q> replacements) async => _offlineAudioUnavailable('Queue replacement');
  Future<void> replaceWhereInQueue(bool Function(Q item) test, Q Function(Q item) replace) async => _offlineAudioUnavailable('Queue replacement');
  int removeRangeFromQueue(int start, int end) => _offlineAudioUnavailable('Queue removal');
  int removeAllPrevious() => _offlineAudioUnavailable('Queue removal');
  int removeAllNext() => _offlineAudioUnavailable('Queue removal');
  int removeAllExceptCurrent() => _offlineAudioUnavailable('Queue removal');
  Future<void> setAudioTrack(String? trackId) async => _offlineAudioUnavailable('Audio track selection');
  Future<void> setTextTrack(String? trackId) async => _offlineAudioUnavailable('Subtitle selection');
  Future<bool> setExternalSubtitle(String? uri) async => _offlineAudioUnavailable('External subtitles');
  Future<void> userPause({int? pauseFadeMillis}) => pause(pauseFadeMillis: pauseFadeMillis);
  Future<void> userPlay() => play();
  Future<void> userTogglePlayPause() async {
    if (playWhenReady.value) {
      await userPause();
    } else {
      await userPlay();
    }
  }

  Future<void> userSkipToQueueItem(int index) => skipToQueueItem(index);

  dynamic get currentPlayer {
    final player = _currentPlayer;
    if (player != null) return player;
    _currentPlayer = createPlayerInstance();
    _listenToPlayer(_currentPlayer);
    return _currentPlayer;
  }

  QueueShuffler<Q> get queueShuffler => _queueShuffler;
  bool get isQueueShuffled => _isQueueShuffled;
  dynamic get defaultAndroidLoadConfig => null;
  bool get defaultGaplessEnabled => false;
  bool get defaultShouldStartPlayingOnNextPrev => true;
  bool get publishQueueToMediaBrowser => false;
  int get defaultCrossFadeMilliseconds => 0;
  int get defaultCrossFadeTriggerStartOffsetSeconds => 0;
  bool get enableCrossFade => false;
  bool get enableVolumeFadeOnPlayPause => false;
  bool get playerInfiniyQueueOnNextPrevious => false;
  bool get playerPauseOnVolume0 => false;
  bool get jumpToFirstItemAfterFinishingQueue => false;
  PlayerRepeatMode get playerRepeatMode => PlayerRepeatMode.none;
  PlayerRepeatMode get displayRepeatMode => PlayerRepeatMode.none;
  int get playerPauseFadeDurInMilli => 0;
  int get playerPlayFadeDurInMilli => 0;
  int get listenCounterMarkPlayedPercentage => 0;
  int get listenCounterMarkPlayedSeconds => 0;
  int get maximumSleepTimerMins => 0;
  int get maximumSleepTimerItems => 0;
  int getListenRestartPositionThresholdMS() => 0;
  InterruptionAction get onBecomingNoisyEventStream => InterruptionAction.pause;
  Duration get defaultInterruptionResumeThreshold => Duration.zero;
  Duration get defaultVolume0ResumeThreshold => Duration.zero;
  Duration get defaultConnectWiredResumeThresholdMin => Duration.zero;
  Duration get defaultConnectWirelessResumeThresholdMin => Duration.zero;
  double get replayGainLinearVolumeMultiplierValue => 1.0;

  AVPlayer createPlayerInstance() => _offlineAudioUnavailable('Player creation');

  void _listenToPlayer(dynamic player) {
    _playerSubscriptions.add(
      (player.positionStream as Stream<Duration>).listen((position) {
        currentPositionMS.value = position.inMilliseconds;
        _refreshPlaybackState();
      }),
    );
    _playerSubscriptions.add(
      (player.bufferedPositionStream as Stream<Duration>).listen((position) {
        buffered.value = position;
        _refreshPlaybackState();
      }),
    );
    _playerSubscriptions.add(
      (player.playingStream as Stream<bool>).listen((playing) {
        isPlaying.value = playing;
        _refreshPlaybackState();
      }),
    );
    _playerSubscriptions.add(
      (player.processingStateStream as Stream<ProcessingState>).listen((state) {
        currentState.value = state;
        if (state == ProcessingState.completed) onPlaybackCompleted();
        _refreshPlaybackState();
      }),
    );
    _playerSubscriptions.add(
      (player.liveWindowStream as Stream<LiveWindow?>).listen((window) {
        currentLiveWindow.value = window;
      }),
    );
    _playerSubscriptions.add(
      (player.speedStream as Stream<double>).listen((speed) {
        currentSpeed.value = speed;
      }),
    );
    _playerSubscriptions.add((player.playbackEventStream as Stream<PlaybackEvent>).listen(onPlaybackEventStream));
  }

  Future<void> play({bool checkIfPlaybackEnded = true}) async {
    setPlayWhenReady(true);
    await onPlayRaw();
  }

  Future<void> pause({int? pauseFadeMillis, bool? awaitLastPositionReport, bool isUserInitiated = true}) async {
    setPlayWhenReady(false);
    await onPauseRaw();
  }

  void setPlayWhenReady(bool value) {
    playWhenReady.value = value;
    _refreshPlaybackState();
  }

  Future<void> onPlayRaw({bool attemptFixVolume = true}) async {
    if (currentItem.value == null) return;
    await currentPlayer.play();
    isPlaying.value = true;
    _refreshPlaybackState();
  }

  Future<void> onPauseRaw() async {
    if (_currentPlayer != null) await currentPlayer.pause();
    isPlaying.value = false;
    _refreshPlaybackState();
  }

  Future<void> seek(Duration position) async {
    currentPositionMS.value = position.inMilliseconds;
    if (_currentPlayer != null) await currentPlayer.seek(position);
    _refreshPlaybackState();
  }

  Future<Duration?> setAudioSource<T, S>(ItemPrepareConfig<T, S> config) async {
    currentState.value = ProcessingState.loading;
    _refreshPlaybackState();
    final duration = await currentPlayer.setSource(config);
    currentPositionMS.value = config.initialPosition?.inMilliseconds ?? 0;
    currentState.value = ProcessingState.ready;
    buffered.value = currentPlayer.bufferedPosition as Duration? ?? Duration.zero;
    _refreshPlaybackState();
    return duration as Duration?;
  }

  Future<void> setVideo(dynamic options) async {
    if (_currentPlayer != null) await currentPlayer.setVideo(options);
  }

  Future<void> setQueueShuffled(bool shuffled) async {
    _isQueueShuffled = shuffled;
  }

  void refreshPlaybackStateModes() => _refreshPlaybackState();
  void beginEarlyCrossFadeOutIfRequired() {}
  void refreshVolumeForReplayGain() {}
  void startCounterToAListen(Q? item) {}
  void updateNumberOfRepeats(int repeats) => numberOfRepeats.value = repeats;
  Future<void> setSkipSilenceEnabled(bool enabled) async {
    if (_currentPlayer != null) await currentPlayer.setSkipSilenceEnabled(enabled);
  }

  Future<void> setCrossfadeTransition(CrossfadeTransition<Q> transition) async {
    _crossfadeTransition = transition;
  }

  FutureOr<void> beforeQueueAddOrInsert(Iterable<Q> items) {}
  Future<void>? beforeSkippingToItem() => null;
  void onIndexChanged(int newIndex, Q newItem) {}
  Future<void> onQueueChanged() async {
    if (publishQueueToMediaBrowser) {
      final items = <MediaItem>[];
      for (final item in currentQueue.value) {
        items.add(await itemToMediaItem(item));
      }
      queue.add(items);
    }
  }

  Future<void> onReorderItems(int index, Q item) async {}
  FutureOr<ItemPrepareConfig<Q, UriSource>?> prepareItem(Q item, int index) => null;
  Future<void> onItemPlay(Q item, int index, Function skipItem, ItemPreparedPlayerInfo<Q>? preparedItemInfo) async {}
  FutureOr<int> itemToDurationInSeconds(Q item) => 0;
  Future<MediaItem> itemToMediaItem(Q item) async => MediaItem(id: item.toString(), title: item.toString());
  String itemToMediaItemId(Q item) => item.toString();
  Future<void> onPlaybackCompleted() async {
    if (currentQueue.value.isNotEmpty) await skipToNext();
  }

  void onPlaybackError(Object error, StackTrace stackTrace) {}
  Future<void> onDispose() async {
    setPlayWhenReady(false);
    isPlaying.value = false;
    _sleepTimer?.cancel();
    _sleepTimer = null;
    if (_currentPlayer != null) await currentPlayer.dispose();
    for (final subscription in _playerSubscriptions) {
      await subscription.cancel();
    }
    _playerSubscriptions.clear();
    _currentPlayer = null;
  }

  Future<void> seekToLiveEdge() async {
    final edge = currentLiveWindow.value?.edge;
    if (edge != null) await seek(edge);
  }

  Future<dynamic> customAction(String name, [Map<String, dynamic>? extras]) async {}

  PlaybackState transformEvent(PlaybackEvent event, int itemIndex, List<MediaControl> controls, List<int> compactIndices) {
    return playbackState.value.copyWith(
      controls: controls,
      androidCompactActionIndices: compactIndices,
      queueIndex: itemIndex < 0 ? null : itemIndex,
      updatePosition: Duration(milliseconds: currentPositionMS.value),
      bufferedPosition: buffered.value,
      playing: isPlaying.value,
    );
  }

  void updateSleepTimerValues({
    bool? enableSleepAfterItems,
    bool? enableSleepAfterMins,
    int? sleepAfterMin,
    int? sleepAfterItems,
    bool? isAnchoredToItem,
  }) {
    final old = sleepTimerConfig.value;
    final updated = SleepTimerConfig(
      enableSleepAfterItems: enableSleepAfterItems ?? old.enableSleepAfterItems,
      sleepAfterItems: sleepAfterItems ?? old.sleepAfterItems,
      sleepAfterMin: sleepAfterMin ?? old.sleepAfterMin,
      enableSleepAfterMins: enableSleepAfterMins ?? old.enableSleepAfterMins,
    );
    sleepTimerConfig.value = updated;
    _sleepTimerAnchoredToItem = isAnchoredToItem ?? _sleepTimerAnchoredToItem;
    _sleepTimer?.cancel();
    _sleepTimer = null;
    if (updated.enableSleepAfterMins && updated.sleepAfterMin > 0) {
      _sleepTimer = Timer(Duration(minutes: updated.sleepAfterMin), () async {
        await pause();
        resetSleepTimer();
      });
    }
  }

  void resetSleepTimer() {
    _sleepTimer?.cancel();
    _sleepTimer = null;
    _sleepTimerAnchoredToItem = false;
    sleepTimerConfig.value = const SleepTimerConfig();
  }

  Future<Map<String, int>> prepareTotalListenTime() async => <String, int>{};
  Object identifyBy(Q element) => element as Object;
  InterruptionAction defaultOnInterruption(InterruptionType type) => InterruptionAction.pause;
  String? itemToTotalListenTimeKey(Q? item) => null;
  FutureOr<void> onItemMarkedListened(Q item, int listenedSeconds, double listenedPercentage) {}
  Future<PlayerConfig?> getPlayerConfigForItem(Q? item, AVPlayer player) async => null;
  void onFavouriteRatingRequested(Q item, bool favourite) {}
  void onRepeatModeChange(PlayerRepeatMode repeatMode) {}
  void onShuffleModeChange(bool shuffled) {}
  void onTotalListenTimeIncrease(Map<String, int> totalTimeInSeconds, String key) {}
  Future<void> onItemLastPositionReport(Q? item, int currentPositionMs) async {}
  void onSleepTimerEnd() {}
  void onPlaybackEventStream(PlaybackEvent event) {}
  PlayerConfig getDefaultPlayerConfig(Q? item) => const PlayerConfig();

  Future<void> assignNewQueue<Id>({
    required int playAtIndex,
    required Iterable<Q> queue,
    bool shuffle = false,
    bool shuffleKeepingItem = false,
    List<int>? originalIndices,
    bool startPlaying = true,
    int? maximumItems,
    void Function()? onQueueEmpty,
    void Function()? onIndexAndQueueSame,
    void Function(List<Q> finalizedQueue, List<int>? originalIndices)? onQueueDifferent,
    void Function(Q currentItem)? onAssigningCurrentItem,
    bool Function(Q? currentItem, Q itemToPlay)? canRestructureQueueOnly,
    void Function()? onRestructuringQueue,
    Id Function(Q currentItem)? duplicateRemover,
  }) async {
    final items = queue.toList(growable: true);
    if (maximumItems != null && items.length > maximumItems) {
      items.removeRange(maximumItems, items.length);
    }
    if (shuffle) _queueShuffler.shuffleRange(items, originalIndices, 0, items.length);
    if (items.isEmpty) {
      onQueueEmpty?.call();
      await clearQueue();
      return;
    }

    final sameQueue = _sameItems(currentQueue.value, items);
    if (sameQueue) {
      onIndexAndQueueSame?.call();
    } else {
      onQueueDifferent?.call(items, originalIndices);
    }
    currentQueue.replace(items, indices: originalIndices);
    _isQueueShuffled = shuffle;
    final index = playAtIndex.clamp(0, items.length - 1);
    final item = items[index];
    onAssigningCurrentItem?.call(item);
    setPlayWhenReady(startPlaying);
    await _playQueueItem(index, item);
    await onQueueChanged();
  }

  bool _sameItems(List<Q> a, List<Q> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  Future<void> _playQueueItem(int index, Q item) async {
    currentIndex.value = index;
    currentItem.value = item;
    onIndexChanged(index, item);
    final prepared = await prepareItem(item, index);
    await onItemPlay(item, index, () => skipToNext(), prepared == null ? null : ItemPreparedPlayerInfo<Q>(prepared));
  }

  Future<void> addToQueue(Iterable<Q> items, {bool insertNext = false, bool insertAfterLatest = false}) async {
    final updated = [...currentQueue.value, ...items];
    currentQueue.replace(updated, indices: currentQueue.originalIndices);
    await onQueueChanged();
  }

  Future<void> skipToQueueItem(int index, {bool isManualSkip = true}) async {
    if (index < 0 || index >= currentQueue.length) return;
    final timer = sleepTimerConfig.value;
    if (timer.enableSleepAfterItems && index != currentIndex.value) {
      if (timer.sleepAfterItems <= 1) {
        await pause();
        resetSleepTimer();
        return;
      }
      updateSleepTimerValues(sleepAfterItems: timer.sleepAfterItems - 1);
    }
    await beforeSkippingToItem();
    await _playQueueItem(index, currentQueue.value[index]);
  }

  Future<void> skipToNext({bool? andPlay, bool isManualSkip = true}) async {
    if (currentQueue.isEmpty) return;
    final next = currentIndex.value + 1;
    if (next >= currentQueue.length) return;
    if (andPlay != null) setPlayWhenReady(andPlay);
    await skipToQueueItem(next);
  }

  Future<void> skipToPrevious({bool isManualSkip = true}) async {
    final previous = currentIndex.value - 1;
    if (previous < 0) return;
    await skipToQueueItem(previous);
  }

  int? shufflePeekPreviousIndex() => null;

  FutureOr<void> clearQueue() async {
    currentQueue.replace(<Q>[]);
    currentItem.value = null;
    currentIndex.value = -1;
    currentPositionMS.value = 0;
    currentState.value = ProcessingState.idle;
    setPlayWhenReady(false);
    await onQueueChanged();
  }

  void _refreshPlaybackState() {
    final current = playbackState.valueOrNull ?? PlaybackState();
    playbackState.add(
      current.copyWith(
        processingState: switch (currentState.value) {
          ProcessingState.idle || null => AudioProcessingState.idle,
          ProcessingState.loading => AudioProcessingState.loading,
          ProcessingState.buffering => AudioProcessingState.buffering,
          ProcessingState.ready => AudioProcessingState.ready,
          ProcessingState.completed => AudioProcessingState.completed,
        },
        playing: isPlaying.value,
        updatePosition: Duration(milliseconds: currentPositionMS.value),
        bufferedPosition: buffered.value,
        speed: currentSpeed.value,
        queueIndex: currentIndex.value < 0 ? null : currentIndex.value,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => _offlineAudioUnavailable(
    'Audio handler operation (${invocation.memberName})',
  );
}
