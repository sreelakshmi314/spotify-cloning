import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/data/song_list.dart';
import 'package:spotify_cloning/model/song.dart';
import 'package:spotify_cloning/providers/songs_provider.dart';
import 'package:spotify_cloning/screens/library_screen.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final availableSongs = ref.watch(songsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: const Color.fromARGB(0, 1, 1, 11),
      ),
      body: GridView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.7,
        ),
        children: [
          for (final category in availableCategories)
            InkWell(
              onTap: () {
                List<Song> choosenSongList = availableSongs
                    .where((song) => song.categories.contains(category.id))
                    .toList();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => LibraryScreen(
                      title: category.title,
                      songs: choosenSongList,
                      categoryId: category.id,
                    ),
                  ),
                );
              },
              splashColor: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      category.color.withOpacity(1),
                      category.color.withOpacity(0.8)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  category.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
