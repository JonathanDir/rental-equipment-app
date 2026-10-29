import 'package:flutter/material.dart';

import '../models/equipment.dart';

class EquipmentDetailScreen extends StatelessWidget {
  const EquipmentDetailScreen({super.key, required this.equipment});

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    final status = equipment.isAvailable ? 'Tersedia' : 'Sedang disewa';

    return Scaffold(
      appBar: AppBar(title: Text(equipment.name)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Icon(Icons.backpack_outlined, size: 96),
          const SizedBox(height: 24),
          Text(
            equipment.name,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          _DetailRow(label: 'Kategori', value: equipment.category),
          _DetailRow(
            label: 'Harga sewa',
            value: 'Rp${equipment.dailyRate.toStringAsFixed(0)} / hari',
          ),
          _DetailRow(label: 'Status', value: status),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Kembali ke daftar'),
          ),
        ],
      ),
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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
