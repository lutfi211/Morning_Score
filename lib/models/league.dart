import 'team.dart';

class League {
  const League({
    required this.name,
    required this.teams,
  });

  final String name;
  final List<Team> teams;
}
