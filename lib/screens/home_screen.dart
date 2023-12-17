import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_cloning/data/song_list.dart';
import 'package:spotify_cloning/model/song.dart';
import 'package:spotify_cloning/providers/songs_provider.dart';
import 'package:spotify_cloning/widgets/album_scroll_list.dart';
import 'package:spotify_cloning/widgets/row_album.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  ConsumerState<HomeView> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final availableSongs = ref.watch(songsProvider);
    final categoryList = availableCategories;
    categoryList.sort(
      (a, b) => a.priority.compareTo(b.priority),
    );

    List<Song> listenedSongs =
        availableSongs.where((song) => song.isListened).toList();

    List<Song> popSongs =
        availableSongs.where((song) => song.categories.contains('c4')).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Good Evening'),
        backgroundColor: const Color.fromARGB(0, 1, 1, 11),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).colorScheme.background.withOpacity(0.4),
                    Theme.of(context).colorScheme.background.withOpacity(1)
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          RowAlbumCard(
                            outputWidth: 55,
                            outputHeight: 55,
                            songs: popSongs,
                            isRowType: true,
                            outputCrossAxisCount: 2,
                            outputCrossAxisSpacing: 10,
                            outputMainAxisSpacing: 10,
                            outputChildAspectRatio: 3.2,
                            outputColor: Colors.white10,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (final category in categoryList)
                      AlbumScrollList(
                        title: category.subTitle,
                        categoryId: category.id,
                      ),
                    AlbumScrollList(
                      title: 'Throw Back',
                      categoryId: '',
                      songs: listenedSongs,
                    ),
                     const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
