# Product Requirements Document (PRD)

# Morning Skor

## 1. Ringkasan Produk

Morning Skor adalah aplikasi mobile Flutter berbasis Android yang menampilkan ringkasan skor sepak bola dari beberapa liga besar Eropa. Aplikasi ini dirancang untuk membantu pengguna melihat hasil pertandingan terbaru dari tim favorit mereka secara cepat, sederhana, dan terorganisir.

Aplikasi mendukung pemilihan tim favorit per liga, tampilan hasil pertandingan terbaru, tombol untuk membuka kanal highlight resmi klub di YouTube, notifikasi skor harian, inbox notifikasi, pengaturan bahasa, pengaturan tema, serta halaman informasi aplikasi.

## 2. Latar Belakang

Banyak pengguna sepak bola ingin mengetahui hasil pertandingan tanpa harus membuka banyak situs atau aplikasi berbeda. Informasi skor sering tersebar di berbagai platform dan tidak selalu disusun berdasarkan liga atau tim favorit pengguna.

Morning Skor dibuat sebagai solusi ringkas untuk menampilkan skor terbaru berdasarkan liga dan tim favorit. Aplikasi juga menyimpan riwayat notifikasi agar pengguna dapat melihat kembali ringkasan skor sebelumnya.

## 3. Tujuan Produk

Tujuan utama aplikasi Morning Skor adalah:

1. Menampilkan hasil pertandingan terbaru dari 5 liga besar Eropa.
2. Memungkinkan pengguna memilih tim favorit per liga.
3. Memberikan ringkasan skor melalui notifikasi harian dan sinkronisasi background.
4. Menyediakan inbox notifikasi yang tersusun per liga.
5. Mengarahkan pengguna ke kanal YouTube resmi klub untuk melihat highlight.
6. Memberikan pengalaman UI yang sederhana, responsif, dan mendukung dark/light mode.
7. Mendukung dua bahasa, yaitu Bahasa Indonesia dan English.

## 4. Target Pengguna

Target pengguna aplikasi:

- Penggemar sepak bola yang ingin memantau skor terbaru.
- Pengguna yang mengikuti beberapa klub dari liga berbeda.
- Pengguna mobile yang membutuhkan informasi cepat tanpa proses login.
- Pengguna yang ingin membuka highlight pertandingan melalui kanal resmi klub.

## 5. Platform

Platform utama:

- Android

Teknologi utama:

- Flutter
- Dart
- Material 3
- Provider
- Shared Preferences
- Workmanager
- Flutter Local Notifications

## 6. Scope Produk

### 6.1 In Scope

Fitur yang termasuk dalam versi aplikasi:

- Menampilkan daftar hasil pertandingan terbaru.
- Mengelompokkan hasil pertandingan berdasarkan liga.
- Menyediakan 5 liga:
  - Premier League
  - La Liga
  - Serie A
  - Bundesliga
  - Ligue 1
- Menyediakan 6 tim pilihan untuk setiap liga.
- Menyimpan tim favorit pengguna.
- Maksimal 6 tim favorit per liga.
- Mengambil data pertandingan dari TheSportsDB public test key.
- Menampilkan tombol highlight untuk tim home dan away.
- Membuka kanal YouTube resmi klub menggunakan URL launcher.
- Menyimpan riwayat notifikasi di inbox.
- Mengelompokkan isi inbox berdasarkan liga.
- Menampilkan notifikasi skor per liga.
- Menjalankan background sync setiap 6 jam.
- Menjadwalkan notifikasi harian pukul 06.00.
- Menyediakan pengaturan bahasa Indonesia dan English.
- Menyediakan pengaturan tema light dan dark mode.
- Menyediakan halaman About App.

### 6.2 Out of Scope

Fitur yang tidak termasuk dalam versi ini:

- Login atau autentikasi pengguna.
- Integrasi database cloud.
- Push notification dari server.
- YouTube API.
- Detail statistik pertandingan lengkap.
- Jadwal pertandingan mendatang.
- Klasemen liga.
- Pencarian tim secara bebas.
- Fitur komentar atau sosial.
- Pembelian atau monetisasi.

## 7. Fitur Utama

## 7.1 Home

Home adalah halaman utama aplikasi yang menampilkan skor pertandingan terbaru berdasarkan tim favorit pengguna.

