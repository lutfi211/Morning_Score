class Match {
  const Match({
    this.idEvent,
    required this.eventName,
    required this.date,
    required this.homeTeam,
    required this.awayTeam,
    this.homeScore,
    this.awayScore,
  });

  final String? idEvent;
  final String eventName;
  final DateTime date;
  final String homeTeam;
  final String awayTeam;
  final int? homeScore;
  final int? awayScore;

  String scoreText() {
    if (homeScore == null || awayScore == null) return 'vs';
    return '$homeScore - $awayScore';
  }

  String notificationLine() => '$homeTeam ${scoreText()} $awayTeam';
}
