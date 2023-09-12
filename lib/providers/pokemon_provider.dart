import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokemon/services/api_service.dart';

class PokemonProvider with ChangeNotifier {
  final ApiService apiService;

  PokemonProvider({
    required this.apiService,
  }) : super();

  String selectedType = 'normal';
  bool isLoading = false;
  bool isSearching = false;
  Timer? _timer;

  List<String> _pokemonTypes = [];
  List<String> get pokemonTypes => _pokemonTypes;

  List<Map<String, dynamic>> _pokemonList = [];
  List<Map<String, dynamic>> get pokemonList => _pokemonList;

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
    if (name.isEmpty) {
      isSearching = false;
      fetchPokemonByType(selectedType);
      return;
    }

    if (_timer?.isActive ?? false) _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () async {
      try {
        _pokemonList = await apiService.searchPokemon(name);
        _showLoading(false);
      } catch (e) {
        _pokemonList = [];
        _showLoading(false);
      }
    });
  }
}
