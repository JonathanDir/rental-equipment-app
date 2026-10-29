/// Data satu perlengkapan yang ditawarkan untuk disewa.
class Equipment {
  const Equipment({
    required this.id,
    required this.name,
    required this.category,
    required this.dailyRate,
    required this.isAvailable,
  });

  final String id;
  final String name;
  final String category;
  final double dailyRate;
  final bool isAvailable;
}

/// Data awal untuk daftar perlengkapan rental.
const sampleEquipment = <Equipment>[
  Equipment(
    id: 'EQ-001',
    name: 'Tenda Dome 4 Orang',
    category: 'Camping',
    dailyRate: 75000,
    isAvailable: true,
  ),
  Equipment(
    id: 'EQ-002',
    name: 'Carrier 60L',
    category: 'Tas Gunung',
    dailyRate: 50000,
    isAvailable: false,
  ),
  Equipment(
    id: 'EQ-003',
    name: 'Kompor Portable',
    category: 'Peralatan Masak',
    dailyRate: 30000,
    isAvailable: true,
  ),
];
