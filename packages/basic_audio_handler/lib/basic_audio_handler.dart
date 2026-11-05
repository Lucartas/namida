import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart' show AudioPlayer, AudioTrack, LiveWindow, PlaybackEvent, ProcessingState, TextTrack, UriSource, VideoInfoData, VideoSourceOptions;
import 'package:nampack/nampack.dart';

Never _compileOnlyFailure(String member) => throw UnsupportedError(
  'basic_audio_handler.$member was called, but this compile-only adapter has no runtime implementation.',
);

enum PlayerRepeatMode { none, one, all, allShuffle, forNtimes }

enum InterruptionType { shouldPause, shouldDuck, unknown }

enum InterruptionAction { doNothing, duckAudio, pause }

enum EqualizerBandType { peak, lowShelf, highShelf, lowPass, highPass, bandPass, notch, allPass }

enum EqualizerChannel { all, left, right }

enum PlayerConfigModificationScale { none, main, alt }

extension EqualizerBandTypeProperties on EqualizerBandType {
  bool get hasGain => _compileOnlyFailure('EqualizerBandTypeProperties.hasGain');
  bool get hasOrder => _compileOnlyFailure('EqualizerBandTypeProperties.hasOrder');
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
  int get sectionCount => _compileOnlyFailure('EqualizerBand.sectionCount');
  double sectionQ(int _) => _compileOnlyFailure('EqualizerBand.sectionQ');

  EqualizerBand copyWith({
    int? id,
    double? frequency,
    double? gain,
    double? q,
    EqualizerBandType? type,
    EqualizerChannel? channel,
    bool? enabled,
    int? order,
  }) => _compileOnlyFailure('EqualizerBand.copyWith');
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

  factory ParametricEqualizer.fromMap(dynamic map) => _compileOnlyFailure('ParametricEqualizer.fromMap');
  factory ParametricEqualizer.fromLegacyGains(dynamic _) => _compileOnlyFailure('ParametricEqualizer.fromLegacyGains');
  factory ParametricEqualizer.fromEqualizerApo(String _) => _compileOnlyFailure('ParametricEqualizer.fromEqualizerApo');

  Map<String, dynamic> toMap() => _compileOnlyFailure('ParametricEqualizer.toMap');

  String toEqualizerApo() => _compileOnlyFailure('ParametricEqualizer.toEqualizerApo');

  ParametricEqualizer copyWith({List<EqualizerBand>? bands, double? preamp, bool? autoPreamp, bool? limiter}) => _compileOnlyFailure('ParametricEqualizer.copyWith');

  ParametricEqualizer withBand(EqualizerBand band) => _compileOnlyFailure('ParametricEqualizer.withBand');

  ParametricEqualizer withoutBand(int id) => _compileOnlyFailure('ParametricEqualizer.withoutBand');
  int getNextBandId() => _compileOnlyFailure('ParametricEqualizer.getNextBandId');
  bool hasChannelSpecificBands() => _compileOnlyFailure('ParametricEqualizer.hasChannelSpecificBands');
  List<EqualizerBand> getActiveBands() => _compileOnlyFailure('ParametricEqualizer.getActiveBands');
  double computeEffectivePreamp() => _compileOnlyFailure('ParametricEqualizer.computeEffectivePreamp');
  double responseDb(double _, {EqualizerChannel channel = EqualizerChannel.all}) => _compileOnlyFailure('ParametricEqualizer.responseDb');
  List<double> responseCurve(List<double> frequencies, {EqualizerChannel channel = EqualizerChannel.all}) => _compileOnlyFailure('ParametricEqualizer.responseCurve');

  static ParametricEqualizer graphic(List<double> frequencies) => _compileOnlyFailure('ParametricEqualizer.graphic');

  static List<double> logFrequencies(double minFrequency, double maxFrequency, int count) => _compileOnlyFailure('ParametricEqualizer.logFrequencies');
}

class EqualizerPreset {
  final String name;
  final ParametricEqualizer equalizer;

  const EqualizerPreset({required this.name, this.equalizer = ParametricEqualizer.flat});

