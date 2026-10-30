# Namida offline-player fork: preparation audit

## Goal and boundaries

- **Milestone 1 — buildable mocks:** replace closed-source upstream package
  dependencies with small local mocks/adapters sufficient to compile, then
  produce a debug APK from a clean checkout without upstream credentials. The
  APK existing is the acceptance criterion: whether the app starts or later
  crashes is out of scope. Unsupported mock calls must fail clearly rather than
  pretend to work.
- **Milestone 2 — offline player:** replace the local-audio, queue, playlist,
  and storage mocks with working implementations. Local audio can be
  indexed/imported and played, with queue controls and persistent playlist
  create/edit behavior. YouTube, account login, subscriptions, and remote-party
  functionality are out of scope.
- **Milestone 3 — parity:** deferred; it is not needed for the offline-player
  goal.

For Milestone 2, “import” is provisionally treated as indexing local audio and
importing selected local files. Importing playlists or backups is a separate
feature unless later included explicitly.

## Repository and build findings

- The Android target is the first supported build target. The merged `mise.toml`
  and `mise.lock` pin Flutter `3.47.8`, which bundles Dart `3.13.7`; Android is
  configured with min SDK 26 and target/compile SDK 36. The local machine has
  Android SDK platform 36/build-tools 36.1.0 and Java 21. The project uses
  Gradle 8.14, Android Gradle Plugin 8.11.1, Kotlin 2.2.20, and Java/Kotlin
  toolchain 17.
- A normal `git clone` leaves four submodules uninitialized. `external/language`
  is used by `l10n.yaml`; it remains a build input unless translations are
  generated or stubbed locally. `external/party_relay/dart` is a path dependency
  in `pubspec.yaml` and party code imports it, so it must be removed or mocked
  for Milestone 1. The `ffmpeg_build` submodule supplies the Android AAR named
  in the Flutter hook configuration. Its configured URL returns “Repository not
  found,” which is expected for an upstream artifact this fork must not rely on;
  Milestone 1 needs to remove or locally stub the FFmpeg integration if it is
  not part of the mock build.
- The `namida-assets` submodule is used by screenshot/documentation tooling and
  README imagery; no Android asset or Dart import from it was found. It does not
  appear to be an Android app build input. The app’s bundled assets are under
  the root `assets/` directory.
- Upstream CI configures owner-scoped GitHub credentials for `namidaco` and
  `MSOB7YY`, then updates submodules with `--remote` and runs `flutter pub
  upgrade`. That is upstream build machinery, not a prerequisite for this fork:
  the replacement plan must remove its dependence on those credentials and
  moving upstream inputs.
- Read-only `git ls-remote` checks returned “Repository not found” for
  `namidaco/basic_audio_handler`, `namidaco/playlist_manager`,
  `namidaco/youtipie`, `namidaco/namico_login_manager`,
  `namidaco/namico_subscription_manager`, and `MSOB7YY/ffmpeg_build`. These are
  expected unavailable upstream inputs under the stated replacement plan, not an
  access problem to solve by obtaining credentials. The current checkout still
  declares, imports, or references them, so the immediate build task is to cut
  those dependency edges with Milestone 1 mocks or removal. `namico_db_wrapper`
  and `namida_waveform` were reachable in the same checks; their status in the
  replacement plan should be decided from their use and intended Milestone 2
  boundary, not inferred from reachability.
- There is no tracked `pubspec.lock`, and `.gitignore` ignores it. Numerous Git
  dependencies have no pinned `ref`; normal Pub version constraints are also not
  captured by a committed lockfile. Dependency resolution is therefore not
  reproducible from this checkout alone.
- The upstream release workflow uses a signing keystore for release APKs.
  Milestone 1 should use a debug APK and should not require release-signing
  secrets. Android Gradle configuration also overrides the default APK filename
  with `namida-v<version>[-<abi>].apk`, so verification should look in
  `build/app/outputs/flutter-apk/` rather than require `app-debug.apk`.
