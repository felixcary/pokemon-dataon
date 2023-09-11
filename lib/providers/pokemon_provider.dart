import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokemon/services/api_service.dart';

class PokemonProvider with ChangeNotifier {
  final PokeApiService _apiService = PokeApiService();
  String selectedType = 'normal';

  List<String> _pokemonTypes = [];
  List<String> get pokemonTypes => _pokemonTypes;

  List<Map<String, dynamic>> _pokemonList = [];
  List<Map<String, dynamic>> get pokemonList => _pokemonList;

  PokemonProvider() {
    _fetchPokemonTypes();
    fetchPokemonByType(selectedType);
  }
  Future<void> fetchPokemonByType(String selectedType) async {
    try {
      _pokemonList = await _apiService.fetchPokemonByType(selectedType);
      notifyListeners();
    } catch (e) {
      log('Error fetching Pokémon types: $e');
    }
  }

  Future<void> _fetchPokemonTypes() async {
    try {
      _pokemonTypes = await _apiService.fetchPokemonTypes();
      notifyListeners();
    } catch (e) {
      log('Error fetching Pokémon types: $e');
    }
  }
}
