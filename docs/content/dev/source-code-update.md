---
title: Source Code Update
weight: 2
toc: true
---

## Pemicu

Pesan **`source code update`** di chat agent pada workspace ini menjalankan alur berikut. Ini mencakup membaca source, menggabungkan perubahan yang diperlukan ke proyek utama, dan memverifikasi hasil. Pengguna cukup menyediakan folder source yang sudah diekstrak; path tambahan bersifat opsional bila folder berada di root proyek.

## Menentukan source dan target

1. Baca `AGENTS.md` dan `SPEC.md` proyek utama. Target adalah root proyek yang berisi panduan ini, bukan folder source pembaruan.
2. Utamakan path source yang disebut pengguna pada permintaan aktif.
3. Jika tidak ada path, cari folder source di root proyek, termasuk pola `winutil-YY.MM.DD`. Pastikan folder berisi `Compile.ps1`, `functions/`, `config/`, `scripts/start.ps1`, `scripts/main.ps1`, `xaml/inputXML.xaml`, dan `tools/autounattend.xml`.
4. Jika kandidat memakai pola versi tanggal yang valid, pilih versi tanggal terbesar berdasarkan angka tahun, bulan, dan hari. Jangan memilih hanya berdasarkan waktu modifikasi folder. Jika hanya satu kandidat valid tersedia, gunakan kandidat tersebut.
5. Jika tidak ada source valid, atau ada beberapa kandidat dengan versi yang tidak dapat dibandingkan atau versi terbaru yang sama, minta path yang dimaksud sebelum mengedit. Jangan menebak, memakai proyek utama sebagai source, atau mengunduh versi lain sebagai pengganti.
6. Nyatakan source, target, dan rencana verifikasi secara singkat. Simpan folder source tetap utuh; jangan memindahkan atau menghapusnya.

## Membandingkan dan menggabungkan

1. Periksa `git status --short` sebelum mengedit. Catat perubahan lokal yang sudah ada dan pisahkan dari perubahan update. Jangan memakai reset, checkout, atau overwrite massal yang membuang pekerjaan pengguna.
2. Baca file yang berubah, pemanggilnya, serta dependensi konfigurasi, XAML, dan tes. Gunakan riwayat Git atau dasar bersama bila tersedia untuk membedakan perubahan upstream dari penyesuaian lokal.
3. Gabungkan pembaruan perilaku dan perbaikan yang relevan pada:
   - `functions/private/` dan `functions/public/`;
   - `config/`;
   - `scripts/start.ps1` dan `scripts/main.ps1`;
   - `xaml/inputXML.xaml` dan `tools/autounattend.xml`;
   - tes yang memeriksa fitur yang diadopsi.
4. Pertahankan branding, ASCII art, informasi About, tautan repositori, endpoint startup dan ekspor konfigurasi, serta penyesuaian lokal yang masih diperlukan. Periksa perubahan pada file campuran per bagian; jangan menyalin seluruh file jika itu menghapus penyesuaian lokal.
5. Perubahan yang hanya mengembalikan identitas fork ke upstream tidak perlu diadopsi. Tautan bantuan boleh diperbarui ke halaman dokumentasi yang sesuai ketika perubahan fitur membutuhkannya; bedakan tautan bantuan dari endpoint yang mengunduh atau menjalankan kode.
6. Jangan menyalin `.git/`, artifact build, executable, atau file `winutil.ps1` dari source. `winutil.ps1` hanya dihasilkan oleh compiler proyek utama dan tidak boleh diedit, di-stage, atau di-commit secara langsung.
7. Jangan mengganti `AGENTS.md`, panduan update ini, metadata pemilik repositori, workflow `.github/`, atau sistem dokumentasi hanya karena versi upstream berbeda. Jika pembaruan runtime memerlukan perubahan kontrak build, release, atau migrasi dokumentasi, jelaskan kebutuhan konkretnya dan ikuti aturan klarifikasi di `AGENTS.md` sebelum melakukan perubahan tersebut.
8. Jangan menghapus fungsi atau konfigurasi lokal hanya karena tidak ditemukan di source baru. Untuk penghapusan yang memang diperlukan, periksa semua referensi dan jelaskan alasannya. Sertakan dependensi baru dari fitur yang diadopsi agar compiled script tetap mandiri.
9. Perbarui dokumentasi perilaku pada `docs/content/`, dokumentasi arsitektur, dan `SPEC.md` jika kontraknya berubah. Pertahankan sistem dokumentasi yang digunakan proyek utama.

