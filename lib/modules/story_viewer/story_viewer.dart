import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../models/story.dart';
import 'cubit/story_viewer_cubit.dart';

class StoryViewer extends StatefulWidget {
  final List<Story> stories;

  StoryViewer({super.key, required this.stories});

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer>
    with SingleTickerProviderStateMixin {
  StoryViewerCubit _storyViewerCubit = StoryViewerCubit();
  PageController _pageController = PageController();
  // AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _storyViewerCubit = StoryViewerCubit();
    _pageController = PageController();

    return GestureDetector(
      onTapDown: (details) => loadAction(details, context),
      child: Stack(children: [
        PageView.builder(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.stories.length,
          itemBuilder: (context, i) {
            final Story story = widget.stories[i];
            return Container(
              decoration: BoxDecoration(
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0)),
            );
          },
        ),
      ]),
    );
  }

  loadAction(details, BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;

    int currentIndex = _storyViewerCubit.state;
    if (dx < screenWidth / 3) {
      if (currentIndex - 1 >= 0) {
        _storyViewerCubit.decrement();
      }
    } else if (dx > 2 * screenWidth / 3) {
      if (currentIndex + 1 < widget.stories.length) {
        _storyViewerCubit.increment();
      } else {
        // Out of bounds - loop story
        // You can also Navigator.of(context).pop() here
      }
    }

    print(_storyViewerCubit.state);
    _pageController.animateToPage(
      _storyViewerCubit.state,
      duration: const Duration(milliseconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