- `flutter pub get` reaches dependency resolution but stops when it tries to fetch
  `namidaco/namico_subscription_manager`, one of the upstream packages slated
  for replacement/removal. This confirms the current manifest cannot build
  as-is; it does not indicate that the fork should obtain access to that source.
  A full APK build remains unverified until the Milestone 1 dependency cutover
  is implemented.

## Dependency boundaries to address

The closed-source upstream dependencies identified above are replacement
targets; this plan does not require recovering or importing their source. Other
reachable Git dependencies should be kept only when they fit the fork’s intended
implementation, since availability alone does not make them suitable
replacements or establish redistribution rights. Several target packages are
imported across core code, controllers, and UI, so Milestone 1 must either
provide their compile-time types locally or remove the consuming feature paths;
changing `pubspec.yaml` alone will not be sufficient.

- **Local playback:** `basic_audio_handler` supplies types used across the
  player, settings, and UI. Milestone 1 needs a compile-time local mock/adapter;
  Milestone 2 replaces it with real local playback and required background
  controls.
- **Playlists and persistence:** `playlist_manager` is the base of
  `PlaylistController`; `namico_db_wrapper` is used by playlist, indexer, and
  player controllers. Milestone 1 needs enough local mock surface to compile.
  Milestone 2 replaces the local playlist/storage paths with functional
  implementations, not permanent no-op stubs.
- **YouTube and membership:** `youtipie`, `namico_login_manager`, and
  `namico_subscription_manager` support online YouTube and membership paths and
  are out of scope for the offline target. Remove those feature paths or provide
  minimal compile-time model mocks in Milestone 1; do not report simulated
  login, subscription, or YouTube success. Shared types imported into the player
  must be separated from the local-player model.
- **Media/build artifacts:** `ffmpeg_kit_extended_flutter` uses inputs from
  `external/ffmpeg_build`; `namida_waveform` is a separate Git dependency. For
  Milestone 1, remove or locally stub the FFmpeg-dependent paths needed only for
  metadata/video behavior. Before Milestone 2, decide whether any specific media
  operation required by local indexing/playback justifies a replacement
  implementation.
- **Assets and translations:** `language` is required by code generation through
  `l10n.yaml`; determine the minimum translation inputs needed for the offline
  app. `namida-assets` supports screenshot/documentation workflows and is not
  currently referenced as an app asset. `party_relay` is outside the
  offline-player scope, but the package path dependency and imports must be
  removed or isolated before the submodule can be omitted from an offline build.

## Implementation and review approach

Use the smallest boundary that keeps the Android target compiling. Milestone 1
replaces upstream closed-source package references with local compile-time
mocks/adapters and removes out-of-scope online/party paths. Keep mocks explicit
and behaviorally honest. Milestone 2 replaces the local audio, playlist, and
storage mocks with working implementations.

Organize changes by app subsystem, not strictly one PR per package. Keep the
default branch buildable: merge each coherent change only when the Android build
passes, or keep interdependent work stacked until the combined change is green.
Avoid both a single unreviewable rewrite and merged intermediate states that
cannot build.

## Verification criteria

### Milestone 1

From a clean checkout with only documented, available prerequisites:

1. Resolve dependencies without closed-source upstream credentials or artifacts.
2. Build with `flutter build apk --debug`.
3. Confirm a debug APK exists under `build/app/outputs/flutter-apk/` (the
   Android Gradle config overrides the default filename).

Installation and runtime behavior are diagnostic only for this milestone. The
app may fail to start or may crash after starting without failing Milestone 1.

### Milestone 2

On an Android device or emulator, with networking disabled:

1. Grant audio access, index local files, and import selected local audio files.
2. Play, pause, seek, skip, and reorder/clear the queue using in-app controls.
3. Create a playlist, add and remove tracks, restart the app, and verify the
   playlist persists.
4. Verify background playback and notification/lock-screen controls if they
   remain part of the “basic player” definition.
5. Confirm no YouTube account, membership, or party service is needed for these
   paths.
