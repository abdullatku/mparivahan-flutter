class VehicleInfo {
  const VehicleInfo({
    required this.registrationNumber,
    required this.ownerName,
    required this.vehicleClass,
    required this.fuelType,
    required this.registrationDate,
    required this.insuranceValidUntil,
  });

  final String registrationNumber;
  final String ownerName;
  final String vehicleClass;
  final String fuelType;
  final String registrationDate;
  final String insuranceValidUntil;
}
