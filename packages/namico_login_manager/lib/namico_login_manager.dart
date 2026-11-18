enum YoutiLoginProgress { canceled, failed }

typedef YoutiLoginProgressCallback = void Function(YoutiLoginProgress progress);

enum SignInDecision { forceSignIn }

/// Minimal API shape for builds without the online login implementation.
abstract final class NamicoLoginManager {
  static String? windowsBrowserArguments;
}
