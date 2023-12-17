import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/model/song.dart';
import 'package:spotify_cloning/providers/favorite_provider.dart';

class AlbumContainer extends ConsumerStatefulWidget {
  const AlbumContainer({
    super.key,
    required this.initialSize,
    required this.selectedSong,
  });

  final double initialSize;
  final Song selectedSong;

  @override
  ConsumerState<AlbumContainer> createState() {
    return _AlbumContainerState();
  }
}

class _AlbumContainerState extends ConsumerState<AlbumContainer> {
  @override
  Widget build(BuildContext context) {
    final favoriteSongs = ref.watch(favoriteSongsProvider);
    final isFavorite = favoriteSongs.contains(widget.selectedSong);

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0),
            Colors.black.withOpacity(0),
            Colors.black.withOpacity(1),
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            SizedBox(height: widget.initialSize + 32),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.selectedSong.title} - ${widget.selectedSong.subTitle}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage('assets/images/spotify_app_logo.png'),
                        width: 28,
                        height: 28,
                      ),
                      SizedBox(width: 8),
                      Text("Spotify")
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.schedule, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        '${widget.selectedSong.duration} min',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              final isAdded = ref
                                  .read(favoriteSongsProvider.notifier)
                                  .toggleFavoriteStatus(widget.selectedSong);

                              ScaffoldMessenger.of(context).clearSnackBars();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color: isFavorite
                                  ? Theme.of(context).colorScheme.primary
                                  : const Color.fromARGB(141, 255, 255, 255),
                            ),
                          ),
                          const Icon(Icons.more_horiz),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
