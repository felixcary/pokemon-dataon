import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon/providers/pokemon_provider.dart';
import 'package:pokemon/utils/color_utils.dart';
import 'package:pokemon/utils/string_utils.dart';
import 'package:pokemon/widgets/cached_image.dart';
import 'package:provider/provider.dart';

part 'widgets/pokemon_search_bar.dart';
part 'widgets/pokemon_type_selection.dart';
part 'widgets/empty_state.dart';
part 'widgets/pokemon_list.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return ChangeNotifierProvider<PokemonProvider>(
      create: (context) => GetIt.I.get<PokemonProvider>()..init(),
      builder: (context, child) {
        final pokemonProvider = Provider.of<PokemonProvider>(context);
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    PokemonSearchBar(
                      searchController: searchController,
                      pokemonProvider: pokemonProvider,
                    ),
                    pokemonBodyView(
                      context: context,
                      pokemonProvider: pokemonProvider,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget pokemonBodyView({
    required BuildContext context,
    required PokemonProvider pokemonProvider,
  }) {
    if (pokemonProvider.isLoading) {
      return const Expanded(child: Center(child: CircularProgressIndicator()));
    }

    if (pokemonProvider.pokemonList.isEmpty && pokemonProvider.isSearching) {
      return const EmptyState();
    }

    if (pokemonProvider.pokemonList.isEmpty) {
      return Expanded(
        child: Column(
          children: [
            PokemonTypeSelection(pokemonProvider: pokemonProvider),
            const EmptyState(),
          ],
        ),
      );
    }

    return PokemonList(pokemonProvider: pokemonProvider);
  }
}
