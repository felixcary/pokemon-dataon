import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/app.dart';
import 'package:pokemon/config/routes/app_routes.dart';
import 'package:pokemon/providers/pokemon_favorite_provider.dart';
import 'package:pokemon/utils/color_utils.dart';
import 'package:pokemon/utils/string_utils.dart';
import 'package:pokemon/widgets/cached_image.dart';
import 'package:pokemon/widgets/empty_state.dart';
import 'package:pokemon/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

part 'widgets/pokemon_list_favorite.dart';

class PokemonFavoriteView extends StatelessWidget {
  const PokemonFavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PokemonFavoriteProvider>(
      create: (context) =>
          GetIt.I.get<PokemonFavoriteProvider>()..getPokemonFavoriteList(),
      builder: (context, child) {
        final pokemonFavoriteProvider =
            Provider.of<PokemonFavoriteProvider>(context);
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  AppBar(
                    title: const Text(
                      'Favorite',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: const Border(
                      bottom: BorderSide(color: Color(0xFFF2F2F2), width: 1),
                    ),
                  ),
                  pokemonBodyView(
                    context: context,
                    pokemonFavoriteProvider: pokemonFavoriteProvider,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget pokemonBodyView({
    required BuildContext context,
    required PokemonFavoriteProvider pokemonFavoriteProvider,
  }) {
    if (pokemonFavoriteProvider.isLoading) {
      return const Expanded(child: Center(child: LoadingWidget()));
    }

    if (pokemonFavoriteProvider.pokemonList.isEmpty) {
      return const Expanded(
        child: Column(
          children: [
            EmptyState(),
          ],
        ),
      );
    }

    return PokemonListFavorite(
        pokemonFavoriteProvider: pokemonFavoriteProvider);
  }
}
