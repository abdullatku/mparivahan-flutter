import 'owner.dart';

class Vehicle {
  const Vehicle({
    required this.registrationNumber,
    required this.make,
    required this.model,
    required this.registrationDate,
    required this.fuelType,
    required this.owner,
  });

  final String registrationNumber;
  final String make;
  final String model;
  final String registrationDate;
  final String fuelType;
  final Owner owner;

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    final ownerValue = json['owner'];
    final ownerJson = ownerValue is Map
        ? ownerValue.map((key, value) => MapEntry(key.toString(), value))
        : json;

    return Vehicle(
      registrationNumber:
          (json['registration_number'] ?? json['rc_number'] ?? 'N/A')
              .toString(),
      make: (json['make'] ?? json['brand'] ?? 'N/A').toString(),
      model: (json['model'] ?? json['vehicle_model'] ?? 'N/A').toString(),
      registrationDate:
          (json['registration_date'] ?? json['reg_date'] ?? 'N/A').toString(),
      fuelType: (json['fuel_type'] ?? json['fuel'] ?? 'N/A').toString(),
      owner: Owner.fromJson(ownerJson),
    );
  }
}
