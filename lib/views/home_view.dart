import 'package:flutter/material.dart';
import 'package:pokemon/providers/tab_provider.dart';
import 'package:pokemon/views/pokemon_favorite/pokemon_favorite_view.dart';
import 'package:pokemon/views/pokemon_list/pokemon_list_view.dart';
import 'package:pokemon/views/profile_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TabProvider>(
      create: (context) => TabProvider(),
      builder: (context, child) {
        final tabProvider = Provider.of<TabProvider>(context);
        return Scaffold(
          body: _buildPage(tabProvider.currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: const Color(0xFF173EA5),
            currentIndex: tabProvider.currentIndex,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            onTap: (int index) {
              tabProvider.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                activeIcon: Icon(Icons.favorite),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                activeIcon: Icon(Icons.account_circle),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return const PokemonListView();
      case 1:
        return const PokemonFavoriteView();
      case 2:
        return const ProfileView(title: 'Profile');
      default:
        return Container();
    }
  }
}
