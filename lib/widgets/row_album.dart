import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/data/song_list.dart';
import 'package:spotify_cloning/model/song.dart';
import 'package:spotify_cloning/providers/favorite_provider.dart';
import 'package:spotify_cloning/providers/songs_provider.dart';
import 'package:spotify_cloning/screens/album_screen.dart';

class RowAlbumCard extends ConsumerWidget {
  const RowAlbumCard({
    super.key,
    this.outputWidth = 0,
    this.outputHeight = 0,
    required this.isRowType,
    required this.outputCrossAxisCount,
    required this.outputCrossAxisSpacing,
    required this.outputMainAxisSpacing,
    required this.outputChildAspectRatio,
    required this.songs,
    required this.outputColor,
    this.categoryId = '',
    this.isIconShow = false,
  });

  final double outputWidth;
  final double outputHeight;
  final bool isRowType;
  final int outputCrossAxisCount;
  final double outputCrossAxisSpacing;
  final double outputMainAxisSpacing;
  final double outputChildAspectRatio;
  final Color outputColor;
  final List<Song> songs;
  final String categoryId;
  final bool isIconShow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardSize = MediaQuery.of(context).size.width / 2 - 30;
    final favoriteSongs = ref.watch(favoriteSongsProvider);
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

    return Container(
      padding: const EdgeInsets.all(1.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: outputCrossAxisCount,
          crossAxisSpacing: outputCrossAxisSpacing,
          mainAxisSpacing: outputMainAxisSpacing,
          childAspectRatio: outputChildAspectRatio,
        ),
        itemCount: songs.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AlbumScreen(
                  image: songs[index].imageUrl,
                  categoryId: categoryId,
                  song: songs[index],
                  songTitle: songs[index].title,
                  suggestedSongs: similarSongs,
                ),
              ),
            );
          },
          splashColor: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            // padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: outputColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(4),
            ),
            child: isRowType
                ? Row(
                    children: [
                      Image(
                        image: songs[index].imageUrl,
                        width: outputWidth == 0 ? cardSize : outputWidth,
                        height: outputHeight == 0 ? cardSize : outputHeight,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          songs[index].title,
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Spacer(),
                      if (isIconShow)
                        IconButton(
                          onPressed: () {
                            final isAdded = ref
                                .watch(favoriteSongsProvider.notifier)
                                .toggleFavoriteStatus(songs[index]);

                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                duration: const Duration(seconds: 3),
                                content: Text(
                                  isAdded
                                      ? 'Added to Liked Songs'
                                      : 'Removed from Liked Songs',
                                ),
                                elevation: 2,
                                behavior: SnackBarBehavior.floating,
                                // backgroundColor:
                                //     Theme.of(context).colorScheme.onBackground,
                              ),
                            );
                          },
                          icon: Icon(
                            favoriteSongs.contains(songs[index])
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                            color: favoriteSongs.contains(songs[index])
                                ? Theme.of(context).colorScheme.primary
                                : Color.fromARGB(49, 255, 255, 255),
                          ),
                        ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: songs[index].imageUrl,
                        width: outputWidth == 0 ? cardSize : outputWidth,
                        height: outputHeight == 0 ? cardSize : outputHeight,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        songs[index].title,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        songs[index].subTitle,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
