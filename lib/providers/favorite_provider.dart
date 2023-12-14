import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/model/song.dart';

class FavoriteSongsNotifier extends StateNotifier<List<Song>> {
  FavoriteSongsNotifier() : super([]);

  bool toggleFavoriteStatus(Song song) {
    final isExisting = state.contains(song);
    if (isExisting) {
      state = state.where((e) => e.id != song.id).toList();
      return false;
    } else {
      state = [...state, song];
      return true;
    }
  }
}

final favoriteSongsProvider =
    StateNotifierProvider<FavoriteSongsNotifier, List<Song>>(
  (ref) => FavoriteSongsNotifier(),
);
