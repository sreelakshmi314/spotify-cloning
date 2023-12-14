import 'package:flutter/material.dart';
import 'package:spotify_cloning/model/song.dart';
import 'package:spotify_cloning/screens/album_screen.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.song,
    required this.categoryId,
  });

  final Song song;
  final String categoryId;

  @override
  Widget build(BuildContext context) {
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
                fit: BoxFit.cover
              ),
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
