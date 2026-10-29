# P02 — Dart OOP Challenge: Sistem Penyewaan Alat Outdoor

## Deskripsi

Project ini merupakan implementasi **Object-Oriented Programming (OOP) menggunakan Dart** dengan studi kasus sistem penyewaan alat outdoor.

Domain yang digunakan berfokus pada pengelolaan **inventaris dan transaksi penyewaan perlengkapan outdoor**, seperti alat untuk kegiatan pendakian gunung, camping, maupun kegiatan organisasi kampus.

Melalui project ini, beberapa konsep OOP diterapkan secara langsung, seperti **Class & Object, Composition, Enum, Mixin, Null Safety, Custom Exception**, serta validasi aturan bisnis agar transaksi yang tidak valid dapat dicegah sejak awal.

---

## Aturan Domain yang Diterapkan

Sistem memiliki beberapa aturan yang harus dipenuhi agar transaksi penyewaan dapat dilakukan.

### 1. Alat Harus Tersedia

Penyewaan tidak dapat dilakukan apabila alat yang ingin disewa sedang:

* **Disewa oleh customer lain**
* **Dalam proses maintenance/perbaikan**

Dengan demikian, sebuah alat tidak dapat disewakan kepada dua customer pada waktu yang sama.

### 2. Validasi Saat Transaksi Dibuat

Saat objek `RentalTransaction` dibuat, sistem akan memeriksa status seluruh alat yang akan disewa.

Jika seluruh alat berstatus `available`, transaksi dapat dibuat.

Namun, jika terdapat **satu saja alat** yang sedang disewa atau dalam proses maintenance, transaksi langsung dibatalkan dan sistem akan melempar:

```dart
UnavailableEquipmentException
```

Pendekatan ini digunakan untuk mencegah terjadinya transaksi yang tidak sesuai dengan kondisi inventaris.

---

## Keputusan Pemodelan

### 1. Pemisahan Menjadi 3 Class

Sistem menggunakan tiga class utama:

* `Customer` — menyimpan informasi mengenai penyewa.
* `Equipment` — menyimpan informasi dan status alat outdoor.
* `RentalTransaction` — mengelola transaksi penyewaan.

Ketiga class tersebut dibuat terpisah agar setiap class memiliki tanggung jawab yang jelas.

Contohnya, informasi customer tidak disimpan langsung di dalam `Equipment`. Dengan pemisahan ini, satu customer dapat menyewa beberapa alat sekaligus dan seluruh alat tersebut dapat dicatat dalam satu transaksi.

Pendekatan ini juga membuat struktur program lebih mudah dikembangkan dan dipelihara.

---

### 2. Menggunakan Composition, Bukan Inheritance

Pada project ini saya memilih **Composition** daripada inheritance.

`RentalTransaction` memiliki sebuah objek `Customer` dan kumpulan objek `Equipment`.

Hubungannya lebih tepat disebut **"has-a"**, karena sebuah transaksi *memiliki* customer dan alat yang disewa.

Saya tidak menggunakan inheritance karena secara konsep, transaksi bukan merupakan turunan dari customer maupun equipment. Keduanya adalah objek yang digunakan oleh transaksi untuk menjalankan proses penyewaan.

---

### 3. Mixin `Auditable`

Project ini menggunakan satu mixin bernama `Auditable`.

Mixin ini digunakan untuk mencatat riwayat kejadian atau aktivitas yang terjadi pada objek.

Mixin tersebut digunakan oleh:

* `Customer`, misalnya ketika customer melakukan pendaftaran.
* `Equipment`, misalnya ketika status alat mengalami perubahan.

Penggunaan mixin dipilih karena `Customer` dan `Equipment` tidak memiliki hubungan inheritance, tetapi keduanya membutuhkan kemampuan yang sama untuk mencatat aktivitas.

Dengan demikian, fungsi pencatatan tidak perlu ditulis berulang kali pada masing-masing class.

---

### 4. Enum `EquipmentStatus`

Status equipment menggunakan enum:

```dart
EquipmentStatus
```

