import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/match.dart';
import '../utils/date_utils.dart';

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const _baseUrl = 'https://www.thesportsdb.com/api/v1/json/3/';
  final http.Client _client;

  Future<Match?> getLastMatch(String teamId) async {
    final uri = Uri.parse('${_baseUrl}eventslast.php?id=$teamId');

    for (var attempt = 1; attempt <= 3; attempt++) {
      try {
        final response = await _client.get(uri).timeout(const Duration(seconds: 25));
        if (response.statusCode < 200 || response.statusCode >= 300) {
          throw http.ClientException('HTTP ${response.statusCode}', uri);
        }

        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final results = json['results'];
        if (results is! List || results.isEmpty) return null;

        final item = results.first as Map<String, dynamic>;
        return Match(
          idEvent: item['idEvent'] as String?,
          eventName: (item['strEvent'] as String?) ?? 'Unknown match',
          date: parseApiDate(item['dateEvent'] as String?),
          homeTeam: (item['strHomeTeam'] as String?) ?? 'Home',
          awayTeam: (item['strAwayTeam'] as String?) ?? 'Away',
          homeScore: int.tryParse('${item['intHomeScore'] ?? ''}'),
          awayScore: int.tryParse('${item['intAwayScore'] ?? ''}'),
        );
      } catch (_) {
        if (attempt == 3) return null;
        await Future<void>.delayed(Duration(milliseconds: 350 * attempt));
      }
    }

    return null;
  }
}
