import 'package:flutter/foundation.dart';

import '../models/vehicle.dart';
import '../services/mparivahan_api_service.dart';

class VehicleSearchProvider extends ChangeNotifier {
  VehicleSearchProvider({required MParivahanApiService apiService})
      : _apiService = apiService;

  final MParivahanApiService _apiService;

  Vehicle? vehicle;
  String? error;
  bool isLoading = false;

  Future<void> searchVehicle(String registrationNumber) async {
    final normalized =
        registrationNumber.trim().toUpperCase().replaceAll(' ', '');
    if (!_isValidRegistration(normalized)) {
      error = 'Enter a valid vehicle registration number.';
      vehicle = null;
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      vehicle = await _apiService.fetchVehicleInfo(normalized);
    } catch (e) {
      vehicle = null;
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  bool _isValidRegistration(String value) {
    return RegExp(r'^[A-Z0-9]{6,15}$').hasMatch(value);
  }
}
