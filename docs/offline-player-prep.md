# Namida offline-player fork: preparation audit

Audit snapshot: upstream `main` at `dc2c96c598d1e9cd6616cf228c17011e23555d9a` (2026-10-30).

This is a planning and build-dependency audit only. No app implementation has been changed and no APK build has been verified.

## Goal and boundaries

The target is an Android app that a user can build from source for personal use.

- **Milestone 1 — buildable:** a clean checkout can resolve its declared build inputs and `flutter build apk --debug` produces an APK. App behavior is not an acceptance criterion for this milestone.
- **Milestone 2 — offline player:** local audio can be indexed/imported and played, with queue controls and persistent playlist create/edit behavior. YouTube, account login, subscriptions, and remote-party functionality are out of scope.
- **Milestone 3 — parity:** deferred; it is not needed for the offline-player goal.

For Milestone 2, “import” is provisionally treated as indexing local audio and importing selected local files. Importing playlists or backups is a separate feature unless later included explicitly.

## Repository and build findings

- The Android target is the first supported build target for this effort. The manifest declares Flutter `3.47.8` and Dart `>=3.13.7`; Android is configured with min SDK 26 and target/compile SDK 36.
- This clone has four uninitialized submodules: `external/ffmpeg_build`, `external/language`, `external/namida-assets`, and `external/party_relay`. A normal `git clone` does not populate them. The FFmpeg Flutter hook directly expects an Android AAR under `external/ffmpeg_build/ffmpegkit/`.
- Upstream CI initializes submodules recursively with `--remote`, then runs `flutter pub upgrade`. It also installs GitHub credentials for repositories under `namidaco` and `MSOB7YY`. That is evidence the upstream build depends on extra repository access; it does not establish which individual dependencies are public or private.
- There is no tracked `pubspec.lock`, and `.gitignore` ignores it. Several Git dependencies have no pinned `ref`, so the exact resolved dependency set is not fixed by this checkout.
- The upstream release workflow uses a signing keystore for release APKs. Milestone 1 should use a debug APK and should not require release-signing secrets.
- The current workspace could not check the Flutter version: its `flutter` launcher delegates to `fvm`, which is unavailable here, and no project mise configuration was found. This is an environment blocker; no `flutter pub get` or APK build has been attempted.

## Dependency boundaries to address

These packages are declared as external Git dependencies rather than source contained in this repository. Each package and artifact still needs its own source-access and license check; a Git URL alone does not establish that it is proprietary or freely redistributable.

- **Local playback:** `basic_audio_handler` supplies the base audio handler used by `lib/base/audio_handler.dart` and `lib/controller/player_controller.dart`. A temporary Milestone 1 stub is acceptable, but Milestone 2 needs a real implementation for local playback and the required background controls.
- **Playlists and persistence:** `playlist_manager` is the base of `PlaylistController`; `namico_db_wrapper` is used by the playlist, indexer, and player controllers. These are core to the Milestone 2 result and need functional open implementations or replacements, not permanent no-op stubs.
- **YouTube and membership:** `youtipie`, `namico_login_manager`, and `namico_subscription_manager` support online YouTube and membership paths. Login and membership can be removed from the offline target. YouTube model types are also imported by the current audio handler and player controller, so removing the network feature will require separating shared local-player types from YouTube/video types.
- **Media/build artifacts:** `ffmpeg_kit_extended_flutter` and `namida_waveform` use inputs from `external/ffmpeg_build`. The offline target should retain only media operations needed for local indexing/playback; remaining metadata and waveform paths need to be checked before deciding whether to replace or disable FFmpeg.
- **Assets and translations:** the `namida-assets` and `language` submodules may be required for a complete build. Their contents and licenses are part of the build-input audit. The `party_relay` submodule is outside the offline-player scope unless some shared code imports it unconditionally.

## Implementation and review approach

Use the smallest boundary that keeps the Android target compiling. Milestone 1 may use temporary, clearly unavailable adapters/stubs for features being removed. They must not fabricate membership or YouTube success. Milestone 2 replaces stubs on the local audio, playlist, and storage paths with working implementations.

Organize changes by app subsystem, not strictly one PR per package. Keep the default branch buildable: merge each coherent change only when the Android build passes, or keep interdependent work stacked until the combined change is green. Avoid both a single unreviewable rewrite and merged intermediate states that cannot build.

## Verification criteria

### Milestone 1

From a clean checkout with only documented, available prerequisites:

1. Resolve dependencies without private credentials or untracked local artifacts.
2. Build with `flutter build apk --debug`.
3. Confirm the APK exists at `build/app/outputs/flutter-apk/app-debug.apk`.

Installation and runtime behavior are diagnostic only for this milestone, as agreed.

### Milestone 2

On an Android device or emulator, with networking disabled:

1. Grant audio access and index local files; confirm selected-file import if retained in scope.
2. Play, pause, seek, skip, and reorder/clear the queue using in-app controls.
3. Create a playlist, add and remove tracks, restart the app, and verify the playlist persists.
4. Verify background playback and notification/lock-screen controls if they remain part of the “basic player” definition.
5. Confirm no YouTube account, membership, or party service is needed for these paths.

## Source-hosting and license note

GitHub reports `Lucartas/namida` as a **public** fork. The upstream `LICENSE` permits personal compilation/modification but also says not to redistribute the Software, modified or unmodified. A source-only public fork is a separate hosting/licensing question from distributing an APK; this audit does not resolve it. No changes from this branch have been pushed.
