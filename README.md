# mparivahan-flutter

A Flutter mobile app that mimics core mParivahan flows:
- Vehicle information search (with owner details)
- Challan information search

## Features
- Home screen with navigation to Vehicle Search and Challan Search
- Vehicle search by registration number with validation, loading and error states
- Vehicle detail card (registration, make, model, registration date, fuel type)
- Owner detail section (name, address, phone)
- Challan search by registration number or challan number
- Challan list with violation type, amount, date, location, status
- Provider-based state management and clean separation (`models`, `services`, `providers`, `screens`)
- Configurable API endpoints via environment values, with documented mock fallback
- Automated Android release APK generation through GitHub Actions

## Configuration
Pass runtime environment values with `--dart-define`:

- `VEHICLE_API_ENDPOINT` (e.g. `https://example.gov/api/vehicle`)
- `CHALLAN_API_ENDPOINT` (e.g. `https://example.gov/api/challan`)
- `MPARIVAHAN_API_KEY` (if required by API)
- `USE_MOCK_DATA` (`true`/`false`, defaults to `true`)

Example:

```bash
flutter run \
  --dart-define=USE_MOCK_DATA=false \
  --dart-define=VEHICLE_API_ENDPOINT=https://example.gov/api/vehicle \
  --dart-define=CHALLAN_API_ENDPOINT=https://example.gov/api/challan \
  --dart-define=MPARIVAHAN_API_KEY=your_api_key
```

If `USE_MOCK_DATA=true` or endpoints are not configured, the app uses local mock responses.

## Android release APK build

### Release configuration
- Android app ID: `com.abdullatku.mparivahan_flutter`
- App version: `1.0.0+1` (`versionName=1.0.0`, `versionCode=1`)
- Release signing: demo release builds reuse the Android debug keystore (`androiddebugkey` / `android`)
- Code shrinking: R8/ProGuard enabled with resource shrinking for release APKs
- Obfuscation: enabled in CI with `--obfuscate` and symbol output stored as an artifact

### Build locally
1. Install Flutter and Android SDK tooling.
2. Refresh or generate Android platform files if needed:
   ```bash
   flutter create --platforms=android .
   ```
3. Create the demo signing key if `~/.android/debug.keystore` does not already exist:
   ```bash
   keytool -genkeypair -v \
     -keystore "$HOME/.android/debug.keystore" \
     -storepass android \
     -alias androiddebugkey \
     -keypass android \
     -keyalg RSA \
     -keysize 2048 \
     -validity 10000 \
     -dname "CN=Android Debug,O=Android,C=US"
   ```
4. Install packages and build the release APK:
   ```bash
   flutter pub get
   flutter build apk --release --obfuscate --split-debug-info=build/app/outputs/symbols
   ```
5. Collect the APK from `build/app/outputs/flutter-apk/app-release.apk`.

### Automated GitHub builds
The workflow in `.github/workflows/release.yml` runs on:
- every `push`
- published GitHub `release` events
- manual `workflow_dispatch`

Workflow outputs:
- APK artifact name: `mparivahan-<versionName>+<versionCode>-release.apk`
- APK artifact path: `build/app/outputs/flutter-apk/`
- Obfuscation symbols artifact path: `build/app/outputs/symbols`

Download locations:
- GitHub Actions artifacts: https://github.com/abdullatku/mparivahan-flutter/actions/workflows/release.yml
- GitHub Releases: https://github.com/abdullatku/mparivahan-flutter/releases

### Install the APK on an Android device
1. Download the latest APK from the Actions artifact or the matching GitHub release.
2. Copy the APK to your Android device if it was downloaded on a computer.
3. On Android, allow app installs from the browser or file manager when prompted.
4. Open the APK and tap **Install**.
5. Launch **mParivahan** from the app drawer after installation completes.

### Release notes
Current release build highlights:
- Vehicle and challan search flows with mock-data fallback
- Provider-based app state management
- Release APKs signed for demo distribution
- R8 shrinking and Dart obfuscation enabled for smaller production-ready artifacts
