part of '../pokemon_list_view.dart';

class PokemonSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final PokemonProvider pokemonProvider;
  const PokemonSearchBar({
    super.key,
    required this.searchController,
    required this.pokemonProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonProvider>(builder: (context, authProvider, child) {
      return TextFormField(
        controller: searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xFFF2F2F2),
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          prefixIcon: const Icon(Icons.search),
          suffixIcon: Visibility(
            visible: pokemonProvider.isSearching,
            child: GestureDetector(
              onTap: () {
                searchController.clear();
                pokemonProvider.searchPokemon('');
              },
              child: const Icon(Icons.close),
            ),
          ),
          hintText: 'Search Pokémon...',
          hintStyle: const TextStyle(
            color: Color(0xFF999999),
            fontSize: 14,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        onChanged: (value) {
          pokemonProvider.searchPokemon(value);
        },
      );
    });
  }
}
