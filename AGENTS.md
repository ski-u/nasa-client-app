# AGENTS.md

## Project Overview

- An iOS app that uses NASA APIs
- A multi-module architecture using TCA (The Composable Architecture) and SPM (Swift Package Manager)

## Common Command Examples

### List Available Destinations

```bash
xcodebuild -project NASAClient.xcodeproj -scheme NASAClient -showdestinations
```

### List Available Targets, Configs, and Schemes

```bash
xcodebuild -project NASAClient.xcodeproj -list
```

### Build

- About `SCHEME`
  - Specify the scheme you want to build (for example, `Models`)
  - To build the entire app, specify `NASAClient`

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

- If you want to specify tests more precisely, use `-only-testing`

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

## Code Convention

- Unless order has semantic meaning, define TCA-related struct properties and enum cases in alphabetical order
