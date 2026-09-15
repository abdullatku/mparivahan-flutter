class AppConfig {
  static const String vehicleApiEndpoint =
      String.fromEnvironment('VEHICLE_API_ENDPOINT', defaultValue: '');
  static const String challanApiEndpoint =
      String.fromEnvironment('CHALLAN_API_ENDPOINT', defaultValue: '');
  static const String apiKey =
      String.fromEnvironment('MPARIVAHAN_API_KEY', defaultValue: '');

  static const bool useMockData =
      String.fromEnvironment('USE_MOCK_DATA', defaultValue: 'true') == 'true';
}
