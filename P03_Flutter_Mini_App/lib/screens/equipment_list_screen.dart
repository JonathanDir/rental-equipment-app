import 'package:flutter/material.dart';

import '../models/equipment.dart';
import '../widgets/equipment_card.dart';
import 'add_equipment_screen.dart';
import 'equipment_detail_screen.dart';

class EquipmentListScreen extends StatefulWidget {
  const EquipmentListScreen({super.key});

  @override
  State<EquipmentListScreen> createState() => _EquipmentListScreenState();
}

class _EquipmentListScreenState extends State<EquipmentListScreen> {
  final List<Equipment> _equipment = [...sampleEquipment];

  Future<void> _openDetail(Equipment equipment) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => EquipmentDetailScreen(equipment: equipment),
      ),
    );
  }

  Future<void> _openAddForm() async {
    final newEquipment = await Navigator.of(context).push<Equipment>(
      MaterialPageRoute<Equipment>(
        builder: (_) => const AddEquipmentScreen(),
      ),
    );

    if (!mounted || newEquipment == null) return;

    setState(() {
      _equipment.add(newEquipment);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rental Alat Outdoor'),
        actions: [
          IconButton(
            tooltip: 'Tambah item',
            onPressed: _openAddForm,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Daftar perlengkapan: ${_equipment.length}'),
            ),
          ),
          Expanded(
            child: _equipment.isEmpty
                ? const Center(child: Text('Belum ada item rental.'))
                : ListView.builder(
                    itemCount: _equipment.length,
                    itemBuilder: (context, index) {
                      final equipment = _equipment[index];
                      return EquipmentCard(
                        equipment: equipment,
                        onTap: () => _openDetail(equipment),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
