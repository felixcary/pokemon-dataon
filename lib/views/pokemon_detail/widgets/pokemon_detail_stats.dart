part of '../pokemon_detail_view.dart';

class PokemonDetailStats extends StatelessWidget {
  final PokemonDetailProvider pokemonDetailProvider;
  const PokemonDetailStats({super.key, required this.pokemonDetailProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            pokemonStatus(
              title: pokemonDetailProvider.pokemonDetail.stats![0].stat.name,
              value: pokemonDetailProvider.pokemonDetail.stats![0].baseStat
                  .toString(),
            ),
            const SizedBox(width: 20),
            pokemonStatus(
              title: pokemonDetailProvider.pokemonDetail.stats![1].stat.name,
              value: pokemonDetailProvider.pokemonDetail.stats![1].baseStat
                  .toString(),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            pokemonStatus(
              title: pokemonDetailProvider.pokemonDetail.stats![2].stat.name,
              value: pokemonDetailProvider.pokemonDetail.stats![2].baseStat
                  .toString(),
            ),
            const SizedBox(width: 20),
            pokemonStatus(
              title: pokemonDetailProvider.pokemonDetail.stats![3].stat.name,
              value: pokemonDetailProvider.pokemonDetail.stats![3].baseStat
                  .toString(),
            ),
          ],
        )
      ],
    );
  }

  Widget pokemonStatus({
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringUtil.capitalizeWords(title),
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.60,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  color: Colors.black.withOpacity(0.1),
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