  static const List<EqualizerPreset> allDefaults = [EqualizerPreset(name: 'Flat')];

  static EqualizerPreset? fromMap(dynamic map) => _compileOnlyFailure('EqualizerPreset.fromMap');

  Map<String, dynamic> toMap() => _compileOnlyFailure('EqualizerPreset.toMap');
  EqualizerPreset copyWith({String? name, ParametricEqualizer? equalizer}) => _compileOnlyFailure('EqualizerPreset.copyWith');
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

  factory PlayerConfig.fromMap(dynamic _) => _compileOnlyFailure('PlayerConfig.fromMap');
  Map<String, dynamic> toMap() => _compileOnlyFailure('PlayerConfig.toMap');

  PlayerConfigModificationScale getModificationScale() => _compileOnlyFailure('PlayerConfig.getModificationScale');

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
  }) => _compileOnlyFailure('PlayerConfig.copyWith');
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
  bool get isEmpty => _compileOnlyFailure('PlayerConfigOverrides.isEmpty');

  static PlayerConfigOverrides fromMap(Map<String, dynamic> _) => _compileOnlyFailure('PlayerConfigOverrides.fromMap');
  Map<String, dynamic> toMap() => _compileOnlyFailure('PlayerConfigOverrides.toMap');
  PlayerConfig resolve(PlayerConfig _) => _compileOnlyFailure('PlayerConfigOverrides.resolve');
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
  }) => _compileOnlyFailure('PlayerConfigOverrides.copyWith');
  PlayerConfigOverrides copyWithEqualizer(ParametricEqualizer? value, [EqualizerPreset? _]) => _compileOnlyFailure('PlayerConfigOverrides.copyWithEqualizer');
  PlayerConfigOverrides clear({bool volume = false, bool speed = false, bool pitch = false, bool loudnessEnhancer = false}) => _compileOnlyFailure('PlayerConfigOverrides.clear');
}

class EqualizerExtended {
  dynamic get androidAudioEffect => _compileOnlyFailure('EqualizerExtended.androidAudioEffect');
  Future<void> apply(bool _, ParametricEqualizer? _) => _compileOnlyFailure('EqualizerExtended.apply');
}

class LoudnessEnhancerExtended {
  dynamic get androidAudioEffect => _compileOnlyFailure('LoudnessEnhancerExtended.androidAudioEffect');
  static const double kMinGain = -20;
  static const double kMaxGain = 20;
  Future<void> setTargetGainUser(double _) => _compileOnlyFailure('LoudnessEnhancerExtended.setTargetGainUser');
  Future<void> setTargetGainTrack(double _) => _compileOnlyFailure('LoudnessEnhancerExtended.setTargetGainTrack');
  Future<void> setEnabledUser(bool _) => _compileOnlyFailure('LoudnessEnhancerExtended.setEnabledUser');
  dynamic get targetGainTrack => _compileOnlyFailure('LoudnessEnhancerExtended.targetGainTrack');
  dynamic refreshEnabled() => _compileOnlyFailure('LoudnessEnhancerExtended.refreshEnabled');
  dynamic getActualGainFromUser(bool _, double _) => _compileOnlyFailure('LoudnessEnhancerExtended.getActualGainFromUser');
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
  void shuffleRange(List<Q> items, List<int>? pairedIndices, int start, int end) => _compileOnlyFailure('QueueShuffler.shuffleRange');

  static void swap<Q>(List<Q> items, List<int>? pairedIndices, int a, int b) => _compileOnlyFailure('QueueShuffler.swap');
}

class CrossFadeCurve {
  const CrossFadeCurve.equalPower();
  double transform(double value) => _compileOnlyFailure('CrossFadeCurve.transform');
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

  List<Q> get value => _compileOnlyFailure('BasicQueue.value');
  int get length => _compileOnlyFailure('BasicQueue.length');
  bool get isEmpty => _compileOnlyFailure('BasicQueue.isEmpty');

  void replace(List<Q> items, {List<int>? indices}) => _compileOnlyFailure('BasicQueue.replace');
}

