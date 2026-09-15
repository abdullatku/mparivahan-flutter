class Challan {
  const Challan({
    required this.challanNumber,
    required this.vehicleNumber,
    required this.violationType,
    required this.amount,
    required this.date,
    required this.location,
    required this.status,
  });

  final String challanNumber;
  final String vehicleNumber;
  final String violationType;
  final String amount;
  final String date;
  final String location;
  final String status;

  factory Challan.fromJson(Map<String, dynamic> json) {
    return Challan(
      challanNumber: (json['challan_number'] ?? json['id'] ?? 'N/A').toString(),
      vehicleNumber:
          (json['vehicle_number'] ?? json['registration_number'] ?? 'N/A')
              .toString(),
      violationType:
          (json['violation_type'] ?? json['offense'] ?? 'N/A').toString(),
      amount: (json['amount'] ?? json['fine_amount'] ?? '0').toString(),
      date: (json['date'] ?? json['violation_date'] ?? 'N/A').toString(),
      location: (json['location'] ?? json['place'] ?? 'N/A').toString(),
      status: (json['status'] ?? 'Unpaid').toString(),
    );
  }
}
