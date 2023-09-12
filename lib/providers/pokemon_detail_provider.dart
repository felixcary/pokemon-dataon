import 'package:flutter/foundation.dart';
import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:pokemon/services/api_service.dart';

class PokemonDetailProvider with ChangeNotifier {
  final ApiService apiService;

  PokemonDetailProvider({
    required this.apiService,
  }) : super();

  PokemonDetail _pokemonDetail = PokemonDetail();
  PokemonDetail get pokemonDetail => _pokemonDetail;
  bool isLoading = false;

  void _showLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> getPokemonByName(String pokemonName) async {
    _showLoading(true);
    try {
      _pokemonDetail = await apiService.getPokemonByName(pokemonName);
      _showLoading(false);
    } catch (e) {
      _showLoading(false);
    }
  }
}
