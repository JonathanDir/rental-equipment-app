# P02 — Dart OOP Challenge: Sistem Penyewaan Alat Outdoor

Domain yang saya pilih adalah pengelolaan inventaris dan transaksi penyewaan alat *outdoor* (seperti perlengkapan naik gunung atau kegiatan organisasi kampus).

### Aturan Domain yang Ditegakkan
1. **Keadaan Mustahil yang Ditolak:** Sebuah transaksi penyewaan tidak boleh terjadi jika barang yang diminta sedang disewa orang lain atau sedang dalam perbaikan (*maintenance*).
2. **Validasi Pembuatan Objek:** Saat objek `RentalTransaction` dibuat, konstruktornya akan mengecek status seluruh barang. Jika ada satu saja barang yang tidak `available`, sistem langsung melempar `UnavailableEquipmentException` dan membatalkan transaksi.

### Jawaban atas Keputusan Pemodelan
* **Kenapa 3 kelas berelasi?** Saya memisahkan `Customer`, `Equipment`, dan `RentalTransaction`. Ini menghindari penumpukan *field* (misal: memasukkan nama penyewa langsung ke kelas `Equipment`), sehingga satu *customer* bisa menyewa banyak alat sekaligus dalam satu struk transaksi.
* **Pewarisan vs Komposisi:** Saya memilih **Komposisi**. `RentalTransaction` *memiliki* objek `Customer` dan kumpulan objek `Equipment`. Saya tidak memakai pewarisan karena secara logika domain, transaksi bukanlah turunan (anak) dari pelanggan maupun barang.
* **Satu Mixin (`Auditable`):** Digunakan untuk mencatat riwayat kejadian (log). Baik kelas `Customer` (saat mendaftar) maupun `Equipment` (saat berubah status) memakai fungsi ini, padahal keduanya sama sekali tidak punya hubungan darah kekerabatan (*unrelated classes*).
* **Enum `EquipmentStatus`:** Dipilih agar nilai status barang mutlak hanya 3 (tersedia, disewa, perbaikan). Jika memakai `String`, sistem sangat rentan mengalami *bug* karena salah ketik ("tersedia" vs "Tersedia").
* **Null Safety yang Berarti:** Field `returnDate` di kelas `RentalTransaction` bertipe `DateTime?` (boleh null). Alasannya murni karena di dunia nyata, saat transaksi sewa baru berjalan, barangnya belum dikembalikan, sehingga tanggal kembalinya memang belum ada.
* **Satu Exception Custom:** `UnavailableEquipmentException` dibuat khusus untuk menghentikan alur program secara spesifik jika ada yang memaksa menyewa tenda atau alat yang sedang rusak/kosong.

### Keputusan yang Sempat Diragukan
Awalnya saya ragu apakah `dailyRate` (harga harian) harus diletakkan di `Equipment` atau `RentalTransaction`. Keputusan akhirnya adalah menyimpannya di `Equipment` sebagai harga dasar, lalu `RentalTransaction` bertugas menghitung total akhir berdasarkan selisih `rentDate` dan `returnDate`.