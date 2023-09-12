import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon/models/pokemon_detail_model.dart';

class ApiService {
  static const baseUrl = 'https://pokeapi.co/api/v2';

  Future<List<String>> fetchPokemonTypes() async {
    final response = await http.get(Uri.parse('$baseUrl/type'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> typesDataList = data['results'];
      return typesDataList.map((json) => json['name'] as String).toList();
    } else {
      throw Exception('Failed to fetch Pokemon types');
    }
  }

  Future<List<PokemonSpecies>> fetchPokemonByType(String type) async {
    final response = await http.get(Uri.parse('$baseUrl/type/$type'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> pokemonDataList = data['pokemon'];

      List<PokemonSpecies> pokemonList = [];

      for (var entry in pokemonDataList) {
        final PokemonSpecies pokemonSpecies =
            PokemonSpecies.fromMap(entry['pokemon']);
        pokemonList.add(pokemonSpecies);
      }

      return pokemonList;
    } else {
      throw Exception('Failed to fetch Pokemon by type');
    }
  }

  Future<List<PokemonSpecies>> searchPokemon(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<PokemonSpecies> pokemonList = [];

      final PokemonSpecies pokemonSpecies = PokemonSpecies(
        name: data['name'],
        url: data['species']['url'],
      );
      pokemonList.add(pokemonSpecies);

      return pokemonList;
    } else {
      throw Exception('Failed to search Pokemon by name');
    }
  }

  Future<PokemonDetail> getPokemonByName(String name) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$name'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final PokemonDetail pokemonDetail = PokemonDetail.fromMap(data);

      return pokemonDetail;
    } else {
      throw Exception('Failed to fetch pokemon by name');
    }
  }
}
