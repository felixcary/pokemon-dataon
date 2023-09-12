part of '../pokemon_list_view.dart';

class PokemonList extends StatelessWidget {
  final PokemonProvider pokemonProvider;
  const PokemonList({super.key, required this.pokemonProvider});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          PokemonTypeSelection(pokemonProvider: pokemonProvider),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemCount: pokemonProvider.pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonProvider.pokemonList[index];
                final List<String> parsedUrl =
                    StringUtil.getParsedUrl(pokemon.url);
                return GestureDetector(
                  onTap: () {
                    App().router.navigateTo(
                          context,
                          pokemonDetailRoute.name,
                          routeSettings: RouteSettings(
                            arguments: {
                              'pokemonName': pokemon.name,
                            },
                          ),
                        );
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      color:
                          ColorUtil.getTypeColor(pokemonProvider.selectedType)
                              .withOpacity(0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'No ${parsedUrl[1]}',
                                  style: const TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  StringUtil.capitalizeWords(pokemon.name),
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 21,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: ShapeDecoration(
                                color: ColorUtil.getTypeColor(
                                    pokemonProvider.selectedType),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              height: 120,
                              width: 120,
                              child: CachedImage(
                                imageUrl: StringUtil.getImageUrl(
                                  int.parse(parsedUrl[1]),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: GestureDetector(
                                onTap: () {
                                  bool isAdd = true;
                                  if (pokemon.isFavorite) {
                                    isAdd = false;
                                  }

                                  pokemonProvider.toggleFavoritePokemon(
                                    pokemonSpecies: pokemon,
                                    isAdd: isAdd,
                                  );
                                },
                                child: Container(
                                  decoration: ShapeDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    shape: const OvalBorder(
                                      side: BorderSide(
                                        width: 0.75,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(
                                    pokemon.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 18,
                                    color: pokemon.isFavorite
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
