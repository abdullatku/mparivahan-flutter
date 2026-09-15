import 'package:flutter_test/flutter_test.dart';
import 'package:mparivahan_flutter/src/models/challan.dart';
import 'package:mparivahan_flutter/src/models/vehicle.dart';

void main() {
  test('Vehicle.fromJson maps owner and vehicle fields', () {
    final vehicle = Vehicle.fromJson({
      'registration_number': 'DL8CAF5039',
      'make': 'TATA',
      'model': 'NEXON',
      'registration_date': '2022-01-18',
      'fuel_type': 'Petrol',
      'owner': {
        'name': 'Ravi Kumar',
        'address': 'Gurgaon',
        'phone': '98XXXXXX21',
      }
    });

    expect(vehicle.registrationNumber, 'DL8CAF5039');
    expect(vehicle.owner.name, 'Ravi Kumar');
  });

  test('Challan.fromJson maps challan fields', () {
    final challan = Challan.fromJson({
      'challan_number': 'HR26CH1234',
      'vehicle_number': 'DL8CAF5039',
      'violation_type': 'Over Speeding',
      'amount': '1500',
      'date': '2026-06-10',
      'location': 'MG Road',
      'status': 'Unpaid',
    });

    expect(challan.challanNumber, 'HR26CH1234');
    expect(challan.amount, '1500');
  });
}
