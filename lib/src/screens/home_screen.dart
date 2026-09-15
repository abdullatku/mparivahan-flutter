import 'package:flutter/material.dart';

import 'challan_search_screen.dart';
import 'vehicle_search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('mParivahan Flutter'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Vehicle'),
              Tab(text: 'Challans'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            VehicleSearchScreen(),
            ChallanSearchScreen(),
          ],
        ),
      ),
    );
  }
}
