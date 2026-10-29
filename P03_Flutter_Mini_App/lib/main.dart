import 'package:flutter/material.dart';

import 'screens/equipment_list_screen.dart';

void main() => runApp(const RentalOutdoorApp());

class RentalOutdoorApp extends StatelessWidget {
  const RentalOutdoorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental Outdoor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const EquipmentListScreen(),
    );
  }
}
