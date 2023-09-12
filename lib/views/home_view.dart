import 'package:flutter/material.dart';
import 'package:pokemon/providers/tab_provider.dart';
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
            currentIndex: tabProvider.currentIndex,
            onTap: (int index) {
              tabProvider.setCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                label: 'Favorite',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
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
        return const TabPage(title: 'Favorite');
      case 2:
        return const ProfileView(title: 'Profile');
      default:
        return Container();
    }
  }
}

class TabPage extends StatelessWidget {
  final String title;

  const TabPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }
}
