import 'package:flutter/material.dart';
import 'package:pokemon/providers/pokemon_provider.dart';
import 'package:pokemon/utils/color_utils.dart';
import 'package:pokemon/utils/string_utils.dart';
import 'package:pokemon/widgets/cached_image.dart';
import 'package:provider/provider.dart';

class PokemonListView extends StatelessWidget {
  const PokemonListView({super.key});

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFFF2F2F2),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Pokémon...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                onChanged: (value) {},
              ),
              GestureDetector(
                onTap: () {
                  _showTypeBottomSheet(
                    context: context,
                    pokemonProvider: pokemonProvider,
                  );
                },
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: ShapeDecoration(
                    color: ColorUtil.getTypeColor(pokemonProvider.selectedType),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(49),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringUtil.capitalizeWords(
                          pokemonProvider.selectedType,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const SizedBox(
                        width: 10,
                        height: 24,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
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
        ),
      ),
    );
  }

  void _showTypeBottomSheet({
    required BuildContext context,
    required PokemonProvider pokemonProvider,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.1,
          maxChildSize: 0.71,
          expand: false,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final String type = pokemonProvider.pokemonTypes[index];
                  return GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      pokemonProvider.selectedType = type;

                      await pokemonProvider
                          .fetchPokemonByType(pokemonProvider.selectedType);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      decoration: ShapeDecoration(
                        color: ColorUtil.getTypeColor(type),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(49),
                        ),
                      ),
                      child: Text(
                        StringUtil.capitalizeWords(type),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemCount: pokemonProvider.pokemonTypes.length,
              ),
            );
          },
        );
      },
    );
  }
}
