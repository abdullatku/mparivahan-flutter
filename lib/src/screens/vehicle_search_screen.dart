import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mparivahan_provider.dart';

class VehicleSearchScreen extends StatefulWidget {
  const VehicleSearchScreen({super.key});

  @override
  State<VehicleSearchScreen> createState() => _VehicleSearchScreenState();
}

class _VehicleSearchScreenState extends State<VehicleSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MParivahanProvider>(
      builder: (context, provider, _) {
        final vehicle = provider.vehicleInfo;

        return ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            const Text(
              'Search a vehicle by registration number to view sample ownership data.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Registration number',
                hintText: 'TS09AB1234',
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: provider.isLoadingVehicle
                  ? null
                  : () => provider.lookupVehicle(_controller.text),
              child: provider.isLoadingVehicle
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Get vehicle details'),
            ),
            if (provider.vehicleError != null) ...<Widget>[
              const SizedBox(height: 12),
              Text(
                provider.vehicleError!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            if (vehicle != null) ...<Widget>[
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(vehicle.registrationNumber,
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      _DetailRow(label: 'Owner', value: vehicle.ownerName),
                      _DetailRow(label: 'Class', value: vehicle.vehicleClass),
                      _DetailRow(label: 'Fuel', value: vehicle.fuelType),
                      _DetailRow(
                        label: 'Registered on',
                        value: vehicle.registrationDate,
                      ),
                      _DetailRow(
                        label: 'Insurance valid until',
                        value: vehicle.insuranceValidUntil,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(width: 150, child: Text(label)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
