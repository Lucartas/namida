# Namida offline-player fork: preparation audit

## Goal and boundaries

- **Milestone 1 — buildable mocks (complete):** replace closed-source upstream package
  dependencies with small local mocks/adapters sufficient to compile, then
  produce a debug APK from a clean checkout without upstream credentials. The
  APK existing is the acceptance criterion: whether the app starts or later
  crashes is out of scope. Unsupported mock calls must fail clearly rather than
  pretend to work. Verified on 2026-10-31 with `mise exec -- flutter pub get`
  and `mise exec -- flutter build apk --debug`.
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
- The upstream configuration lists four submodules. This fork keeps the
  reachable `external/language` and `external/party_relay` repositories,
  alongside `external/namida-assets`. The original language gitlink was 292
  English keys behind the app; `external/language` is therefore pinned to the
  reachable remote revision `d2d00cd0d4233c245ae869571afef14bbbf131a6`, while
  `external/party_relay` stays at its original pinned revision. Localization
  generation reads `external/language/translations`, and `pubspec.yaml` uses
  `external/party_relay/dart`. The `ffmpeg_build` URL returns “Repository not
  found”; it remains excluded, and the FFmpeg integration is removed or locally
  stubbed where needed for the mock build.
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
- The fork now tracks `pubspec.lock` so Pub package versions are fixed for this
  app checkout. Git dependencies with no pinned `ref` remain an upstream
  maintenance risk; the lockfile records the revisions used for this build.
- The upstream release workflow uses a signing keystore for release APKs.
  Milestone 1 should use a debug APK and should not require release-signing
  secrets. The verified Flutter build writes `app-debug.apk` and ABI-split APKs
  to `build/app/outputs/flutter-apk/`.
- The Milestone 1 dependency cutover replaces unavailable
  `basic_audio_handler`, `playlist_manager`, `youtipie`, login, and subscription
  packages with local compile-time adapters under `packages/`. The reachable
  translation and party-relay repositories remain submodules; the translation
  gitlink points to a revision containing all app-required English keys. The
  unavailable FFmpeg submodule and its build hooks remain excluded. Dependency
  resolution and the Android debug APK build succeed without upstream
  credentials or a release keystore.

## Dependency boundaries to address

The unavailable upstream dependencies identified above are replacement targets;
this plan does not require recovering or importing their source. Keep reachable
libraries and submodules wired into the build for this milestone; decide later
which should remain in the offline player. Several target packages are imported
across core code, controllers, and UI, so Milestone 1 must either provide their
compile-time types locally or remove the consuming feature paths; changing
`pubspec.yaml` alone will not be sufficient.

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
  `l10n.yaml` and remains as a submodule. `namida-assets` supports
  screenshot/documentation workflows and is not currently referenced as an app
  asset. `party_relay` remains as a reachable path dependency for now; whether
  its feature belongs in the offline player can be decided later.

## Implementation and review approach

Use the smallest boundary that keeps the Android target compiling. Milestone 1
replaces unavailable package references with local compile-time mocks/adapters
while retaining the reachable translation and party-relay submodules. Keep
mocks explicit and behaviorally honest. Milestone 2 replaces the local audio,
playlist, and storage mocks with working implementations.

## Milestone 1 result

The first milestone is implemented on the `chore/buildable-offline-foundation`
branch. The debug build is intentionally only a compile/package acceptance
check; the local playback and playlist adapters are placeholders for Milestone
2, and YouTube/account operations remain unavailable.

The documented build commands are:

```sh
mise exec -- flutter pub get
mise exec -- flutter build apk --debug
```

Initialize the two build-input submodules before those commands in a fresh
checkout:

```sh
git submodule update --init --recursive external/language external/party_relay
```

The verified APK is `build/app/outputs/flutter-apk/app-debug.apk` (about 161 MiB
for the universal build); Flutter also emits split APKs for `arm64-v8a`,
`armeabi-v7a`, and `x86_64`. Android generates the standard debug key locally,
so no private signing material is needed for this milestone. The build was
verified in the current working checkout; a separate clean-clone or device
runtime test was not performed.

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
