import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:pokemon/services/api_service.dart';
import 'package:pokemon/services/database_services.dart';

class PokemonProvider with ChangeNotifier {
  final ApiService apiService;
  final DatabaseService databaseService;

  PokemonProvider({
    required this.apiService,
    required this.databaseService,
  }) : super();

  String selectedType = 'normal';
  bool isLoading = false;
  bool isSearching = false;
  Timer? _timer;

  List<String> _pokemonTypes = [];
  List<String> get pokemonTypes => _pokemonTypes;

  List<PokemonSpecies> _pokemonList = [];
  List<PokemonSpecies> get pokemonList => _pokemonList;

  init() {
    _fetchPokemonTypes();
    fetchPokemonByType(selectedType);
  }

  void _showLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> fetchPokemonByType(String selectedType) async {
    _showLoading(true);
    try {
      _pokemonList = await apiService.fetchPokemonByType(selectedType);

      for (var element in _pokemonList) {
        element.isFavorite = await getPokemonFavoriteStatus(element.name);
      }

      _showLoading(false);
    } catch (e) {
      _showLoading(false);
      log('Error fetching Pokémon types: $e');
    }
  }

  Future<void> _fetchPokemonTypes() async {
    _showLoading(true);
    try {
      _pokemonTypes = await apiService.fetchPokemonTypes();
      _showLoading(false);
    } catch (e) {
      log('Error fetching Pokémon types: $e');
    }
  }

  Future<void> searchPokemon(String name) async {
    isSearching = true;
    _showLoading(true);

    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () async {
      if (name.isEmpty) {
        isSearching = false;
        fetchPokemonByType(selectedType);
        return;
      }

      try {
        _pokemonList = await apiService.searchPokemon(name);
        _showLoading(false);
      } catch (e) {
        _pokemonList = [];
        _showLoading(false);
      }
    });
  }

  Future<bool> getPokemonFavoriteStatus(String pokemonName) async {
    return await databaseService.getPokemonFavoriteStatus(pokemonName);
  }

  void toggleFavoritePokemon({
    required PokemonSpecies pokemonSpecies,
    required bool isAdd,
  }) async {
    await databaseService.removePokemonFromFavorite(pokemonSpecies.name);
    if (isAdd) {
      await databaseService.addPokemonToFavorite(pokemonSpecies);
    }

    for (var element in _pokemonList) {
      element.isFavorite = await getPokemonFavoriteStatus(element.name);
    }
    notifyListeners();
  }
}
