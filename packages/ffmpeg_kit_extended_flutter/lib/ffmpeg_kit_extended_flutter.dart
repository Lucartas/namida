Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this build.');

enum LogLevel { quiet }
enum LogRedirectionStrategy { neverPrintLogs }

abstract final class FFmpegKitExtended {
  static Future<void> initialize() => _unavailable('FFmpegKitExtended.initialize');
  static String getRegisteredProtocols() => _unavailable('FFmpegKitExtended.getRegisteredProtocols');
}

abstract final class FFmpegKitConfig {
  static void setMaxConcurrentSessions(int value) => _unavailable('FFmpegKitConfig.setMaxConcurrentSessions');
  static void setLogLevel(LogLevel value) => _unavailable('FFmpegKitConfig.setLogLevel');
  static void setLogRedirectionStrategy(LogRedirectionStrategy value) => _unavailable('FFmpegKitConfig.setLogRedirectionStrategy');
}

class Session {
  Future<Object> executeAsync() => _unavailable('Session.executeAsync');
  void cancel() => _unavailable('Session.cancel');
  Object? getReturnCode() => _unavailable('Session.getReturnCode');
  String? getOutput() => _unavailable('Session.getOutput');
}

abstract final class FFmpegKit {
  static Session createSessionFromArguments(List<String> args) => _unavailable('FFmpegKit.createSessionFromArguments');
}

abstract final class FFprobeKit {
  static Session createSessionFromArguments(List<String> args) => _unavailable('FFprobeKit.createSessionFromArguments');
}

abstract final class ReturnCode {
  static bool isSuccess(Object? returnCode) => _unavailable('ReturnCode.isSuccess');
}