### Kebutuhan Fungsional

- Jika pengguna belum memilih tim favorit, aplikasi menampilkan empty state.
- Jika pengguna sudah memilih tim favorit, aplikasi mengambil skor terbaru dari API.
- Hasil ditampilkan berdasarkan liga.
- Hanya pertandingan dengan skor final yang ditampilkan.
- Data pertandingan yang sama tidak boleh tampil duplikat.
- Pengguna dapat melakukan refresh manual.
- Jika terjadi error jaringan, aplikasi menampilkan pesan error ringan.

### Informasi yang Ditampilkan

- Nama liga.
- Logo liga.
- Nama tim home.
- Logo tim home.
- Nama tim away.
- Logo tim away.
- Skor pertandingan.
- Tanggal pertandingan.
- Tombol highlight home.
- Tombol highlight away.

## 7.2 Leagues

Halaman Leagues digunakan untuk memilih tim favorit dari setiap liga.

### Kebutuhan Fungsional

- Menampilkan 5 tab liga.
- Setiap liga memiliki 6 tim pilihan.
- Setiap tim memiliki switch untuk memilih favorit.
- Pilihan favorit disimpan secara lokal.
- Maksimal 6 tim favorit per liga.
- Jika melebihi batas, aplikasi menampilkan snackbar.

### Data Tim

Setiap tim memiliki:

- Nama tim.
- Team ID dari TheSportsDB.
- Nama liga.
- Asset logo lokal.
- URL kanal YouTube.

## 7.3 Inbox

Inbox digunakan untuk melihat riwayat notifikasi skor yang pernah diterima atau disimpan oleh background sync.

### Kebutuhan Fungsional

- Menampilkan daftar riwayat notifikasi.
- Riwayat ditampilkan berdasarkan tanggal.
- Isi notifikasi dikelompokkan per liga.
- Setiap grup liga menampilkan logo liga dan daftar pertandingan.
- Data lama yang belum memiliki struktur liga tetap dapat dibaca.
- Jika inbox kosong, tampilkan empty state.

## 7.4 Settings

Settings digunakan untuk mengatur preferensi aplikasi dan melihat informasi aplikasi.

### Kebutuhan Fungsional

- Menampilkan pilihan bahasa:
  - Bahasa Indonesia
  - English
- Menampilkan pilihan tema:
  - Light mode
  - Dark mode
- Menyimpan pilihan bahasa secara lokal.
- Menyimpan pilihan tema secara lokal.
- Seluruh teks utama aplikasi mengikuti bahasa yang dipilih.
- Tema aplikasi berubah sesuai pilihan pengguna.

## 7.5 About App

About App adalah bagian dari Settings yang menjelaskan informasi aplikasi.

### Informasi yang Ditampilkan

- Nama aplikasi: Morning Skor.
- Deskripsi aplikasi.
- Nama developer.
- Versi aplikasi.

## 8. Notifikasi

Morning Skor memiliki fitur notifikasi lokal berbasis background task.

### Kebutuhan Fungsional

- Aplikasi melakukan sinkronisasi background setiap 6 jam.
- Aplikasi menjadwalkan notifikasi harian pukul 06.00 waktu lokal.
- Notifikasi dikirim per liga agar isi tidak terlalu panjang.
- Setiap notifikasi berisi daftar skor dari satu liga.
- Notifikasi juga disimpan ke inbox.
- Jika tidak ada skor terbaru, notifikasi tidak dikirim.
- Jika jaringan gagal di background, proses gagal secara silent agar tidak mengganggu pengguna.

### Format Notifikasi

Judul:

```text
Morning Skor - Premier League
```

Isi:

```text
Arsenal 2 - 1 Chelsea
Liverpool 1 - 1 Manchester City
```

## 9. Highlight YouTube

Aplikasi menyediakan tombol highlight untuk membuka kanal YouTube resmi klub.

### Kebutuhan Fungsional

- Tombol highlight home membuka kanal YouTube tim home.
- Tombol highlight away membuka kanal YouTube tim away.
- Aplikasi tidak menggunakan YouTube API.
- Jika URL tim tidak tersedia, tombol dinonaktifkan.
- URL dibuka menggunakan aplikasi browser atau YouTube melalui `url_launcher`.

## 10. Sumber Data

Sumber data pertandingan:

