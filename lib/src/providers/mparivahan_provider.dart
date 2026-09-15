import 'package:flutter/foundation.dart';

import '../models/challan_record.dart';
import '../models/vehicle_info.dart';
import '../services/mparivahan_service.dart';

class MParivahanProvider extends ChangeNotifier {
  MParivahanProvider({required MParivahanService service}) : _service = service;

  final MParivahanService _service;

  bool _isLoadingVehicle = false;
  bool _isLoadingChallans = false;
  String? _vehicleError;
  String? _challanError;
  VehicleInfo? _vehicleInfo;
  List<ChallanRecord> _challans = const <ChallanRecord>[];

  bool get isLoadingVehicle => _isLoadingVehicle;
  bool get isLoadingChallans => _isLoadingChallans;
  String? get vehicleError => _vehicleError;
  String? get challanError => _challanError;
  VehicleInfo? get vehicleInfo => _vehicleInfo;
  List<ChallanRecord> get challans => _challans;

  Future<void> lookupVehicle(String registrationNumber) async {
    _isLoadingVehicle = true;
    _vehicleError = null;
    notifyListeners();

    try {
      _vehicleInfo = await _service.fetchVehicleInfo(registrationNumber);
    } on FormatException catch (error) {
      _vehicleInfo = null;
      _vehicleError = error.message;
    } catch (_) {
      _vehicleInfo = null;
      _vehicleError = 'Unable to fetch vehicle details right now.';
    } finally {
      _isLoadingVehicle = false;
      notifyListeners();
    }
  }

  Future<void> lookupChallans(String identifier) async {
    _isLoadingChallans = true;
    _challanError = null;
    notifyListeners();

    try {
      _challans = await _service.fetchChallans(identifier);
    } on FormatException catch (error) {
      _challans = const <ChallanRecord>[];
      _challanError = error.message;
    } catch (_) {
      _challans = const <ChallanRecord>[];
      _challanError = 'Unable to fetch challan data right now.';
    } finally {
      _isLoadingChallans = false;
      notifyListeners();
    }
  }
}
