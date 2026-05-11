enum AppLanguage {
  id,
  en,
}

class AppStrings {
  const AppStrings(this.language);

  final AppLanguage language;

  bool get _id => language == AppLanguage.id;

  String get appName => 'Morning Skor';
  String get home => _id ? 'Beranda' : 'Home';
  String get leagues => _id ? 'Liga' : 'Leagues';
  String get inbox => _id ? 'Inbox' : 'Inbox';
  String get settings => _id ? 'Pengaturan' : 'Settings';
  String get refresh => _id ? 'Muat ulang' : 'Refresh';
  String get chooseFavorites => _id ? 'Pilih tim favorit dulu' : 'Choose favorite teams first';
  String get noLatestScores => _id ? 'Belum ada hasil terbaru.' : 'No latest results yet.';
  String get loadScoresFailed => _id ? 'Gagal memuat skor. Coba lagi nanti.' : 'Failed to load scores. Try again later.';
  String get maxTeamsPerLeague => _id ? 'Maksimal 6 tim per liga.' : 'Maximum 6 teams per league.';
  String get notifications => _id ? 'Notifikasi' : 'Notifications';
  String get emptyInbox => _id ? 'Inbox masih kosong.' : 'Inbox is still empty.';
  String get scoreDigest => _id ? 'Ringkasan Skor' : 'Score Digest';
  String get homeHighlight => _id ? 'Highlight Home' : 'Home Highlight';
  String get awayHighlight => _id ? 'Highlight Away' : 'Away Highlight';
  String get languageLabel => _id ? 'Bahasa' : 'Language';
  String get appNameLabel => _id ? 'Nama aplikasi' : 'App name';
  String get bahasaIndonesia => 'Bahasa Indonesia';
  String get english => 'English';
  String get theme => _id ? 'Tema' : 'Theme';
  String get darkMode => _id ? 'Mode gelap' : 'Dark mode';
  String get lightMode => _id ? 'Mode terang' : 'Light mode';
  String get aboutApp => _id ? 'Tentang aplikasi' : 'About app';
  String get descriptionLabel => _id ? 'Deskripsi' : 'Description';
  String get developer => _id ? 'Developer' : 'Developer';
  String get version => _id ? 'Versi' : 'Version';
  String get appDescription => _id
      ? 'Digest skor sepak bola harian untuk memantau hasil terbaru dari liga dan tim favorit.'
      : 'A daily football score digest for tracking the latest results from favorite leagues and teams.';
}
