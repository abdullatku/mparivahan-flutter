import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/mparivahan_provider.dart';

class ChallanSearchScreen extends StatefulWidget {
  const ChallanSearchScreen({super.key});

  @override
  State<ChallanSearchScreen> createState() => _ChallanSearchScreenState();
}

class _ChallanSearchScreenState extends State<ChallanSearchScreen> {
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
        return ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            const Text(
              'Search by vehicle number or challan identifier to view sample challan results.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Vehicle or challan number',
                hintText: 'TS09AB1234',
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: provider.isLoadingChallans
                  ? null
                  : () => provider.lookupChallans(_controller.text),
              child: provider.isLoadingChallans
                  ? const SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Check challans'),
            ),
            if (provider.challanError != null) ...<Widget>[
              const SizedBox(height: 12),
              Text(
                provider.challanError!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            if (!provider.isLoadingChallans &&
                provider.challanError == null &&
                provider.challans.isEmpty) ...<Widget>[
              const SizedBox(height: 20),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No challans found yet. Search using a sample number to load results.',
                  ),
                ),
              ),
            ],
            ...provider.challans.map(
              (challan) => Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Card(
                  child: ListTile(
                    title: Text(challan.number),
                    subtitle: Text('${challan.location} • ${challan.issuedOn}'),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(challan.amount),
                        Text(challan.status),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
