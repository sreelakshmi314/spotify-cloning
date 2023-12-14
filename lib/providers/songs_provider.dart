import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_cloning/data/song_list.dart';

final songsProvider = Provider((ref) => dummySongs);
