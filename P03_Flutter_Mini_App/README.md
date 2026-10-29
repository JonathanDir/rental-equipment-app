# P03 — Rental Alat Outdoor

Rental Alat Outdoor adalah aplikasi Flutter untuk melihat dan mencatat perlengkapan sewa. Aplikasi menyediakan layar daftar alat, detail alat, dan form tambah alat. Daftar awal memuat contoh tenda, carrier, dan kompor portable. Item baru yang disimpan lewat form langsung muncul di daftar; data hanya tersimpan selama aplikasi berjalan.

## Bug yang sempat menghambat

Saat kartu daftar disambungkan ke model `Equipment`, nama field yang dipakai kartu tidak cocok dengan model: kartu merujuk `available` dan `dailyPrice`, sedangkan model menyediakan `isAvailable` dan `dailyRate`. Ketidaksesuaian ditemukan dengan membandingkan field di `equipment.dart` dengan pemakaiannya pada widget kartu. Koreksinya adalah menyamakan nama field dan menyesuaikan formatter harga agar menerima nilai `double` dari `dailyRate`.
