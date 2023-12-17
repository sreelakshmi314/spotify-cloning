import 'package:flutter/material.dart';

import 'package:spotify_cloning/screens/home_screen.dart';
import 'package:spotify_cloning/screens/library_screen.dart';
import 'package:spotify_cloning/screens/search_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabScreen> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const HomeView();

    if (_selectedPageIndex == 1) {
      activeScreen = const SearchScreen();
    } else if (_selectedPageIndex == 2) {
      activeScreen = const LibraryScreen();
    }

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          // const Color.fromARGB(0, 1, 1, 11),
          selectedItemColor: Theme.of(context).colorScheme.onBackground,
          currentIndex: _selectedPageIndex,
          onTap: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.my_library_music),
              label: "Your Library",
            ),
          ],
        ),
        body: activeScreen);
  }
}
