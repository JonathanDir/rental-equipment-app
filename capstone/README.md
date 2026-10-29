# Deklarasi Capstone — Rental Alat Outdoor

## Domain dan alasan

**Local Business Solutions — pengelolaan inventaris dan penyewaan alat outdoor.** Proyek ini meneruskan domain dari latihan P02 tentang sistem penyewaan alat outdoor. Usaha rental lokal dan komunitas kampus membutuhkan cara praktis untuk mengetahui ketersediaan perlengkapan sebelum kegiatan, sementara pencatatan manual mudah tertukar ketika beberapa penyewa memesan barang pada waktu yang berdekatan.

## Masalah pengguna

Penyewa—terutama mahasiswa atau komunitas yang menyiapkan kegiatan berkemah—kesulitan menemukan alat yang tersedia, memahami harga dan durasi sewa, serta memastikan pesanannya tercatat. Pengelola rental juga perlu menghindari pemesanan ganda dan melacak barang yang sedang disewa atau perlu perawatan. Aplikasi ini membantu penyewa melihat katalog dan mengajukan sewa, sekaligus memberi pengelola ringkasan status inventaris dan transaksi.

## Layar utama dan fitur inti

Rencana layar awal (sketsa alur): **Beranda/Katalog → Detail Alat → Keranjang & Konfirmasi Sewa → Pesanan Saya**. Pengelola mendapat layar **Inventaris & Transaksi**.

1. **Katalog alat** — lihat nama, kategori, harga harian, dan status ketersediaan.
2. **Detail dan pencarian alat** — cari atau saring perlengkapan, lalu periksa informasi dan biaya sebelum menyewa.
3. **Pemesanan** — pilih alat dan tanggal sewa, tinjau estimasi biaya, lalu simpan pesanan.
4. **Status pesanan dan inventaris** — lihat riwayat/status sewa; pengelola dapat memperbarui ketersediaan atau menandai alat untuk perawatan.

## Stack dan alasan

**Flutter dan Dart**, dengan penyimpanan lokal sementara pada tahap awal. Flutter sesuai dengan materi pengembangan mobile dan memungkinkan satu aplikasi Android dibangun dengan UI yang konsisten; Dart juga meneruskan bahasa yang sudah digunakan pada P02. Penyimpanan lokal membuat alur utama dapat dibuat lebih dulu sebelum integrasi REST API pada Gate 2.

## Repositori Git

[github.com/JonathanDir/rental-equipment-app](https://github.com/JonathanDir/rental-equipment-app)

## Hal yang belum dikuasai

Saya belum tahu cara merancang sinkronisasi data yang tetap aman saat aplikasi offline lalu kembali online. Saya akan mulai dengan mempelajari pemisahan repository data lokal dan API, kemudian mencoba alur perubahan lokal dan sinkronisasi pada Gate 2.
