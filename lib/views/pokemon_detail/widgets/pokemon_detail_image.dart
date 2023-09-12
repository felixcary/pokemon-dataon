part of '../pokemon_detail_view.dart';

class PokemonDetailImage extends StatelessWidget {
  final PokemonDetailProvider pokemonDetailProvider;
  const PokemonDetailImage({
    super.key,
    required this.pokemonDetailProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            color: ColorUtil.getTypeColor(
              pokemonDetailProvider.pokemonDetail.types?.first.type.name ??
                  'normal',
            ),
            borderRadius: BorderRadius.only(
              bottomLeft:
                  Radius.circular(MediaQuery.of(context).size.height * 0.6),
              bottomRight:
                  Radius.circular(MediaQuery.of(context).size.height * 0.6),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: CachedImage(
            imageUrl: StringUtil.getImageUrl(
              pokemonDetailProvider.pokemonDetail.id!,
            ),
          ),
        ),
      ],
    );
  }
}
