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

Use `xcodebuild` for build, test, and dependency resolution. Always pass `-skipPackagePluginValidation -skipMacroValidation` to avoid plugin-related failures. Target `iPhone 17` simulator unless unavailable.

- Build/test with the narrowest relevant scheme (e.g. `Models`, `AppFeature`); use `NASAClient` for full app verification.
- For narrower test runs, use `-only-testing`.
- Format: `swift format . --in-place --recursive --configuration .swift-format`

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
