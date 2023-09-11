import 'dart:convert';
import 'package:http/http.dart' as http;

class PokeApiService {
  static const baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<String>> fetchPokemonTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/type'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> typesDataList = data['results'];
      return typesDataList.map((json) => json['name'] as String).toList();
    } else {
      throw Exception('Failed to fetch Pokémon types');
    }
  }

  Future<List<Map<String, dynamic>>> fetchPokemonByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/type/$type'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> pokemonDataList = data['pokemon'];

      List<Map<String, dynamic>> pokemonList = [];

      for (var entry in pokemonDataList) {
        String name = entry['pokemon']['name'];
        String url = entry['pokemon']['url'];

        pokemonList.add({
          'name': name,
          'url': url,
        });
      }

      return pokemonList;
    } else {
      throw Exception('Failed to fetch Pokémon by type');
    }
  }
}