class CustomAudioPlayer implements AVPlayer {
  CustomAudioPlayer(AudioPlayer _);

  @override
  dynamic noSuchMethod(Invocation invocation) => _compileOnlyFailure(
    'CustomAudioPlayer.${invocation.memberName}',
  );
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

  Duration? get liveJoinPosition => _compileOnlyFailure('BasicAudioHandler.liveJoinPosition');
  double get userPlayerVolumeForItem => _compileOnlyFailure('BasicAudioHandler.userPlayerVolumeForItem');
  int get seekCount => _compileOnlyFailure('BasicAudioHandler.seekCount');
  int get lastSeekPositionMS => _compileOnlyFailure('BasicAudioHandler.lastSeekPositionMS');
  int get latestInsertedIndex => _compileOnlyFailure('BasicAudioHandler.latestInsertedIndex');
  bool get isShuffleEnabled => _compileOnlyFailure('BasicAudioHandler.isShuffleEnabled');
  bool get isLastItem => _compileOnlyFailure('BasicAudioHandler.isLastItem');
  bool get isModifyingQueue => _compileOnlyFailure('BasicAudioHandler.isModifyingQueue');
  bool get isAutoSkipping => _compileOnlyFailure('BasicAudioHandler.isAutoSkipping');
  bool get rendersSubtitlesInternally => _compileOnlyFailure('BasicAudioHandler.rendersSubtitlesInternally');
  int? get androidSessionId => _compileOnlyFailure('BasicAudioHandler.androidSessionId');

  set onVideoError(void Function(Object, StackTrace)? callback) => _compileOnlyFailure('BasicAudioHandler.onVideoError');

  void onVolumeChangeAddListener(String key, void Function(double) callback) => _compileOnlyFailure('BasicAudioHandler.onVolumeChangeAddListener');
  void onVolumeChangeRemoveListener(String key) => _compileOnlyFailure('BasicAudioHandler.onVolumeChangeRemoveListener');
  Future<void> executeWithPausedOutput(Future<void> Function() callback) => _compileOnlyFailure('BasicAudioHandler.executeWithPausedOutput');
  Future<void> executeOnPlayers(Future<void> Function(dynamic player) callback) => _compileOnlyFailure('BasicAudioHandler.executeOnPlayers');
  Future<void> refreshCurrentItemPlayerConfig() => _compileOnlyFailure('BasicAudioHandler.refreshCurrentItemPlayerConfig');
  void refreshRxVariables() => _compileOnlyFailure('BasicAudioHandler.refreshRxVariables');
  Future<void> setVolumeWithMultiplier(double value) => _compileOnlyFailure('BasicAudioHandler.setVolumeWithMultiplier');
  Future<void> setPlayerPitch(double value) => _compileOnlyFailure('BasicAudioHandler.setPlayerPitch');
  Future<void> setPlayerSpeed(double value) => _compileOnlyFailure('BasicAudioHandler.setPlayerSpeed');
  void invokeQueueModifyLock() => _compileOnlyFailure('BasicAudioHandler.invokeQueueModifyLock');
  void invokeQueueModifyLockRelease({bool isCanceled = false}) => _compileOnlyFailure('BasicAudioHandler.invokeQueueModifyLockRelease');
  int? shuffleNextIndex() => _compileOnlyFailure('BasicAudioHandler.shuffleNextIndex');
  bool isSameAsOriginalQueue(Iterable<Q> items) => _compileOnlyFailure('BasicAudioHandler.isSameAsOriginalQueue');
  Rx<int> get playErrorRemainingSecondsToSkip => _compileOnlyFailure('BasicAudioHandler.playErrorRemainingSecondsToSkip');
  void invokeQueueModifyOnModifyCancel() => _compileOnlyFailure('BasicAudioHandler.invokeQueueModifyOnModifyCancel');
  Future<void> resetGaplessPlaybackData() => _compileOnlyFailure('BasicAudioHandler.resetGaplessPlaybackData');
  Future<void> shuffleAllItems() => _compileOnlyFailure('BasicAudioHandler.shuffleAllItems');
  Future<void> shuffleNextItems() => _compileOnlyFailure('BasicAudioHandler.shuffleNextItems');
  int removeDuplicatesFromQueue() => _compileOnlyFailure('BasicAudioHandler.removeDuplicatesFromQueue');

