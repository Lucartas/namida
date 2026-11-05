enum YoutiLoginProgress { canceled, failed }

typedef YoutiLoginProgressCallback = void Function(YoutiLoginProgress progress);

enum SignInDecision { forceSignIn }
