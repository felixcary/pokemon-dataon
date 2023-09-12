part of '../pokemon_detail_view.dart';

class PokemonDetailLoading extends StatelessWidget {
  const PokemonDetailLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            const Expanded(
              child: LoadingWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
