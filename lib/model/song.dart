import 'package:flutter/material.dart';

class Song {
  const Song({
    required this.id,
    required this.categories,
    required this.title,
    required this.imageUrl,
    required this.subTitle,
    required this.lyrics,
    required this.duration,
    required this.isRecommended,
    required this.isListened,
  });

  final String id;
  final List<String> categories;
  final String title;
  final ImageProvider imageUrl;
  final String subTitle;
  final List<String> lyrics;
  final double duration;
  final bool isRecommended;
  final bool isListened;
}
