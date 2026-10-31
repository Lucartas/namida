import 'dart:math' as math;

import 'package:audio_service/audio_service.dart' show BaseAudioHandler;

Never _offlineAudioUnavailable(String operation) => throw UnsupportedError(
  '$operation is unavailable in this build; local playback support is implemented in Milestone 2.',
);

enum PlayerRepeatMode { none, one, all, allShuffle, forNtimes }

enum InterruptionType { shouldPause, shouldDuck, unknown }

enum InterruptionAction { doNothing, duckAudio, pause }

enum EqualizerBandType { peak, lowShelf, highShelf, lowPass, highPass, bandPass, notch, allPass }

enum EqualizerChannel { all, left, right }

enum MediaButton { media, next, previous }

class AudioTrack {
  final int groupIndex;
  final int trackIndex;
  final String? id;
  final String? displayName;
  final String? label;
  final String? language;
  final String? mimeType;
  final int? sampleRate;
  final int? bitrate;
  final int? channelCount;
  final bool isSelected;

  const AudioTrack({this.groupIndex = 0, this.trackIndex = 0, this.id, this.displayName, this.label, this.language, this.mimeType, this.sampleRate, this.bitrate, this.channelCount, this.isSelected = false});
}

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
  Future<void> apply(bool _, ParametricEqualizer? __) async => _offlineAudioUnavailable('Equalizer');
}

class LoudnessEnhancerExtended {
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

class ItemPrepareConfig<T, S> {
  final dynamic source;
  final int index;
  final Duration? initialPosition;
  final String? audioTrackId;
  final dynamic videoOptions;
  final bool keepOldVideoSource;

  const ItemPrepareConfig(
    this.source, {
    required this.index,
    this.initialPosition,
    this.audioTrackId,
    this.videoOptions,
    this.keepOldVideoSource = false,
  });
}

class BasicAudioHandler<Q> extends BaseAudioHandler {
  BasicAudioHandler();

  @override
  dynamic noSuchMethod(Invocation invocation) => _offlineAudioUnavailable(
    'Audio handler operation (${invocation.memberName})',
  );
}
