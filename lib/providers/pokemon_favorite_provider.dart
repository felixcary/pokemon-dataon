import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pokemon/models/pokemon_detail_model.dart';
import 'package:pokemon/services/database_services.dart';

class PokemonFavoriteProvider with ChangeNotifier {
  final DatabaseService databaseService;

  PokemonFavoriteProvider({
    required this.databaseService,
  }) : super();

  bool isLoading = false;

  List<PokemonSpecies> _pokemonList = [];
  List<PokemonSpecies> get pokemonList => _pokemonList;

  void _showLoading(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  Future<void> getPokemonFavoriteList() async {
    _showLoading(true);
    _pokemonList = await databaseService.getAllPokemonFavorite();
    for (var element in _pokemonList) {
      element.isFavorite = await getPokemonFavoriteStatus(element.name);
    }
    _showLoading(false);
  }

  void removeFavoritePokemon({required PokemonSpecies pokemonSpecies}) async {
    await databaseService.removePokemonFromFavorite(pokemonSpecies.name);
    _pokemonList = await databaseService.getAllPokemonFavorite();
    for (var element in _pokemonList) {
      element.isFavorite = await getPokemonFavoriteStatus(element.name);
    }

    notifyListeners();
  }

  Future<bool> getPokemonFavoriteStatus(String pokemonName) async {
    return await databaseService.getPokemonFavoriteStatus(pokemonName);
  }
}
