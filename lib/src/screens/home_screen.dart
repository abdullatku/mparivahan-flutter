import 'package:flutter/material.dart';

import 'challan_search_screen.dart';
import 'vehicle_search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('mParivahan')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _HomeActionCard(
              icon: Icons.directions_car_filled,
              title: 'Vehicle Information Search',
              subtitle: 'Find registration and owner details',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const VehicleSearchScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _HomeActionCard(
              icon: Icons.receipt_long,
              title: 'Challan Information Search',
              subtitle: 'Find traffic challans by vehicle/challan number',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const ChallanSearchScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeActionCard extends StatelessWidget {
  const _HomeActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Semantics(
        button: true,
        child: ListTile(
          leading: Icon(icon, size: 32),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        ),
      ),
    );
  }
}
