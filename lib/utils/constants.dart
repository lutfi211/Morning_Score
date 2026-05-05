import '../models/league.dart';
import '../models/team.dart';

const premierLeague = 'Premier League';
const laLiga = 'La Liga';
const serieA = 'Serie A';
const bundesliga = 'Bundesliga';
const ligue1 = 'Ligue 1';

const curatedTeamsByLeague = <String, List<Team>>{
  premierLeague: [
    Team(name: 'Arsenal', teamId: '133604', league: premierLeague),
    Team(name: 'Liverpool', teamId: '133602', league: premierLeague),
    Team(name: 'Manchester United', teamId: '133612', league: premierLeague),
    Team(name: 'Manchester City', teamId: '133613', league: premierLeague),
    Team(name: 'Chelsea', teamId: '133610', league: premierLeague),
    Team(name: 'Tottenham Hotspur', teamId: '133616', league: premierLeague),
  ],
  laLiga: [
    Team(name: 'Real Madrid', teamId: '133738', league: laLiga),
    Team(name: 'Barcelona', teamId: '133739', league: laLiga),
    Team(name: 'Atletico Madrid', teamId: '133729', league: laLiga),
    Team(name: 'Sevilla', teamId: '133745', league: laLiga),
    Team(name: 'Valencia', teamId: '133724', league: laLiga),
    Team(name: 'Real Sociedad', teamId: '133731', league: laLiga),
  ],
  serieA: [
    Team(name: 'Juventus', teamId: '133676', league: serieA),
    Team(name: 'Inter Milan', teamId: '133682', league: serieA),
    Team(name: 'AC Milan', teamId: '133677', league: serieA),
    Team(name: 'Napoli', teamId: '133670', league: serieA),
    Team(name: 'Roma', teamId: '133669', league: serieA),
    Team(name: 'Lazio', teamId: '133683', league: serieA),
  ],
  bundesliga: [
    Team(name: 'Bayern Munich', teamId: '133664', league: bundesliga),
    Team(name: 'Borussia Dortmund', teamId: '133650', league: bundesliga),
    Team(name: 'Bayer Leverkusen', teamId: '133651', league: bundesliga),
    Team(name: 'RB Leipzig', teamId: '134695', league: bundesliga),
    Team(name: 'Eintracht Frankfurt', teamId: '133652', league: bundesliga),
    Team(name: 'Wolfsburg', teamId: '133653', league: bundesliga),
  ],
  ligue1: [
    Team(name: 'Paris Saint-Germain', teamId: '133714', league: ligue1),
    Team(name: 'Marseille', teamId: '133705', league: ligue1),
    Team(name: 'Lyon', teamId: '133707', league: ligue1),
    Team(name: 'Monaco', teamId: '133711', league: ligue1),
    Team(name: 'Lille', teamId: '133706', league: ligue1),
    Team(name: 'Rennes', teamId: '133712', league: ligue1),
  ],
};

final leagues = curatedTeamsByLeague.entries
    .map((entry) => League(name: entry.key, teams: entry.value))
    .toList(growable: false);

const teamYouTubeChannels = <String, String>{
  'Arsenal': 'https://www.youtube.com/@Arsenal/videos',
  'Liverpool': 'https://www.youtube.com/@LiverpoolFC/videos',
  'Manchester United': 'https://www.youtube.com/@manutd/videos',
  'Manchester City': 'https://www.youtube.com/@mancity/videos',
  'Chelsea': 'https://www.youtube.com/@chelseafc/videos',
  'Tottenham Hotspur': 'https://www.youtube.com/@SpursOfficial/videos',
  'Real Madrid': 'https://www.youtube.com/@realmadrid/videos',
  'Barcelona': 'https://www.youtube.com/@fcbarcelona/videos',
  'Atletico Madrid': 'https://www.youtube.com/@atleticodemadrid/videos',
  'Sevilla': 'https://www.youtube.com/@sevillafc/videos',
  'Valencia': 'https://www.youtube.com/@valenciacf/videos',
  'Real Sociedad': 'https://www.youtube.com/@realsociedadtv/videos',
  'Juventus': 'https://www.youtube.com/@juventus/videos',
  'Inter Milan': 'https://www.youtube.com/@inter/videos',
  'AC Milan': 'https://www.youtube.com/@ACMilan/videos',
  'Napoli': 'https://www.youtube.com/@sscnapoli/videos',
  'Roma': 'https://www.youtube.com/@ASRoma/videos',
  'Lazio': 'https://www.youtube.com/@SSLazioOfficial/videos',
  'Bayern Munich': 'https://www.youtube.com/@FCBayern/videos',
  'Borussia Dortmund': 'https://www.youtube.com/@BVB/videos',
  'Bayer Leverkusen': 'https://www.youtube.com/@bayer04leverkusen/videos',
  'RB Leipzig': 'https://www.youtube.com/@RBLeipzig/videos',
  'Eintracht Frankfurt': 'https://www.youtube.com/@Eintracht/videos',
  'Wolfsburg': 'https://www.youtube.com/@VfLWolfsburg/videos',
  'Paris Saint-Germain': 'https://www.youtube.com/@PSG/videos',
  'Marseille': 'https://www.youtube.com/@OM/videos',
  'Lyon': 'https://www.youtube.com/@olympiquelyonnais/videos',
  'Monaco': 'https://www.youtube.com/@ASMONACO/videos',
  'Lille': 'https://www.youtube.com/@LOSC/videos',
  'Rennes': 'https://www.youtube.com/@staderennais/videos',
};
