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
