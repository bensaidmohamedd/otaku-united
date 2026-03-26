import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:manga/features/home/data/models/home_model.dart';

final String apiUrl = 'https://api.jikan.moe/v4/seasons/now';

Future<List<HomeModel>> fetchAnimeData() async {
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
      final List<HomeModel> homeAnime = list
          .map((item) => HomeModel.fromJson(item))
          .toList();
      return homeAnime;
    } else {
      throw Exception('Failed to load home data');
    }
  } catch (e) {
    throw Exception('Error fetching home data: $e');
  }
}
