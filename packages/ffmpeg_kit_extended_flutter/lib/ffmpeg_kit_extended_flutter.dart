/// Compile-time API surface for the unavailable FFmpeg Kit implementation.
///
/// Milestone 1 only needs the application to analyze and build. Calls that
/// require FFmpeg remain explicitly unavailable until a local backend is added.
enum LogLevel { quiet }

enum LogRedirectionStrategy { neverPrintLogs }

abstract final class FFmpegKitExtended {
  static Future<void> initialize() async {}

  static String getRegisteredProtocols() => '';
}

abstract final class FFmpegKitConfig {
  static void setMaxConcurrentSessions(int _) {}
  static void setLogLevel(LogLevel _) {}
  static void setLogRedirectionStrategy(LogRedirectionStrategy _) {}
}

class Session {
  Future<Object> executeAsync() async => throw UnsupportedError('FFmpeg execution is unavailable in this build.');
  Future<void> cancel() async {}
  Object? getReturnCode() => null;
  String? getOutput() => null;
}

abstract final class FFmpegKit {
  static Session createSessionFromArguments(List<String> _) => Session();
}

abstract final class FFprobeKit {
  static Session createSessionFromArguments(List<String> _) => Session();
}

abstract final class ReturnCode {
  static bool isSuccess(Object? _) => false;
}
