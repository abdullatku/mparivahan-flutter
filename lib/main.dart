import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/providers/challan_search_provider.dart';
import 'src/providers/vehicle_search_provider.dart';
import 'src/screens/home_screen.dart';
import 'src/services/mparivahan_api_service.dart';

void main() {
  final apiService = MParivahanApiService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VehicleSearchProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (_) => ChallanSearchProvider(apiService: apiService),
        ),
      ],
      child: const MParivahanApp(),
    ),
  );
}

class MParivahanApp extends StatelessWidget {
  const MParivahanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'mParivahan Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
