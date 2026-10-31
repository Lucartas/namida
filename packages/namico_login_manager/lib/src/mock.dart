Never _unavailable(String api) => throw UnsupportedError('$api is unavailable in this offline build.');

enum YoutiLoginProgress { idle, starting, openingBrowser, waitingForRedirect, signingIn, complete, failed, canceled }

typedef YoutiLoginProgressCallback = void Function(YoutiLoginProgress progress);

enum SignInDecision { forceSignIn, signInIfNeeded, cancel }

class NamicoLoginManager {
  dynamic noSuchMethod(Invocation invocation) => throw UnsupportedError(
    'Account sign-in is unavailable in this offline build.',
  );
}