  Future<bool> moveToNext(int index) => _compileOnlyFailure('BasicAudioHandler.moveToNext');
  Future<bool> moveToAfterLatestInserted(int index) => _compileOnlyFailure('BasicAudioHandler.moveToAfterLatestInserted');
  Future<bool> moveToLast(int index) => _compileOnlyFailure('BasicAudioHandler.moveToLast');
  Future<bool> moveItemsToNext(List<int> indices) => _compileOnlyFailure('BasicAudioHandler.moveItemsToNext');
  Future<bool> moveItemsToLast(List<int> indices) => _compileOnlyFailure('BasicAudioHandler.moveItemsToLast');
  Future<void> insertInQueue(Iterable<Q> items, int index) => _compileOnlyFailure('BasicAudioHandler.insertInQueue');
  Future<void> reorderItems(int oldIndex, int newIndex) => _compileOnlyFailure('BasicAudioHandler.reorderItems');
  Future<void> removeFromQueue(int index) => _compileOnlyFailure('BasicAudioHandler.removeFromQueue');
  Future<void> replaceAllItemsInQueue(Q oldItem, Q newItem) => _compileOnlyFailure('BasicAudioHandler.replaceAllItemsInQueue');
  Future<void> replaceAllItemsInQueueBulk(Map<Q, Q> replacements) => _compileOnlyFailure('BasicAudioHandler.replaceAllItemsInQueueBulk');
  Future<void> replaceWhereInQueue(bool Function(Q item) test, Q Function(Q item) replace) => _compileOnlyFailure('BasicAudioHandler.replaceWhereInQueue');
  int removeRangeFromQueue(int start, int end) => _compileOnlyFailure('BasicAudioHandler.removeRangeFromQueue');
  int removeAllPrevious() => _compileOnlyFailure('BasicAudioHandler.removeAllPrevious');
  int removeAllNext() => _compileOnlyFailure('BasicAudioHandler.removeAllNext');
  int removeAllExceptCurrent() => _compileOnlyFailure('BasicAudioHandler.removeAllExceptCurrent');
  Future<void> setAudioTrack(String? trackId) => _compileOnlyFailure('BasicAudioHandler.setAudioTrack');
  Future<void> setTextTrack(String? trackId) => _compileOnlyFailure('BasicAudioHandler.setTextTrack');
  Future<bool> setExternalSubtitle(String? uri) => _compileOnlyFailure('BasicAudioHandler.setExternalSubtitle');

  dynamic get currentPlayer => _compileOnlyFailure('BasicAudioHandler.currentPlayer');

  QueueShuffler<Q> get queueShuffler => _compileOnlyFailure('BasicAudioHandler.queueShuffler');
  bool get isQueueShuffled => _compileOnlyFailure('BasicAudioHandler.isQueueShuffled');
  PlayerRepeatMode get displayRepeatMode => _compileOnlyFailure('BasicAudioHandler.displayRepeatMode');

  @override
  Future<void> play({bool checkIfPlaybackEnded = true}) => _compileOnlyFailure('BasicAudioHandler.play');

  @override
  Future<void> pause({int? pauseFadeMillis, bool? awaitLastPositionReport, bool isUserInitiated = true}) => _compileOnlyFailure('BasicAudioHandler.pause');

  void setPlayWhenReady(bool value) => _compileOnlyFailure('BasicAudioHandler.setPlayWhenReady');

  Future<void> onPlayRaw({bool attemptFixVolume = true}) => _compileOnlyFailure('BasicAudioHandler.onPlayRaw');

  Future<void> onPauseRaw() => _compileOnlyFailure('BasicAudioHandler.onPauseRaw');

