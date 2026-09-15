import 'package:flutter/foundation.dart';

import '../models/challan.dart';
import '../services/mparivahan_api_service.dart';

class ChallanSearchProvider extends ChangeNotifier {
  ChallanSearchProvider({required MParivahanApiService apiService})
      : _apiService = apiService;

  final MParivahanApiService _apiService;

  List<Challan> challans = const [];
  String? error;
  bool isLoading = false;

  Future<void> searchChallan(String query) async {
    final normalized = query.trim().toUpperCase().replaceAll(' ', '');
    if (normalized.length < 4) {
      error = 'Enter a valid registration/challan number.';
      challans = const [];
      notifyListeners();
      return;
    }

    isLoading = true;
    error = null;
    notifyListeners();

    try {
      challans = await _apiService.fetchChallanInfo(normalized);
      if (challans.isEmpty) {
        error = 'No challans found.';
      }
    } catch (e) {
      challans = const [];
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
