import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mparivahan_flutter/src/services/mparivahan_api_service.dart';

void main() {
  group('MParivahanApiService.fetchVehicleInfo', () {
    test('parses wrapped map payloads', () async {
      final service = MParivahanApiService(
        useMockData: false,
        vehicleApiEndpoint: 'https://example.com/vehicle',
        client: MockClient(
          (request) async => http.Response(
            jsonEncode({
              'data': {
                'registration_number': 'DL8CAF5039',
                'make': 'TATA',
                'model': 'NEXON',
                'registration_date': '2022-01-18',
                'fuel_type': 'Petrol',
                'owner': {
                  'name': 'Ravi Kumar',
                  'address': 'Gurgaon',
                  'phone': '98XXXXXX21',
                },
              },
            }),
            200,
          ),
        ),
      );

      final vehicle = await service.fetchVehicleInfo('DL8CAF5039');

      expect(vehicle.registrationNumber, 'DL8CAF5039');
      expect(vehicle.owner.name, 'Ravi Kumar');
    });

    test('parses list payloads', () async {
      final service = MParivahanApiService(
        useMockData: false,
        vehicleApiEndpoint: 'https://example.com/vehicle',
        client: MockClient(
          (request) async => http.Response(
            jsonEncode([
              {
                'registration_number': 'TS09AB1234',
                'make': 'TATA',
                'model': 'NEXON',
                'registration_date': '2022-01-18',
                'fuel_type': 'Petrol',
                'owner': {
                  'name': 'Asha',
                  'address': 'Hyderabad',
                  'phone': '98XXXXXX99',
                },
              },
            ]),
            200,
          ),
        ),
      );

      final vehicle = await service.fetchVehicleInfo('TS09AB1234');

      expect(vehicle.registrationNumber, 'TS09AB1234');
      expect(vehicle.owner.address, 'Hyderabad');
    });

    test('throws on non-200 responses', () async {
      final service = MParivahanApiService(
        useMockData: false,
        vehicleApiEndpoint: 'https://example.com/vehicle',
        client: MockClient((request) async => http.Response('failed', 500)),
      );

      expect(
        () => service.fetchVehicleInfo('DL8CAF5039'),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group('MParivahanApiService.fetchChallanInfo', () {
    test('parses top-level list payloads', () async {
      final service = MParivahanApiService(
        useMockData: false,
        challanApiEndpoint: 'https://example.com/challan',
        client: MockClient(
          (request) async => http.Response(
            jsonEncode([
              {
                'challan_number': 'HR26CH1234',
                'vehicle_number': 'DL8CAF5039',
                'violation_type': 'Over Speeding',
                'amount': '1500',
                'date': '2026-06-10',
                'location': 'MG Road',
                'status': 'Unpaid',
              },
            ]),
            200,
          ),
        ),
      );

      final challans = await service.fetchChallanInfo('DL8CAF5039');

      expect(challans, hasLength(1));
      expect(challans.first.challanNumber, 'HR26CH1234');
    });

    test('parses wrapped data payloads', () async {
      final service = MParivahanApiService(
        useMockData: false,
        challanApiEndpoint: 'https://example.com/challan',
        client: MockClient(
          (request) async => http.Response(
            jsonEncode({
              'data': [
                {
                  'challan_number': 'TS09CH4321',
                  'vehicle_number': 'TS09AB1234',
                  'violation_type': 'No Parking',
                  'amount': '500',
                  'date': '2026-07-02',
                  'location': 'Secunderabad',
                  'status': 'Paid',
                },
              ],
            }),
            200,
          ),
        ),
      );

      final challans = await service.fetchChallanInfo('TS09AB1234');

      expect(challans, hasLength(1));
      expect(challans.first.status, 'Paid');
    });

    test('throws on non-200 responses', () async {
      final service = MParivahanApiService(
        useMockData: false,
        challanApiEndpoint: 'https://example.com/challan',
        client: MockClient((request) async => http.Response('failed', 404)),
      );

      expect(
        () => service.fetchChallanInfo('DL8CAF5039'),
        throwsA(isA<ApiException>()),
      );
    });
  });
}