  @override
  Future<void> seek(Duration position) => _compileOnlyFailure('BasicAudioHandler.seek');

  Future<Duration?> setAudioSource<T, S>(ItemPrepareConfig<T, S> config) => _compileOnlyFailure('BasicAudioHandler.setAudioSource');

  Future<void> setVideo(dynamic options) => _compileOnlyFailure('BasicAudioHandler.setVideo');

  Future<void> setQueueShuffled(bool shuffled) => _compileOnlyFailure('BasicAudioHandler.setQueueShuffled');

  void refreshPlaybackStateModes() => _compileOnlyFailure('BasicAudioHandler.refreshPlaybackStateModes');
  void beginEarlyCrossFadeOutIfRequired() => _compileOnlyFailure('BasicAudioHandler.beginEarlyCrossFadeOutIfRequired');
  void refreshVolumeForReplayGain() => _compileOnlyFailure('BasicAudioHandler.refreshVolumeForReplayGain');
  void startCounterToAListen(Q? item) => _compileOnlyFailure('BasicAudioHandler.startCounterToAListen');
  void updateNumberOfRepeats(int repeats) => _compileOnlyFailure('BasicAudioHandler.updateNumberOfRepeats');
  Future<void> setSkipSilenceEnabled(bool enabled) => _compileOnlyFailure('BasicAudioHandler.setSkipSilenceEnabled');

  Future<void> setCrossfadeTransition(CrossfadeTransition<Q> transition) => _compileOnlyFailure('BasicAudioHandler.setCrossfadeTransition');

  Future<void>? beforeSkippingToItem() => _compileOnlyFailure('BasicAudioHandler.beforeSkippingToItem');
  Future<void> onQueueChanged() => _compileOnlyFailure('BasicAudioHandler.onQueueChanged');

  Future<void> onReorderItems(int index, Q item) => _compileOnlyFailure('BasicAudioHandler.onReorderItems');
  Future<void> onPlaybackCompleted() => _compileOnlyFailure('BasicAudioHandler.onPlaybackCompleted');

  Future<void> onDispose() => _compileOnlyFailure('BasicAudioHandler.onDispose');

  Future<void> seekToLiveEdge() => _compileOnlyFailure('BasicAudioHandler.seekToLiveEdge');

  @override
  Future<dynamic> customAction(String name, [Map<String, dynamic>? extras]) => _compileOnlyFailure('BasicAudioHandler.customAction');

  PlaybackState transformEvent(PlaybackEvent event, int itemIndex, List<MediaControl> controls, List<int> compactIndices) =>
      _compileOnlyFailure('BasicAudioHandler.transformEvent');

  void updateSleepTimerValues({
    bool? enableSleepAfterItems,
    bool? enableSleepAfterMins,
    int? sleepAfterMin,
    int? sleepAfterItems,
    bool? isAnchoredToItem,
  }) => _compileOnlyFailure('BasicAudioHandler.updateSleepTimerValues');

  void resetSleepTimer() => _compileOnlyFailure('BasicAudioHandler.resetSleepTimer');

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
  }) => _compileOnlyFailure('BasicAudioHandler.assignNewQueue');

  Future<void> addToQueue(Iterable<Q> items, {bool insertNext = false, bool insertAfterLatest = false}) => _compileOnlyFailure('BasicAudioHandler.addToQueue');

  @override
  Future<void> skipToQueueItem(int index, {bool isManualSkip = true}) => _compileOnlyFailure('BasicAudioHandler.skipToQueueItem');

  @override
  Future<void> skipToNext({bool? andPlay, bool isManualSkip = true}) => _compileOnlyFailure('BasicAudioHandler.skipToNext');

  @override
  Future<void> skipToPrevious({bool isManualSkip = true}) => _compileOnlyFailure('BasicAudioHandler.skipToPrevious');

  int? shufflePeekPreviousIndex() => _compileOnlyFailure('BasicAudioHandler.shufflePeekPreviousIndex');

  FutureOr<void> clearQueue() => _compileOnlyFailure('BasicAudioHandler.clearQueue');
}
