import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../models/challan.dart';
import '../models/vehicle.dart';

class ApiException implements Exception {
  ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class MParivahanApiService {
  MParivahanApiService({
    http.Client? client,
    bool? useMockData,
    String? vehicleApiEndpoint,
    String? challanApiEndpoint,
  })  : _client = client ?? http.Client(),
        _useMockData = useMockData ?? AppConfig.useMockData,
        _vehicleApiEndpoint =
            vehicleApiEndpoint ?? AppConfig.vehicleApiEndpoint,
        _challanApiEndpoint =
            challanApiEndpoint ?? AppConfig.challanApiEndpoint;

  final http.Client _client;
  final bool _useMockData;
  final String _vehicleApiEndpoint;
  final String _challanApiEndpoint;

  Future<Vehicle> fetchVehicleInfo(String registrationNumber) async {
    if (_useMockData || _vehicleApiEndpoint.isEmpty) {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      return _mockVehicle(registrationNumber);
    }

    final uri = Uri.parse(_vehicleApiEndpoint).replace(
      queryParameters: {'registration_number': registrationNumber},
    );

    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw ApiException(
          'Vehicle API failed with status ${response.statusCode}.');
    }

    final decoded = _decodeJson(response.body);
    if (decoded is Map) {
      final decodedMap = _toJsonMap(decoded);
      final data = decodedMap['data'];
      if (data is Map) {
        return Vehicle.fromJson(_toJsonMap(data));
      }
      if (data is List && data.isNotEmpty) {
        return Vehicle.fromJson(_toJsonMap(data.first));
      }
      return Vehicle.fromJson(decodedMap);
    }
    if (decoded is List && decoded.isNotEmpty) {
      return Vehicle.fromJson(_toJsonMap(decoded.first));
    }

    throw ApiException('Unexpected vehicle API response format.');
  }

  Future<List<Challan>> fetchChallanInfo(String query) async {
    if (_useMockData || _challanApiEndpoint.isEmpty) {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      return _mockChallans(query);
    }

    final uri = Uri.parse(_challanApiEndpoint).replace(
      queryParameters: {'query': query},
    );

    final response = await _client.get(uri, headers: _headers);
    if (response.statusCode != 200) {
      throw ApiException(
          'Challan API failed with status ${response.statusCode}.');
    }

    final decoded = _decodeJson(response.body);
    if (decoded is List) {
      return _toChallanList(decoded);
    }
    if (decoded is Map) {
      final decodedMap = _toJsonMap(decoded);
      final data = decodedMap['data'];
      if (data is List) {
        return _toChallanList(data);
      }
      if (data is Map) {
        return [Challan.fromJson(_toJsonMap(data))];
      }
    }

    throw ApiException('Unexpected challan API response format.');
  }

  List<Challan> _toChallanList(List<dynamic> decoded) {
    return decoded
        .map(_toJsonMap)
        .map(Challan.fromJson)
        .toList(growable: false);
  }

  Map<String, dynamic> _toJsonMap(Object? value) {
    if (value is Map) {
      return value.map(
        (key, value) => MapEntry(key.toString(), value),
      );
    }
    throw ApiException('Unexpected response item format.');
  }

  Object? _decodeJson(String body) {
    try {
      return jsonDecode(body);
    } on FormatException {
      throw ApiException('Unexpected response body format.');
    }
  }

  Map<String, String> get _headers {
    if (AppConfig.apiKey.isEmpty) {
      return const {'Accept': 'application/json'};
    }
    return {
      'Accept': 'application/json',
      'x-api-key': AppConfig.apiKey,
    };
  }

  Vehicle _mockVehicle(String registrationNumber) {
    return Vehicle.fromJson({
      'registration_number': registrationNumber,
      'make': 'TATA',
      'model': 'NEXON',
      'registration_date': '2022-01-18',
      'fuel_type': 'Petrol',
      'owner': {
        'name': 'Ravi Kumar',
        'address': 'Sector 45, Gurgaon, Haryana',
        'phone': '98XXXXXX21',
      },
    });
  }

  List<Challan> _mockChallans(String query) {
    final normalized = query.toUpperCase();
    final records = [
      {
        'challan_number': 'HR26CH1234',
        'vehicle_number': normalized,
        'violation_type': 'Over Speeding',
        'amount': '1500',
        'date': '2026-06-10',
        'location': 'MG Road, Gurugram',
        'status': 'Unpaid',
      },
      {
        'challan_number': 'DL8CAF9991',
        'vehicle_number': normalized,
        'violation_type': 'No Parking Zone',
        'amount': '500',
        'date': '2026-07-02',
        'location': 'Connaught Place, New Delhi',
        'status': 'Paid',
      },
    ];

    return records.map(Challan.fromJson).toList(growable: false);
  }
}
