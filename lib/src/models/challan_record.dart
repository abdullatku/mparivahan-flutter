class ChallanRecord {
  const ChallanRecord({
    required this.number,
    required this.amount,
    required this.issuedOn,
    required this.status,
    required this.location,
  });

  final String number;
  final String amount;
  final String issuedOn;
  final String status;
  final String location;
}
