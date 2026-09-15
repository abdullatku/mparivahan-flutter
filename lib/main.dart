import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/providers/mparivahan_provider.dart';
import 'src/screens/home_screen.dart';
import 'src/services/mparivahan_service.dart';

void main() {
  runApp(const MParivahanApp());
}

class MParivahanApp extends StatelessWidget {
  const MParivahanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MParivahanProvider(
        service: const MParivahanService(),
      ),
      child: MaterialApp(
        title: 'mParivahan Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          scaffoldBackgroundColor: const Color(0xFFF5F7FB),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