## Verifikasi

Jalankan pemeriksaan dari root proyek utama. Jangan mengeksekusi tweak, instalasi paket aplikasi, perubahan DNS/SSH, penghapusan AppX, atau modifikasi ISO pada komputer pengguna sebagai bagian dari tes otomatis update.

1. Jalankan compiler:

   ```powershell
   .\Compile.ps1
   ```

2. Parse source dan `winutil.ps1` hasil compile dengan parser PowerShell. Periksa validitas JSON, XAML/XML, nama fungsi, handler kontrol, dan referensi konfigurasi yang berubah.
3. Jalankan tes dengan versi Pester yang ditentukan proyek. Untuk update luas, jalankan seluruh suite proyek utama:

   ```powershell
   Import-Module Pester -RequiredVersion 5.8.0 -Force
   Invoke-Pester -Path 'pester/*.Tests.ps1' -Output Detailed -CI
   ```

   Pertahankan kompatibilitas Windows PowerShell 5.1. Jika tes upstream menggunakan API khusus PowerShell yang lebih baru, perbaiki helper tes dengan pemeriksaan kemampuan yang menjaga makna tes; jangan menghapus assertion atau menandai kegagalan sebagai lulus.

4. Jika tersedia, jalankan Script Analyzer dengan `lint/PSScriptAnalyser.ps1` pada source utama. Batasi enumerasi ke file/folder source proyek utama supaya folder source pembaruan dan generated script tidak ikut dianalisis. Perbaiki diagnostic baru yang actionable tanpa menonaktifkan rule secara global.
5. Jika UI berubah, periksa pembuatan kontrol WPF, tab terkait, filter, tooltip, dan pilihan checkbox. Gunakan pemeriksaan WPF terisolasi tanpa menjalankan workflow sistem; jalankan `Compile.ps1 -Run` ketika praktis dan aman. Bedakan pemeriksaan pembuatan kontrol dari pengujian interaksi GUI langsung dalam laporan.
6. Jika execution policy menghalangi pemeriksaan, gunakan bypass hanya untuk proses verifikasi, tanpa mengubah kebijakan pengguna atau mesin secara permanen.
7. Periksa `git diff --check`, diff akhir, dan `git status --short`. Pastikan fitur yang diadopsi beserta dependensinya lengkap, branding tetap terjaga, dan source referensi tidak berubah. Perubahan lokal `winutil.ps1` akibat compile tetap merupakan artifact generated meskipun Git melaporkannya sebagai tracked.

Perbaiki penyebab kegagalan dan ulangi pemeriksaan yang terdampak. Jika sebuah pemeriksaan tidak bisa dijalankan, laporkan penyebab serta bagian yang belum terverifikasi. Jangan melaporkan jumlah tes atau hasil dari sesi sebelumnya sebagai hasil sesi sekarang.

## Laporan akhir

Laporkan secara singkat:

- Folder/versi source yang dipakai dan target yang diperbarui.
- Pembaruan utama yang digabung dan penyesuaian lokal yang dipertahankan.
- Hasil compile, tes, pemeriksaan WPF, dan analyzer yang benar-benar dijalankan.
- Bagian yang sengaja tidak diadopsi atau belum terverifikasi, bila relevan.

Jangan membuat commit, push, release, atau deployment kecuali pengguna memintanya. Setelah update selesai, pengguna dapat menyediakan folder source berikutnya dan memakai pemicu yang sama.
