part of '../pokemon_detail_view.dart';

class PokemonDetailInfo extends StatelessWidget {
  final PokemonDetailProvider pokemonDetailProvider;

  const PokemonDetailInfo({super.key, required this.pokemonDetailProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          StringUtil.capitalizeWords(
            pokemonDetailProvider.pokemonDetail.name!,
          ),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 32,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'No ${pokemonDetailProvider.pokemonDetail.id!}',
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 28,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              final type =
                  pokemonDetailProvider.pokemonDetail.types![index].type.name;
              return Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 14,
                ),
                decoration: BoxDecoration(
                  color: ColorUtil.getTypeColor(type),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  type.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            },
            itemCount: pokemonDetailProvider.pokemonDetail.types!.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(width: 4);
            },
          ),
        ),
      ],
    );
  }
}
