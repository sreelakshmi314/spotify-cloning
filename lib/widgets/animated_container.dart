import 'package:flutter/material.dart';

class AnimationView extends StatelessWidget {
  const AnimationView({
    super.key,
    this.showTopBar = false,
    this.containerHeight = 500,
    required this.title,
  });

  final bool showTopBar;
  final double containerHeight;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        color: showTopBar
            ? const Color(0xFFC61855).withOpacity(1)
            : const Color(0xFFC61855).withOpacity(0),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: SafeArea(
          child: SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.keyboard_arrow_left,
                      size: 38,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: showTopBar ? 1 : 0,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 80 - containerHeight.clamp(120.0, double.infinity),
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          size: 38,
                        ),
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.shuffle,
                          color: Theme.of(context).colorScheme.background,
                          size: 14,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
