import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/challan_search_provider.dart';

class ChallanSearchScreen extends StatefulWidget {
  const ChallanSearchScreen({super.key});

  @override
  State<ChallanSearchScreen> createState() => _ChallanSearchScreenState();
}

class _ChallanSearchScreenState extends State<ChallanSearchScreen> {
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
      appBar: AppBar(title: const Text('Challan Search')),
      body: Consumer<ChallanSearchProvider>(
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
                      labelText: 'Registration/Challan Number',
                      hintText: 'e.g. DL8CAF5039 or HR26CH1234',
                    ),
                    validator: (value) {
                      final text = (value ?? '').trim();
                      if (text.isEmpty) return 'Input is required';
                      if (text.replaceAll(' ', '').length < 4) {
                        return 'Please enter a valid value';
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
                            provider.searchChallan(_controller.text);
                          }
                        },
                  child: const Text('Search Challan'),
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
                if (provider.challans.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  ...provider.challans.map(
                    (challan) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Challan ${challan.challanNumber}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            _Detail(
                                label: 'Vehicle', value: challan.vehicleNumber),
                            _Detail(
                                label: 'Violation',
                                value: challan.violationType),
                            _Detail(
                                label: 'Amount', value: '₹${challan.amount}'),
                            _Detail(label: 'Date', value: challan.date),
                            _Detail(label: 'Location', value: challan.location),
                            _Detail(label: 'Status', value: challan.status),
                          ],
                        ),
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
