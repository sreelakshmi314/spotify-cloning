import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    required this.subTitle,
    this.color = Colors.orange,
    required this.priority,
  });

  final String id;
  final String title;
  final String subTitle;
  final Color color;
  final int priority;
}
