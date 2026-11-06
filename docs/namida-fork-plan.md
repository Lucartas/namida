# Namida offline-player fork: preparation audit

## Goal and boundaries

- **Milestone 1 — buildable mocks (complete):** replace unavailable upstream
  package dependencies with small local mocks/adapters sufficient to compile,
  then produce a debug APK without upstream credentials. APK packaging is the
  acceptance criterion; whether the app starts or later crashes is out of
  scope. Unsupported mock calls must fail clearly rather than pretend to work.
  The initial build passed on 2026-10-31 with `mise exec -- flutter pub get`
  and `mise exec -- flutter build apk --debug`; debug and release Gradle builds
  have since passed with the local signing files configured. A clean clone
  without those ignored files has not been revalidated.
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

- The Android target is the first supported build target. `mise.toml` and
  `mise.lock` pin Flutter `3.47.8` (Dart `3.13.7`), Temurin Java 17, and Rust
  `1.99.1`. Android is configured with min SDK 26 and target/compile SDK 36;
  the local machine has Android SDK platform 36/build-tools 36.1.0. The project
  uses Gradle 8.14, Android Gradle Plugin 8.11.1, Kotlin 2.2.20, and Java/Kotlin
  toolchain 17.
- The upstream configuration lists four submodules. This fork keeps the three
  reachable repositories in `.gitmodules`: `external/language`,
  `external/party_relay`, and `external/namida-assets`. The original language
  gitlink was 292 English keys behind the app; `external/language` is therefore
  pinned to the reachable remote revision
  `d2d00cd0d4233c245ae869571afef14bbbf131a6`, while `external/party_relay`
  stays at its original pinned revision. Localization generation reads
  `external/language/translations`, and `pubspec.yaml` uses
  `external/party_relay/dart`. The `ffmpeg_build` URL returns “Repository not
  found”, so its gitlink and `.gitmodules` entry were removed. Old, non-Android
  scripts still contain references to that path.
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
  expected unavailable upstream inputs under the replacement plan, not an
  access problem to solve by obtaining credentials. Milestone 1 now replaces
  those package dependencies with local compile-time adapters under
  `packages/`; the fork no longer depends on those unavailable repositories.
  `namico_db_wrapper` and `namida_waveform` were reachable in the same checks;
  their Milestone 2 status should be decided from their use, not inferred from
  reachability.
- The fork ignores `pubspec.lock`, following the upstream ignore policy, so Pub
  dependency versions are not fixed by a tracked lockfile. `mise.lock` pins the
  project tool versions. Git dependencies without pinned `ref` values remain a
  dependency-resolution risk.
- Android signing is configured from local `android/key.properties` and
  `android/key.jks`, both ignored by Git. The configured keystore is used for
  debug and release builds. `assembleDebug` and `assembleRelease` have passed
  locally; these checks used the ignored signing files, so a clean clone
  without them has not been tested. No device install or runtime test has been
  performed.
- The Milestone 1 dependency cutover replaced unavailable
  `basic_audio_handler`, `playlist_manager`, `youtipie`, login, and subscription
  packages with local compile-time adapters under `packages/`. The reachable
  translation and party-relay repositories remain submodules; the translation
  gitlink points to a revision containing all app-required English keys. The
  unavailable FFmpeg submodule remains removed. Dependency resolution and both
  Android debug and release APK builds pass without upstream credentials, using
  the local ignored signing files described above.

## Dependency boundaries and remaining work

Milestone 1's dependency cutover is complete; recovering the unavailable package
sources is not required. Keep the reachable libraries and submodules wired into
the build for now, and decide which belong in the offline player during
Milestone 2. The local packages provide compile-time types across core code,
controllers, and UI; changing `pubspec.yaml` alone would not replace those
interfaces.

- **Local playback:** `basic_audio_handler` supplies types used across the
  player, settings, and UI. Its local adapter currently provides compile-time
  support only. Milestone 2 replaces it with real local playback and required
  background controls.
- **Playlists and persistence:** `playlist_manager` is the base of
  `PlaylistController`; `namico_db_wrapper` is used by playlist, indexer, and
  player controllers. The local mock surface compiles; Milestone 2 replaces the
  local playlist/storage paths with functional implementations, not permanent
  no-op stubs.
- **YouTube and membership:** `youtipie`, `namico_login_manager`, and
  `namico_subscription_manager` support online YouTube and membership paths and
  are out of scope for the offline target. Local compile-time model mocks keep
  the app buildable; those paths remain unavailable and must not report
  simulated login, subscription, or YouTube success. Keep shared types used by
  the player separate from the local-player model.
- **Media/build artifacts:** the old `external/ffmpeg_build` submodule is
  unavailable and is no longer an Android build input; some legacy scripts
  still mention it. FFmpeg execution code remains in the app. The upstream
  `namida_waveform` repository is reachable (HEAD checked at
  `226bab7f013f51770f991bdd3e895edd8313cffd`) and contains the native waveform,
  spectrum, rhythm, lossless-check, and palette implementation. Its build hook
  compiles native code and links against `libffmpegkit`, using build metadata
  supplied by the real `ffmpeg_kit_extended_flutter` package. This branch's
  local `ffmpeg_kit_extended_flutter` package is compile-only and supplies
  neither that hook metadata nor the native library. The upstream waveform
  package also declares the real FFmpeg package as a Git dependency, while the
  app currently selects the local package at the same package name; restoring
  only the waveform dependency therefore does not restore a compatible build
  graph. Reintroducing waveform support requires resolving that FFmpeg package
  and its native artifacts as a separate task. This dependency combination has
  not been build-tested. Before Milestone 2, decide which media operations local
  indexing/playback require and whether they need a replacement implementation.
- **Assets and translations:** `language` is required by code generation through
  `l10n.yaml` and remains as a submodule. `namida-assets` supports
  screenshot/documentation workflows and is not currently referenced as an app
  asset. `party_relay` remains as a reachable path dependency for now; whether
  its feature belongs in the offline player can be decided later.

## Implementation and review approach

Use the smallest boundary that keeps the Android target compiling. Milestone 1
replaced unavailable package references with local compile-time mocks/adapters
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
(cd android && mise exec -- ./gradlew assembleDebug)
(cd android && mise exec -- ./gradlew assembleRelease)
```

Initialize the two build-input submodules before those commands in a fresh
checkout:

```sh
git submodule update --init --recursive external/language external/party_relay
```

The verified universal APKs are under `build/app/outputs/apk/debug/` and
`build/app/outputs/apk/release/`, with ABI-specific APKs beside them. The local
signing files must be provisioned before building; they are not committed. The
builds were verified in the current working checkout; a separate clean-clone
build and device runtime test were not performed.

Organize changes by app subsystem, not strictly one PR per package. Keep the
default branch buildable: merge each coherent change only when the Android build
passes, or keep interdependent work stacked until the combined change is green.
Avoid both a single unreviewable rewrite and merged intermediate states that
cannot build.

## Verification criteria

### Milestone 1

From a checkout with the documented toolchain, Android SDK, required submodules,
and local signing files provisioned:

1. Resolve dependencies without closed-source upstream credentials or artifacts.
2. Build with `mise exec -- ./gradlew assembleDebug` from `android/`.
3. Confirm a universal and ABI-split debug APK exist under
   `build/app/outputs/apk/debug/`.

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
