class Owner {
  const Owner({
    required this.name,
    required this.address,
    required this.phone,
  });

  final String name;
  final String address;
  final String phone;

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      name: (json['name'] ?? json['owner_name'] ?? 'N/A').toString(),
      address: (json['address'] ?? json['owner_address'] ?? 'N/A').toString(),
      phone: (json['phone'] ?? json['owner_phone'] ?? 'N/A').toString(),
    );
  }
}
