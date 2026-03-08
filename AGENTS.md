# AGENTS.md

## Project Overview

- An iOS app that uses NASA APIs
- A multi-module architecture using TCA (The Composable Architecture) and SPM (Swift Package Manager)

## Working Agreement

### Must

- Keep changes scoped to the requested task. Do not mix unrelated refactors.
- Run `swift format` for touched Swift files before finishing.
- Run at least one relevant build or test command after code changes.
- For TCA-related structs/enums, use alphabetical order unless semantic order is required.
- Prefer targeted tests first, then broader tests only when shared modules are changed.

## Common Commands

### List Destinations

```bash
xcodebuild -project NASAClient.xcodeproj -scheme NASAClient -showdestinations
```

### List Targets and Schemes

```bash
xcodebuild -project NASAClient.xcodeproj -list
```

### Resolve Package Dependencies

```bash
xcodebuild -resolvePackageDependencies -project NASAClient.xcodeproj
```

### Build

- Use feature/module scheme when possible (for example, `Models`)
- Use `NASAClient` for full app verification

```bash
xcodebuild \
  -project NASAClient.xcodeproj \
  -scheme <SCHEME> \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -skipPackagePluginValidation \
  -skipMacroValidation \
  build
```

### Test

```bash
xcodebuild \
  -project NASAClient.xcodeproj \
  -scheme <SCHEME> \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -skipPackagePluginValidation \
  -skipMacroValidation \
  test
```

- For narrower validation, use `-only-testing`

```bash
xcodebuild \
  -project NASAClient.xcodeproj \
  -scheme <SCHEME> \
  -destination 'platform=iOS Simulator,name=iPhone 17' \
  -skipPackagePluginValidation \
  -skipMacroValidation \
  -only-testing:<TestTarget[/TestClass[/testMethod]]> \
  test
```

### Format

```bash
swift format . --in-place --recursive --configuration .swift-format
```

## Validation Guide

- UI/View changes: build the related feature scheme and run related feature tests if they exist.
- TCA reducer/state/action changes: run the corresponding feature tests. If shared domain is touched, run broader app-level tests.
- API client/model/decoding changes: run model/API tests and build `NASAClient`.
- Dependency/configuration changes: build `NASAClient` and run `NASAClient` scheme tests when impact is unclear.

## Module-Level Notes

- `Features/*`: keep reducer logic deterministic/testable, and avoid business logic in views.
- `Models`: preserve `Codable` compatibility unless intentionally changed. If contracts change, update tests together.
- `APIClient` and networking modules: keep request/response mapping explicit, with typed errors and stable decoding behavior.
- App composition modules (including `NASAClient` target): keep dependency wiring explicit/minimal, and verify full app build after wiring changes.

## Do Not

- Do not include unrelated formatting or renaming in task-focused PRs.
- Do not bypass tests for changed logic without explaining why.
- Do not introduce silent behavior changes in API decoding.

## Failure Recovery

- If `iPhone 17` simulator is unavailable, run `-showdestinations` and select an available iOS Simulator.
- If build/test fails due to package resolution, run `xcodebuild -resolvePackageDependencies -project NASAClient.xcodeproj`, then retry the original build/test command once.
- If the retry fails, report the exact command and full error output.

## Pre-PR Checklist

- `swift format` applied to touched Swift files.
- Relevant build command passed.
- Relevant test command passed, or skip reason documented.
- Behavioral changes and affected modules documented.
- No unrelated file changes included.
