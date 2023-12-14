import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/model/song.dart';
import 'package:spotify_cloning/providers/songs_provider.dart';
import 'package:spotify_cloning/widgets/song_card.dart';

class AlbumScrollList extends ConsumerWidget {
  const AlbumScrollList({
    super.key,
    required this.title,
    required this.categoryId,
    this.songs,
  });

  final String title;
  final List<Song>? songs;
  final String categoryId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableSongs = ref.watch(songsProvider);
    List<Song>? songList = songs;
    Widget? activeWidget;

    if ((songList == null || songList.isEmpty) && categoryId.isNotEmpty) {
      songList = availableSongs
          .where((song) => song.categories.contains(categoryId))
          .toList();
    }

    if (songList!.isNotEmpty || songList.length >= 3) {
      activeWidget = Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: songList.length,
                itemBuilder: (ctx, index) => SongCard(
                  song: songList![index],
                  categoryId: categoryId,
                ),
              ),
            ),
            // const SizedBox(height: 16),
          ],
        ),
      );
    }

    if (activeWidget == null) {
      return activeWidget = const SizedBox(height: 0);
    }

    return activeWidget;
  }
}
