Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this offline build.');

class PartyRelayConfig {
  final int? maxRoomsTotal;
  final Duration? directoryRefreshInterval;
  const PartyRelayConfig({this.maxRoomsTotal, this.directoryRefreshInterval});
}

class PartyRelayServer {
  static dynamic get start => _unavailable('Party relay');
  dynamic get port => _unavailable('Party relay');
  dynamic get createRoom => _unavailable('Party relay');
  Future<void> close() async => _unavailable('Party relay');
}
