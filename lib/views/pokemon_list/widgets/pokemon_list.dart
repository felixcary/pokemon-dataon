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
                    StringUtil.getParsedUrl(pokemon['url']);
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFECF1F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
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
                              StringUtil.capitalizeWords(pokemon['name']),
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
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: CachedImage(
                          imageUrl: StringUtil.getImageUrl(
                            int.parse(
                              parsedUrl[1],
                            ),
                          ),
                        ),
                      )
                    ],
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
