import 'dart:async';

import 'package:http/http.dart' as http;

import '../models/challan_record.dart';
import '../models/vehicle_info.dart';

class MParivahanService {
  const MParivahanService({http.Client? client}) : _client = client;

  final http.Client? _client;

  Future<VehicleInfo> fetchVehicleInfo(String registrationNumber) async {
    final normalizedQuery = _normalizeQuery(registrationNumber);
    await Future<void>.delayed(const Duration(milliseconds: 350));

    _client?.close();

    return VehicleInfo(
      registrationNumber: normalizedQuery,
      ownerName: 'Demo Owner',
      vehicleClass: 'LMV',
      fuelType: 'Petrol',
      registrationDate: '12 Apr 2020',
      insuranceValidUntil: '11 Apr 2027',
    );
  }

  Future<List<ChallanRecord>> fetchChallans(String identifier) async {
    final normalizedQuery = _normalizeQuery(identifier);
    await Future<void>.delayed(const Duration(milliseconds: 350));

    final baseRecords = <ChallanRecord>[
      ChallanRecord(
        number: 'CHL-$normalizedQuery-01',
        amount: '₹500',
        issuedOn: '18 Aug 2026',
        status: 'Pending',
        location: 'Hyderabad',
      ),
      ChallanRecord(
        number: 'CHL-$normalizedQuery-02',
        amount: '₹1,000',
        issuedOn: '03 Sep 2026',
        status: 'Paid',
        location: 'Secunderabad',
      ),
    ];

    if (normalizedQuery.endsWith('0')) {
      return <ChallanRecord>[];
    }

    return baseRecords;
  }

  String _normalizeQuery(String input) {
    final normalized = input.trim().toUpperCase();
    if (normalized.isEmpty) {
      throw const FormatException('Enter a value to continue.');
    }
    return normalized;
  }
}
