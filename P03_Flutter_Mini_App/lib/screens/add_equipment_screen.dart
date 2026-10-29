import 'package:flutter/material.dart';

import '../models/equipment.dart';

const _categories = [
  'Camping',
  'Tas Gunung',
  'Peralatan Masak',
  'Penerangan',
  'Lainnya',
];

class AddEquipmentScreen extends StatefulWidget {
  const AddEquipmentScreen({super.key});

  @override
  State<AddEquipmentScreen> createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  String _selectedCategory = _categories.first;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _saveEquipment() {
    if (!_formKey.currentState!.validate()) return;

    final equipment = Equipment(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      category: _selectedCategory,
      dailyRate: double.parse(_priceController.text.trim()),
      isAvailable: true,
    );

    Navigator.of(context).pop(equipment);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Item Rental')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama alat',
                hintText: 'Contoh: Tenda Dome 2 Orang',
                border: OutlineInputBorder(),
              ),
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama alat wajib diisi';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: _categories
                  .map(
                    (category) => DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: const InputDecoration(
                labelText: 'Harga sewa per hari',
                prefixText: 'Rp ',
                border: OutlineInputBorder(),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Harga sewa wajib diisi';
                }
                final price = double.tryParse(value.trim());
                if (price == null || !price.isFinite || price <= 0) {
                  return 'Masukkan harga berupa angka lebih dari 0';
                }
                return null;
              },
              onFieldSubmitted: (_) => _saveEquipment(),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _saveEquipment,
              icon: const Icon(Icons.save),
              label: const Text('Simpan item'),
            ),
          ],
        ),
      ),
    );
  }
}
