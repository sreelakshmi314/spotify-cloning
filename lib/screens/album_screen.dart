import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/data/song_list.dart';
import 'package:spotify_cloning/model/song.dart';
import 'package:spotify_cloning/providers/songs_provider.dart';
import 'package:spotify_cloning/widgets/album_container.dart';
import 'package:spotify_cloning/widgets/animated_container.dart';
import 'package:spotify_cloning/widgets/row_album.dart';

class AlbumScreen extends ConsumerStatefulWidget {
  const AlbumScreen({
    super.key,
    required this.image,
    required this.categoryId,
    required this.song,
    required this.songTitle,
  });

  final ImageProvider image;
  final String categoryId;
  final Song song;
  final String songTitle;

  @override
  ConsumerState<AlbumScreen> createState() {
    return _AlbumScreenState();
  }
}

class _AlbumScreenState extends ConsumerState<AlbumScreen> {
  ScrollController? scrollController;
  double imageSize = 0;
  double initialSize = 240;
  double containerHeight = 500;
  double containerInitialHeight = 500;
  double imageOpacity = 1;
  bool showTopBar = false;

  @override
  void initState() {
    imageSize = initialSize;
    scrollController = ScrollController()
      ..addListener(() {
        imageSize = initialSize - scrollController!.offset;
        if (imageSize < 0) {
          imageSize = 0;
        }
        containerHeight = containerInitialHeight - scrollController!.offset;
        if (containerHeight < 0) {
          containerHeight = 0;
        }
        imageOpacity = imageSize / initialSize;
        if (scrollController!.offset > 224) {
          showTopBar = true;
        } else {
          showTopBar = false;
        }
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableSongs = ref.watch(songsProvider);
    List<Song> similarSongs = availableSongs
        .where(
          (song) => song.categories.contains(
            widget.categoryId.isEmpty ? 'c3' : widget.categoryId,
          ),
        )
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: containerHeight,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            color: Colors.pink,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Opacity(
                  opacity: imageOpacity.clamp(0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.5),
                          offset: const Offset(0, 20),
                          blurRadius: 32,
                          spreadRadius: 16,
                        )
                      ],
                    ),
                    child: Image(
                      image: widget.image,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  AlbumContainer(
                    initialSize: initialSize,
                    selectedSong: widget.song,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You might also like",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        RowAlbumCard(
                          songs: similarSongs,
                          isRowType: false,
                          outputCrossAxisCount: 2,
                          outputCrossAxisSpacing: 20,
                          outputMainAxisSpacing: 20,
                          outputChildAspectRatio: 0.80,
                          outputColor: const Color.fromARGB(0, 1, 1, 11),
                          categoryId: widget.categoryId,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          AnimationView(
            showTopBar: showTopBar,
            containerHeight: containerHeight,
            title: widget.songTitle,
          ),
        ],
      ),
    );
  }
}