```text
https://www.thesportsdb.com/api/v1/json/3/
```

Endpoint yang digunakan:

```text
eventslast.php?id={teamId}
```

Public test key:

```text
3
```

### Data yang Diambil

- `idEvent`
- `strEvent`
- `dateEvent`
- `strHomeTeam`
- `strAwayTeam`
- `intHomeScore`
- `intAwayScore`

## 11. Data Lokal

Aplikasi menggunakan `SharedPreferences` untuk menyimpan data lokal.

### Data yang Disimpan

1. Favorites

```json
{
  "Premier League": ["Arsenal", "Liverpool"],
  "La Liga": ["Real Madrid", "Barcelona"]
}
```

2. Notifications

```json
{
  "date": "2026-05-11T06:00:00.000",
  "matches": ["Arsenal 2 - 1 Chelsea"],
  "matchesByLeague": {
    "Premier League": ["Arsenal 2 - 1 Chelsea"]
  }
}
```

3. Language Setting

```text
id atau en
```

4. Theme Setting

```text
dark atau light
```

## 12. Arsitektur Aplikasi

Aplikasi menggunakan pendekatan clean architecture sederhana dengan pemisahan folder berdasarkan tanggung jawab.

```text
lib/
├── main.dart
├── app.dart
├── models/
├── services/
├── providers/
├── views/
├── widgets/
└── utils/
```

### Models

Berisi representasi data aplikasi:

- `Team`
- `Match`
- `League`

### Services

Berisi logic eksternal dan penyimpanan:

- `ApiService`
- `StorageService`
- `NotificationService`
- `BackgroundService`

### Providers

Berisi state management:

- `FavoritesProvider`
- `MatchesProvider`
- `SettingsProvider`

### Views

Berisi halaman aplikasi:

- `HomePage`
- `LeaguePage`
- `NotificationPage`
- `SettingsPage`

### Widgets

Berisi komponen UI reusable:

- `MatchCard`
- `LeagueSection`
- `BadgeIcon`

### Utils

Berisi konstanta dan helper:

- `constants.dart`
- `date_utils.dart`
- `app_strings.dart`

## 13. Dependency

Dependency utama aplikasi:

| Dependency | Fungsi |
|---|---|
| `http` | Mengambil data dari TheSportsDB |
| `provider` | State management |
| `shared_preferences` | Penyimpanan lokal |
| `url_launcher` | Membuka kanal YouTube |
| `flutter_local_notifications` | Notifikasi lokal |
| `workmanager` | Background sync |
| `intl` | Format tanggal |

## 14. UI/UX Requirement

### Prinsip Desain

- Menggunakan Material 3.
- Mendukung dark mode dan light mode.
- Tampilan sederhana dan fokus pada skor.
- Padding konsisten antar halaman.
- Card memiliki rounded corner.
- Tombol highlight simetris kiri dan kanan.
- Logo klub dan liga ditampilkan untuk memperjelas identitas.
- Bottom navigation memuat:
  - Home
  - Leagues
  - Inbox
  - Settings

### Empty State

Empty state digunakan pada:

- Home saat belum ada favorit.
- Inbox saat belum ada riwayat notifikasi.
- Home saat belum ada hasil terbaru.

## 15. Non-Functional Requirements

### Performance

- Aplikasi harus tetap responsif saat mengambil data.
- Network request dibuat minimal dengan menggunakan team ID yang sudah dikurasi.
- Timeout API digunakan agar aplikasi tidak menunggu terlalu lama.
- Retry maksimal 3 kali untuk request API.

### Reliability

- Jika API kosong, data dilewati.
- Jika skor null, pertandingan tidak ditampilkan di Home.
- Jika jaringan gagal, UI menampilkan pesan error ringan.
- Background task gagal secara silent jika jaringan bermasalah.

### Maintainability

- Struktur folder dibuat modular.
- UI component dibuat reusable.
- Bahasa aplikasi dipusatkan di `AppStrings`.
- Data liga dan tim dipusatkan di `constants.dart`.

### Compatibility

- Target utama Android.
- Aplikasi dapat diuji di web untuk UI dasar.
- Fitur background task dan local notification difokuskan untuk Android.

## 16. Edge Cases

