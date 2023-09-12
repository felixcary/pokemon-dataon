import 'package:flutter/foundation.dart';
import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:pokemon/services/api_service.dart';
import 'package:pokemon/services/database_services.dart';

class PokemonDetailProvider with ChangeNotifier {
  final ApiService apiService;
  final DatabaseService databaseService;

  PokemonDetailProvider({
    required this.apiService,
    required this.databaseService,
  }) : super();

  PokemonDetail _pokemonDetail = PokemonDetail();
  PokemonDetail get pokemonDetail => _pokemonDetail;
  bool isLoading = false;
  bool isFavorite = false;

  void _showLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> getPokemonByName(String pokemonName) async {
    _showLoading(true);
    try {
      _pokemonDetail = await apiService.getPokemonByName(pokemonName);
      isFavorite = await databaseService.getPokemonFavoriteStatus(pokemonName);

      _showLoading(false);
    } catch (e) {
      _showLoading(false);
    }
  }

  void toggleFavoritePokemon({
    required PokemonSpecies pokemonSpecies,
    required bool isAdd,
  }) async {
    isFavorite = !isFavorite;
    await databaseService.removePokemonFromFavorite(pokemonSpecies.name);
    if (isAdd) {
      await databaseService.addPokemonToFavorite(pokemonSpecies);
    }
    notifyListeners();
  }
}
