// ignore_for_file: prefer_interpolation_to_compose_strings
import 'package:p2_rental_outdoor/p2_rental_outdoor.dart';

void main() async {
  print('\n==============================================');
  print('=== TEMA DOMAIN : SISTEM SEWA ALAT OUTDOOR ===');
  print('==============================================\n\n\n');

  // TAHAP 1: ASYNC PROGRAMMING & JSON PARSING
  print('[+] STEP 1 : Mengambil data dari server');
  final equipment = await fetchEquipmentFromServer('EQ-999');
  print('Hasil : Berhasil memuat  ' + equipment.name + ' dengan tarif Rp' + equipment.dailyRate.toString() + '/hari\n\n');

  // TAHAP 2: COPYWITH & MIXIN AUDIT
  print('[+] STEP 2 : Memperbarui status barang dan mencatat audit log');
  final rentedEq = equipment.copyWith(status: EquipmentStatus.rented);
  print('Status terkini :  ' + rentedEq.status.toString().split('.').last);
  rentedEq.rentOut();
  print('');

  // TAHAP 3: INHERITANCE (PEWARISAN KELAS)
  print('[+] STEP 3 : Menguji objek turunan khusus (TentEquipment)');
  final tendaVIP = TentEquipment(
    id: 'EQ-001',
    name: 'Tenda Dome Eiger',
    dailyRate: 75000,
    capacity: 4,
  );
  print('Kapasitas Tenda :  ' + tendaVIP.capacity.toString() + ' orang');
  print('Format JSON :  ' + tendaVIP.toJson().toString());
  print('\n');

  // TAHAP 4: ERROR HANDLING & ATURAN BISNIS
  print('[+] STEP 4 : Menguji validasi aturan');
  try {
    final errorEq = Equipment(id: 'EQ-002', name: 'Kompor', dailyRate: -10000);
    print(errorEq.name);
  } catch (e) {
    print('Sistem menolak dengan pesan :  ' + e.toString());
  }

  print('\n\n\n=========================');
  print('====== END PROGRAM ======');
  print('=========================\n\n\n');
}