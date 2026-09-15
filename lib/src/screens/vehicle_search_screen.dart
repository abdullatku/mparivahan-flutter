import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/vehicle_search_provider.dart';

class VehicleSearchScreen extends StatefulWidget {
  const VehicleSearchScreen({super.key});

  @override
  State<VehicleSearchScreen> createState() => _VehicleSearchScreenState();
}

class _VehicleSearchScreenState extends State<VehicleSearchScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Search')),
      body: Consumer<VehicleSearchProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: _controller,
                    textCapitalization: TextCapitalization.characters,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Registration Number',
                      hintText: 'e.g. DL8CAF5039',
                    ),
                    validator: (value) {
                      final text = (value ?? '').trim();
                      if (text.isEmpty) {
                        return 'Registration number is required';
                      }
                      if (text.replaceAll(' ', '').length < 6) {
                        return 'Please enter a valid registration number';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: provider.isLoading
                      ? null
                      : () {
                          if (_formKey.currentState?.validate() ?? false) {
                            provider.searchVehicle(_controller.text);
                          }
                        },
                  child: const Text('Search Vehicle'),
                ),
                if (provider.isLoading) ...[
                  const SizedBox(height: 24),
                  const Center(child: CircularProgressIndicator()),
                ],
                if (provider.error != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    provider.error!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ],
                if (provider.vehicle != null) ...[
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Vehicle Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          _Detail(
                              label: 'Registration',
                              value: provider.vehicle!.registrationNumber),
                          _Detail(label: 'Make', value: provider.vehicle!.make),
                          _Detail(
                              label: 'Model', value: provider.vehicle!.model),
                          _Detail(
                              label: 'Registration Date',
                              value: provider.vehicle!.registrationDate),
                          _Detail(
                              label: 'Fuel Type',
                              value: provider.vehicle!.fuelType),
                          const Divider(),
                          const Text(
                            'Owner Details',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          _Detail(
                              label: 'Name',
                              value: provider.vehicle!.owner.name),
                          _Detail(
                              label: 'Address',
                              value: provider.vehicle!.owner.address),
                          _Detail(
                              label: 'Phone',
                              value: provider.vehicle!.owner.phone),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: [
            TextSpan(
                text: '$label: ',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
