import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/data/song_list.dart';
import 'package:spotify_cloning/model/song.dart';
import 'package:spotify_cloning/providers/songs_provider.dart';
import 'package:spotify_cloning/screens/album_screen.dart';

class SongCard extends ConsumerWidget {
  const SongCard({
    super.key,
    required this.song,
    required this.categoryId,
  });

  final Song song;
  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableSongs = ref.watch(songsProvider);
    final categoryList = availableCategories;
    categoryList.shuffle();

    List<Song> similarSongs = availableSongs
        .where(
          (song) => song.categories.contains(categoryList
              .firstWhere(
                (e) => e.id != (categoryId.isEmpty ? 'c3' : categoryId),
              )
              .id),
        )
        .toList();

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlbumScreen(
              image: song.imageUrl,
              categoryId: categoryId,
              song: song,
              songTitle: song.title,
              suggestedSongs: similarSongs,
            ),
          ),
        );
      },
      child: SizedBox(
        width: 160,
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                  image: song.imageUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover),
              Text(
                song.subTitle,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