| Kondisi | Perilaku Aplikasi |
|---|---|
| Tidak ada favorit | Tampilkan empty state |
| API tidak mengembalikan data | Lewati data |
| Skor pertandingan null | Jangan tampilkan sebagai hasil final |
| Jaringan gagal | Tampilkan snackbar di foreground |
| Background sync gagal | Silent fail |
| URL YouTube tidak tersedia | Disable tombol highlight |
| Inbox kosong | Tampilkan empty state |
| Data inbox lama belum punya grup liga | Tampilkan sebagai Score Digest/Ringkasan Skor |

## 17. User Flow

### Flow Memilih Tim Favorit

1. Pengguna membuka aplikasi.
2. Pengguna masuk ke menu Leagues.
3. Pengguna memilih liga.
4. Pengguna mengaktifkan switch pada tim favorit.
5. Aplikasi menyimpan pilihan ke local storage.

### Flow Melihat Skor

1. Pengguna masuk ke Home.
2. Aplikasi membaca tim favorit.
3. Aplikasi mengambil last match berdasarkan team ID.
4. Aplikasi memfilter pertandingan yang memiliki skor.
5. Aplikasi mengelompokkan hasil berdasarkan liga.
6. Aplikasi menampilkan hasil dalam card.

### Flow Membuka Highlight

1. Pengguna melihat match card.
2. Pengguna menekan tombol Home Highlight atau Away Highlight.
3. Aplikasi membuka URL YouTube resmi klub.

### Flow Mengubah Bahasa

1. Pengguna masuk ke Settings.
2. Pengguna memilih Bahasa Indonesia atau English.
3. Aplikasi menyimpan preferensi.
4. Teks UI berubah mengikuti bahasa pilihan.

### Flow Mengubah Tema

1. Pengguna masuk ke Settings.
2. Pengguna memilih Dark mode atau Light mode.
3. Aplikasi menyimpan preferensi.
4. Tema aplikasi berubah sesuai pilihan.

## 18. Testing Plan

### Functional Testing

- Memilih dan membatalkan favorit.
- Menampilkan skor berdasarkan favorit.
- Menampilkan empty state jika belum ada favorit.
- Membuka URL highlight.
- Mengubah bahasa.
- Mengubah tema.
- Melihat inbox notifikasi.
- Memastikan notifikasi tersimpan ke inbox.

### UI Testing

- Memastikan card rapi pada layar kecil.
- Memastikan tombol highlight tidak terpotong.
- Memastikan bottom navigation tampil simetris.
- Memastikan Settings memiliki padding konsisten.
- Memastikan dark/light mode tetap terbaca.

### Error Testing

- Simulasi jaringan mati.
- Simulasi API kosong.
- Simulasi URL YouTube tidak tersedia.
- Simulasi inbox kosong.

## 19. Risiko dan Mitigasi

| Risiko | Mitigasi |
|---|---|
| API publik lambat atau gagal | Timeout dan retry |
| Data TheSportsDB tidak lengkap | Null check dan skip data |
| Notifikasi terlalu panjang | Notifikasi dipisah per liga |
| Build Android berat di laptop RAM kecil | Worker Gradle dibatasi dan lint release dimatikan |
| URL YouTube berubah | URL dipusatkan di constants agar mudah diedit |
| Logo klub belum final | Menggunakan dummy asset yang bisa diganti |

## 20. Rencana Pengembangan Lanjutan

Fitur yang dapat dikembangkan setelah versi UTS:

- Halaman detail pertandingan.
- Jadwal pertandingan berikutnya.
- Klasemen liga.
- Pencarian tim.
- Filter berdasarkan tanggal.
- Logo klub resmi.
- Reminder khusus tim favorit.
- Mode compact untuk tampilan skor.
- Sinkronisasi cloud.
- Unit test dan widget test lebih lengkap.

## 21. Kesimpulan

Morning Skor adalah aplikasi mobile sederhana namun fungsional untuk menampilkan ringkasan skor sepak bola berdasarkan liga dan tim favorit. Aplikasi ini memanfaatkan API publik TheSportsDB, penyimpanan lokal, notifikasi lokal, background sync, serta pengaturan bahasa dan tema.

Dengan struktur project yang modular dan UI yang sederhana, Morning Skor memenuhi kebutuhan dasar aplikasi mobile untuk laporan UTS sekaligus memiliki ruang pengembangan lebih lanjut.
