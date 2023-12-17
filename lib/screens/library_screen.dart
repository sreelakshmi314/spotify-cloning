import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/data/song_list.dart';
import 'package:spotify_cloning/model/song.dart';
import 'package:spotify_cloning/providers/favorite_provider.dart';
import 'package:spotify_cloning/providers/songs_provider.dart';
import 'package:spotify_cloning/widgets/row_album.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({
    super.key,
    this.title,
    this.songs,
    this.categoryId = '',
  });

  final String? title;
  final List<Song>? songs;
  final String categoryId;

  @override
  ConsumerState<LibraryScreen> createState() {
    return _LibraryScreenState();
  }
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final categoryList = availableCategories;
    categoryList.shuffle();

    final songsList = (widget.songs == null ||
            widget.songs!.isEmpty && widget.categoryId.isEmpty)
        ? ref.watch(favoriteSongsProvider)
        : widget.songs;

    final availableSongs = ref.watch(songsProvider);
    List<Song> similarSongs = availableSongs
        .where(
          (song) => song.categories.contains(
              categoryList.firstWhere((e) => e.id != widget.categoryId).id
              // widget.categoryId.isEmpty ? 'c3' : widget.categoryId,
              ),
        )
        .toList();

    Widget activeScreen = Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'This playlist is currently empty',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );

    if (songsList == null || songsList.isEmpty && widget.categoryId.isEmpty) {
      activeScreen = Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add music and podcasts',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Collect your favorites so you can listen whenever you want',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    }

    if (songsList!.isNotEmpty) {
      activeScreen = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RowAlbumCard(
              outputWidth: 55,
              outputHeight: 55,
              songs: songsList,
              isRowType: true,
              outputCrossAxisCount: 1,
              outputCrossAxisSpacing: 10,
              outputMainAxisSpacing: 10,
              outputChildAspectRatio: 7,
              outputColor: const Color.fromARGB(0, 1, 1, 11),
              categoryId: widget.categoryId,
              isIconShow: true,
            ),
            Container(
              // padding: const EdgeInsets.all(16),
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  if (similarSongs.isNotEmpty)
                    Text(
                      "You might also like",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  const SizedBox(height: 12),
                  if (similarSongs.isNotEmpty)
                    RowAlbumCard(
                      songs: similarSongs,
                      isRowType: false,
                      outputCrossAxisCount: 2,
                      outputCrossAxisSpacing: 20,
                      outputMainAxisSpacing: 20,
                      outputChildAspectRatio: 0.80,
                      outputColor: const Color.fromARGB(0, 1, 1, 11),
                      categoryId: '',
                    ),
                ],
              ),
            ),
          ],
        ),
      );
      // AlbumScrollList(
      //   title: 'Your Favorites',
      //   categoryId: '',
      //   songs: favoriteSongs,
      // )
    }

    return Scaffold(
      appBar: AppBar(
        title: Text((widget.title == null || widget.title!.isEmpty)
            ? 'Liked Songs'
            : widget.title!),
        backgroundColor: const Color.fromARGB(0, 1, 1, 11),
      ),
      body: activeScreen,
    );
  }
}
