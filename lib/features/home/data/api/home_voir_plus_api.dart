import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:manga/features/home/data/models/home_voir_plus_model.dart';

final String apiUrl = 'https://api.jikan.moe/v4/seasons/now';

Future<List<HomeVoirPlusModel>> fetchAnimeData() async {
  try {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = convert.jsonDecode(
        response.body,
      );
      final List list = jsonResponse['data'];
      final List<HomeVoirPlusModel> homeAnime = list
          .map((item) => HomeVoirPlusModel.fromJson(item))
          .toList();
      return homeAnime;
    } else {
      throw Exception('Failed to load home data');
    }
  } catch (e) {
    throw Exception('Error fetching home data: $e');
  }
}
