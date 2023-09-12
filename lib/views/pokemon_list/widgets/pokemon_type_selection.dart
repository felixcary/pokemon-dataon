part of '../pokemon_list_view.dart';

class PokemonTypeSelection extends StatelessWidget {
  final PokemonProvider pokemonProvider;
  const PokemonTypeSelection({super.key, required this.pokemonProvider});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !pokemonProvider.isSearching,
      child: GestureDetector(
        onTap: () {
          _showTypeBottomSheet(
            context: context,
            pokemonProvider: pokemonProvider,
          );
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 16),
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
