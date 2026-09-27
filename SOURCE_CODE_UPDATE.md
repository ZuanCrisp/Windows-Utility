# Source Code Update

Untuk memperbarui Windows Utility, sediakan folder source terbaru di root proyek, lalu ketik di chat agent yang membuka workspace ini:

```text
source code update
```

Contoh susunan folder:

```text
Windows Utility/
  AGENTS.md
  Compile.ps1
  functions/
  config/
  winutil-YY.MM.DD/       <- source terbaru yang sudah diekstrak
    Compile.ps1
    functions/
    config/
    scripts/
    xaml/
    tools/
```

Agent membaca [alur update](docs/content/dev/source-code-update.md), memilih source yang jelas paling baru, menggabungkan pembaruan yang relevan, menjaga branding dan penyesuaian lokal, lalu menjalankan verifikasi. Folder proyek utama menjadi target update; folder source tetap disimpan sebagai referensi.

Jika source berada di tempat lain, sertakan path foldernya setelah `source code update`. Jika beberapa source tidak dapat diurutkan dengan jelas, agent akan meminta pilihan folder.
