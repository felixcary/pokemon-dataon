import 'package:flutter/material.dart';
import 'package:pokemon/providers/pokemon_detail_provider.dart';
import 'package:pokemon/styles/colors.dart';
import 'package:pokemon/utils/color_utils.dart';
import 'package:pokemon/utils/string_utils.dart';
import 'package:pokemon/widgets/cached_image.dart';
import 'package:pokemon/widgets/loading_widget.dart';
import 'package:provider/provider.dart';

part 'widgets/pokemon_detail_loading.dart';
part 'widgets/pokemon_detail_image.dart';
part 'widgets/pokemon_detail_info.dart';
part 'widgets/pokemon_detail_stats.dart';

class PokemonDetailView extends StatelessWidget {
  const PokemonDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonDetailProvider = Provider.of<PokemonDetailProvider>(context);
    if (pokemonDetailProvider.isLoading) {
      return const PokemonDetailLoading();
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: ColorUtil.getTypeColor(
                pokemonDetailProvider.pokemonDetail.types?.first.type.name ??
                    'normal',
              ),
              actions: [
                Consumer<PokemonDetailProvider>(
                  builder: (context, pokemonDetailProvider, child) {
                    return IconButton(
                      icon: Icon(
                        pokemonDetailProvider.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: pokemonDetailProvider.isFavorite
                            ? AppColors.red
                            : null,
                      ),
                      onPressed: () {
                        bool isAdd = true;
                        if (pokemonDetailProvider.isFavorite) {
                          isAdd = false;
                        }

                        pokemonDetailProvider.toggleFavoritePokemon(
                          pokemonSpecies:
                              pokemonDetailProvider.pokemonDetail.species!,
                          isAdd: isAdd,
                        );
                      },
                    );
                  },
                ),
              ],
              elevation: 0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PokemonDetailImage(
                    pokemonDetailProvider: pokemonDetailProvider,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PokemonDetailInfo(
                          pokemonDetailProvider: pokemonDetailProvider,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.50,
                                strokeAlign: BorderSide.strokeAlignCenter,
                                color: Colors.black.withOpacity(0.05),
                              ),
                            ),
                          ),
                        ),
                        PokemonDetailStats(
                          pokemonDetailProvider: pokemonDetailProvider,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
