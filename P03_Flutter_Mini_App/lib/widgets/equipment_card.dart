import 'package:flutter/material.dart';

import '../models/equipment.dart';

/// Kartu perlengkapan rental yang dapat dipakai ulang pada daftar.
class EquipmentCard extends StatelessWidget {
  const EquipmentCard({
    super.key,
    required this.equipment,
    required this.onTap,
  });

  final Equipment equipment;
  final VoidCallback onTap;

  String _formatPrice(double value) {
    final digits = value.toStringAsFixed(0);
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
      buffer.write(digits[i]);
    }
    return 'Rp$buffer/hari';
  }

  @override
  Widget build(BuildContext context) {
    final available = equipment.isAvailable;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        leading: Icon(
          available ? Icons.check_circle : Icons.cancel_outlined,
          color: available ? Colors.green : Colors.red,
        ),
        title: Text(equipment.name),
        subtitle: Text(
          '${equipment.category} • ${_formatPrice(equipment.dailyRate)}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              available ? 'Tersedia' : 'Disewa',
              style: TextStyle(
                color: available ? Colors.green : Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