dengan tiga kondisi utama:

* `available` — alat tersedia dan dapat disewa.
* `rented` — alat sedang disewa.
* `maintenance` — alat sedang dalam perbaikan atau maintenance.

Saya memilih enum karena status alat hanya boleh berasal dari nilai yang sudah ditentukan.

Jika menggunakan `String`, terdapat kemungkinan kesalahan penulisan seperti:

```text
"available"
"Available"
"availabe"
```

Kesalahan seperti ini dapat menyebabkan bug yang sulit ditemukan. Dengan enum, nilai status menjadi lebih terkontrol dan aman.

---

### 5. Null Safety pada `returnDate`

Field `returnDate` pada `RentalTransaction` menggunakan tipe:

```dart
DateTime?
```

Tanda `?` digunakan karena tanggal pengembalian tidak selalu tersedia ketika transaksi pertama kali dibuat.

Saat customer baru menyewa alat, barang tersebut belum dikembalikan sehingga `returnDate` masih bernilai `null`.

Setelah alat dikembalikan, barulah tanggal pengembalian dapat diisi.

Penggunaan `DateTime?` mencerminkan kondisi nyata dalam proses penyewaan sekaligus menunjukkan penerapan **Null Safety** pada Dart.

---

### 6. Custom Exception

Project ini menggunakan custom exception:

```dart
UnavailableEquipmentException
```

Exception ini dibuat khusus untuk menangani kondisi ketika customer mencoba menyewa alat yang tidak tersedia.

Contohnya, ketika alat sedang:

* disewa oleh customer lain; atau
* dalam proses maintenance.

Daripada membiarkan transaksi tetap dibuat, sistem akan menghentikan proses dan memberikan exception yang sesuai dengan kondisi tersebut.

Hal ini membuat penanganan error menjadi lebih spesifik dan mudah dipahami.

---

## Keputusan Mengenai `dailyRate`

Salah satu keputusan pemodelan yang sempat saya pertimbangkan adalah menentukan tempat penyimpanan harga sewa harian (`dailyRate`).

Pada akhirnya, `dailyRate` diletakkan di dalam class `Equipment`.

Alasannya, harga harian merupakan karakteristik dari masing-masing alat. Setiap equipment dapat memiliki harga sewa yang berbeda.

Sementara itu, `RentalTransaction` bertanggung jawab untuk menghitung total biaya berdasarkan:

* alat yang disewa,
* harga sewa harian,
* tanggal mulai penyewaan, dan
* tanggal pengembalian.

Dengan pemisahan tersebut, `Equipment` bertanggung jawab terhadap **data dan karakteristik alat**, sedangkan `RentalTransaction` bertanggung jawab terhadap **proses dan perhitungan transaksi**.

---

## Ringkasan Konsep OOP yang Digunakan

| Konsep           | Implementasi                                            |
| ---------------- | ------------------------------------------------------- |
| Class & Object   | `Customer`, `Equipment`, `RentalTransaction`            |
| Composition      | `RentalTransaction` memiliki `Customer` dan `Equipment` |
| Enum             | `EquipmentStatus`                                       |
| Mixin            | `Auditable`                                             |
| Null Safety      | `DateTime? returnDate`                                  |
| Custom Exception | `UnavailableEquipmentException`                         |
| Encapsulation    | Data dan proses dikelola melalui class masing-masing    |
| Business Rule    | Equipment harus berstatus `available` sebelum disewa    |

---

## Tujuan Project

Project ini dibuat sebagai latihan penerapan konsep **OOP pada Dart** dengan menggunakan studi kasus yang dekat dengan kebutuhan nyata, khususnya dalam pengelolaan penyewaan perlengkapan outdoor.

Selain menerapkan sintaks Dart, project ini juga menekankan bagaimana sebuah aturan bisnis dapat diterjemahkan ke dalam struktur program sehingga sistem tidak hanya dapat menjalankan proses normal, tetapi juga mampu **menolak kondisi yang tidak valid**.



Copyright (c) 2026 Jonathan Naufal Farrel
All rights reserved.
