// ignore_for_file: prefer_interpolation_to_compose_strings
import 'dart:convert';

enum EquipmentStatus { available, rented, maintenance }

class UnavailableEquipmentException implements Exception {
  final String message;
  UnavailableEquipmentException(this.message);
  
  @override
  String toString() => 'Penyewaan Gagal: ' + message;
}

mixin Auditable {
  void logAction(String action) {
    final time = DateTime.now().toIso8601String().substring(0, 16);
    print('[AUDIT ' + time + '] ' +  action);
  }
}

class Equipment with Auditable {
  final String id;
  final String name;
  final double dailyRate;
  final EquipmentStatus status;
  final DateTime? lastMaintenance; 

  const Equipment._({
    required this.id,
    required this.name,
    required this.dailyRate,
    required this.status,
    this.lastMaintenance,
  });

  factory Equipment({
    required String id,
    required String name,
    required double dailyRate,
    EquipmentStatus status = EquipmentStatus.available,
    DateTime? lastMaintenance,
  }) {
    if (dailyRate < 0) throw ArgumentError('Harga sewa tidak boleh negatif');
    return Equipment._(
      id: id, name: name, dailyRate: dailyRate, status: status, lastMaintenance: lastMaintenance
    );
  }

  static const _unset = Object();

  Equipment copyWith({
    String? name,
    double? dailyRate,
    EquipmentStatus? status,
    Object? lastMaintenance = _unset,
  }) {
    return Equipment._(
      id: id,
      name: name ?? this.name,
      dailyRate: dailyRate ?? this.dailyRate,
      status: status ?? this.status,
      lastMaintenance: lastMaintenance == _unset ? this.lastMaintenance : lastMaintenance as DateTime?,
    );
  }

  factory Equipment.fromJson(Map json) {
    final statusString = json['status'] as String;
    final parsedStatus = EquipmentStatus.values.firstWhere(
      (e) => e.toString().split('.').last == statusString,
      orElse: () => EquipmentStatus.available,
    );

    return Equipment._(
      id: json['id'] as String,
      name: json['name'] as String,
      dailyRate: (json['daily_rate'] as num).toDouble(),
      status: parsedStatus,
      lastMaintenance: json['last_maintenance'] != null 
          ? DateTime.parse(json['last_maintenance'] as String) 
          : null,
    );
  }

  Map toJson() => {
    'id': id,
    'name': name,
    'daily_rate': dailyRate,
    'status': status.toString().split('.').last,
    'last_maintenance': lastMaintenance?.toIso8601String(),
  };
  
  void rentOut() {
    logAction('Barang ' + name + ' berhasil disewakan\n');
  }
}

class TentEquipment extends Equipment {
  final int capacity;

  // ignore: use_super_parameters
  TentEquipment({
    required String id,
    required String name,
    required double dailyRate,
    EquipmentStatus status = EquipmentStatus.available,
    DateTime? lastMaintenance,
    required this.capacity,
  }) : super._(
          id: id, name: name, dailyRate: dailyRate, 
          status: status, lastMaintenance: lastMaintenance
        );

  @override
  Map toJson() {
    final json = super.toJson();
    json['capacity'] = capacity;
    return json;
  }
}

Future fetchEquipmentFromServer(String id) async {
  print('\n\x1B[3mMenghubungkan ke server ...\x1B[0m');
  await Future.delayed(const Duration(seconds: 6));

  const jsonResponse = '''
  {
    "id": "EQ-999",
    "name": "Sepatu Gunung",
    "daily_rate": 25000,
    "status": "available",
    "last_maintenance": null
  }
  ''';

  try {
    final Map data = jsonDecode(jsonResponse);
    return Equipment.fromJson(data);
  } on FormatException catch (e) {
    throw Exception('Data JSON rusak: ' + e.message);
  }
}